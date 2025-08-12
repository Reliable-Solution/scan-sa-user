import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/api/api_checker.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/common/models/error_response.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetxService {
  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token);
    if (kDebugMode) {
      debugPrint('Token: $token');
    }
    AddressModel? addressModel;
    try {
      addressModel = AddressModel.fromJson(
        jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!)
            as Map<String, dynamic>,
      );
    } catch (_) {}
    int? moduleID;
    if (GetPlatform.isWeb &&
        sharedPreferences.containsKey(AppConstants.moduleId)) {
      try {
        moduleID = ModuleModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.moduleId)!)
              as Map<String, dynamic>,
        ).id;
      } catch (_) {}
    }
    updateHeader(
      token: token,
      zoneIDs: addressModel?.zoneIds,
      operationIds: addressModel?.areaIds,
      languageCode: sharedPreferences.getString(AppConstants.languageCode),
      moduleID: moduleID,
      latitude: addressModel?.latitude,
      longitude: addressModel?.longitude,
    );
  }
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 40;

  String? token;
  late Map<String, String> _mainHeaders;

  Map<String, String> updateHeader({
    String? token,
    List<int>? zoneIDs,
    List<int>? operationIds,
    String? languageCode,
    int? moduleID,
    String? latitude,
    String? longitude,
    bool setHeader = true,
  }) {
    final header = <String, String>{};

    if (moduleID != null ||
        sharedPreferences.getString(AppConstants.cacheModuleId) != null) {
      header.addAll({
        AppConstants.moduleId:
            '${moduleID ?? ModuleModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.cacheModuleId)!) as Map<String, dynamic>).id}',
      });
    }
    header.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.zoneId: zoneIDs != null ? jsonEncode(zoneIDs) : '',
      AppConstants.moduleId: '1',

      ///this will add in ride module
      // AppConstants.operationAreaId: operationIds != null ? jsonEncode(operationIds) : '',
      AppConstants.localizationKey:
          languageCode ?? AppConstants.languages[0].languageCode!,
      AppConstants.latitude: latitude != null ? jsonEncode(latitude) : '',
      AppConstants.longitude: longitude != null ? jsonEncode(longitude) : '',
      'Authorization': 'Bearer $token',
    });
    if (setHeader) {
      _mainHeaders = header;
    }
    return header;
  }

  void printCurl(
    String method,
    Uri uri,
    Map<String, String> headers, [
    dynamic body,
  ]) {
    final headerStrings = headers.entries
        .map((e) => "-H '${e.key}: ${e.value}'")
        .join(' ');
    var curl = "curl -X $method '$uri' $headerStrings";
    if (body != null) {
      curl += " -d '${jsonEncode(body)}'";
    }
    log('CURL: $curl');
  }

  Map<String, String> getHeader() => _mainHeaders;

  Future<Response<dynamic>> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    bool handleError = true,
  }) async {
    try {
      final fullUri = Uri.parse(
        appBaseUrl + uri,
      ).replace(queryParameters: query);
      final requestHeaders = headers ?? _mainHeaders;

      printCurl('GET', fullUri, requestHeaders);

      final response = await http
          .get(fullUri, headers: requestHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri, handleError: handleError);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('------------$e');
      }
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response<dynamic>> postData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
    int? timeout,
    bool handleError = true,
  }) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? _mainHeaders}');
      debugPrint('====> API Body: $body');

      final newBody = <dynamic, dynamic>{};
      if (body != null) {
        body.forEach((key, value) {
          if (value != null && value.toString().isNotEmpty) {
            newBody.addAll({key: value});
          }
        });
      }
      final fullUri = Uri.parse(appBaseUrl + uri);
      final requestHeaders = headers ?? _mainHeaders;
      printCurl('POST', fullUri, requestHeaders, newBody);
      final response = await http
          .post(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(newBody),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeout ?? timeoutInSeconds));
      return handleResponse(response, uri, handleError: handleError);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response<dynamic>> postMultipartData(
    String uri,
    Map<String, String?> body,
    List<MultipartBody> multipartBody, {
    Map<String, String>? headers,
    bool handleError = true,
  }) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? _mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} picture');
      final fullUri = Uri.parse(appBaseUrl + uri);
      final newBody1 = <String, String>{};
      body.forEach((s, i) {
        if (i?.isNotEmpty ?? false) {
          newBody1.addAll({s: i ?? ''});
        }
      });

      printCurl('POST', fullUri, headers ?? _mainHeaders, newBody1);

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(appBaseUrl + uri),
      );
      request.headers.addAll(headers ?? _mainHeaders);
      for (final multipart in multipartBody) {
        if (multipart.file != null) {
          final list = await multipart.file!.readAsBytes();
          request.files.add(
            http.MultipartFile(
              multipart.key,
              multipart.file!.readAsBytes().asStream(),
              list.length,
              filename: '${DateTime.now()}.png',
            ),
          );
        }
      }
      final newBody = <String, String>{};
      body.forEach((s, i) {
        if (i?.isNotEmpty ?? false) {
          newBody.addAll({s: i ?? ''});
        }
      });
      request.fields.addAll(newBody);
      final response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri, handleError: handleError);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response<dynamic>> putData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
    bool handleError = true,
  }) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? _mainHeaders}');
      debugPrint('====> API Body: $body');
      final fullUri = Uri.parse(appBaseUrl + uri);
      final requestHeaders = headers ?? _mainHeaders;

      printCurl('PUT', fullUri, requestHeaders, body);
      final response = await http
          .put(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError: handleError);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response<dynamic>> deleteData(
    String uri, {
    Map<String, String>? headers,
    bool handleError = true,
  }) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? _mainHeaders}');
      final fullUri = Uri.parse(appBaseUrl + uri);
      final requestHeaders = headers ?? _mainHeaders;

      printCurl('DELETE', fullUri, requestHeaders);
      final response = await http
          .delete(Uri.parse(appBaseUrl + uri), headers: headers ?? _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError: handleError);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response<dynamic> handleResponse(
    http.Response response,
    String uri, {
    bool handleError = false,
  }) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {}
    var response0 = Response(
      body: body ?? response.body,
      bodyString: response.body,
      request: Request(
        headers: response.request!.headers,
        method: response.request!.method,
        url: response.request!.url,
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      if (response0.body.toString().startsWith('{errors: [{code:')) {
        final errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: errorResponse.errors![0].message,
        );
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText:
              (response0.body as Map<String, dynamic>?)?['message'] as String?,
        );
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }

    debugPrint('====> API Response: [${response0.statusCode}] $uri');
    if (response.statusCode != 500) {
      debugPrint('${response0.body}');
    }
    if (handleError) {
      if (response0.statusCode == 200) {
        return response0;
      } else {
        ApiChecker.checkApi(response0);
        return const Response();
      }
    } else {
      return response0;
    }
  }
}

class MultipartBody {
  MultipartBody(this.key, this.file);
  String key;
  XFile? file;
}
