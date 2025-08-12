import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/models/business_plan_body.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/repositories/business_repo_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/services/business_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/package_model.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class BusinessService implements BusinessServiceInterface {
  BusinessService({required this.businessRepoInterface});
  final BusinessRepoInterface businessRepoInterface;

  @override
  Future<PackageModel?> getPackageList() async {
    return (await businessRepoInterface.getList()) as PackageModel?;
  }

  @override
  Future<String> processesBusinessPlan(
    String businessPlanStatus,
    int paymentIndex,
    int storeId,
    String? digitalPaymentName,
    int? selectedPackageId,
  ) async {
    // if (packageModel!.packages!.isNotEmpty) {
    //
    //
    //
    // } else if(packageModel.packages!.isEmpty && packageModel.packages!.isEmpty){
    //   showCustomSnackBar('no_package_found'.tr);
    // } else {
    //   showCustomSnackBar('please Select Any Process');
    // }
    const businessPlan = 'subscription';
    final packageId = selectedPackageId;
    final payment = paymentIndex == 0 ? 'free_trial' : digitalPaymentName;
    // final hostname = html.window.location.hostname;
    // final protocol = html.window.location.protocol;

    if (paymentIndex == 1 && digitalPaymentName == null) {
      showCustomSnackBar('please_select_payment_method'.tr);
    } else {
      await setUpBusinessPlan(
        BusinessPlanBody(
          businessPlan: businessPlan,
          packageId: packageId.toString(),
          storeId: storeId.toString(),
          payment: payment,
          paymentGateway: payment,
          callBack: paymentIndex == 0 ? '' : AppRoutes.subscriptionSuccess,
          paymentPlatform: GetPlatform.isWeb ? 'web' : 'app',
          type: 'new_join',
        ),
        digitalPaymentName,
        businessPlanStatus,
        storeId,
      );
    }
    return businessPlanStatus;
  }

  @override
  Future<String> setUpBusinessPlan(
    BusinessPlanBody businessPlanBody,
    String? digitalPaymentName,
    String businessPlanStatus,
    int storeId,
  ) async {
    final response = await businessRepoInterface.setUpBusinessPlan(
      businessPlanBody,
    );
    if (response.statusCode == 200) {
      if (response.body['redirect_link'] != null) {
        await _subscriptionPayment(
          response.body['redirect_link'] as String,
          digitalPaymentName,
          storeId,
        );
      } else {
        AppPages.subscriptionSuccess.offAll(arguments: {'success': true});
        // const newBusinessPlanStatus = 'complete';
        // Get.find<HomeController>().saveRegistrationSuccessfulSharedPref(true);
        // Get.find<HomeController>().saveIsStoreRegistrationSharedPref(true);
        // Get.offAllNamed(
        //   RouteHelper.getSubscriptionSuccessRoute(
        //     status: 'success',
        //     fromSubscription: true,
        //     storeId: storeId,
        //   ),
        // );
      }
    }
    return businessPlanStatus;
  }

  Future<void> _subscriptionPayment(
    String redirectUrl,
    String? digitalPaymentName,
    int storeId,
  ) async {
    AppPages.paymentWebView.push(
      arguments: {'url': redirectUrl, 'forSubscription': true},
    );
    // Get.back();
    // Get.toNamed(RouteHelper.getPaymentRoute(OrderModel(), digitalPaymentName, subscriptionUrl: redirectUrl, guestId: Get.find<AuthController>().getGuestId(), storeId: storeId));
    // Get.toNamed(
    //   RouteHelper.getPaymentRoute(
    //     '0',
    //     0,
    //     '',
    //     0,
    //     false,
    //     digitalPaymentName,
    //     subscriptionUrl: redirectUrl,
    //     guestId: AuthHelper.getGuestId(),
    //     storeId: storeId,
    //   ),
    // );
  }
}
