import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key, this.child});
  final String? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppIcons.noInternet, width: 300, height: 300),
            Text(
              'oops'.tr,
              // style: robotoBold.copyWith(
              //   fontSize: 30,
              //   color: Theme.of(context).textTheme.bodyLarge!.color,
              // ),
            ),
            const SizedBox(height: 12),
            Text(
              'no_internet_connection'.tr,
              textAlign: TextAlign.center,
              // style: robotoRegular.copyWith(
              //   color: Theme.of(context).disabledColor,
              // ),
            ),
            const SizedBox(height: 40),

            GestureDetector(
              onTap: () async {
                final connectivityResult = await Connectivity()
                    .checkConnectivity();

                if (!connectivityResult.contains(ConnectivityResult.none)) {
                  if (child != null) {
                    AppPages.login.offAll();
                  } else {
                    AppPages.login.offAll();
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  child: Center(
                    child: Icon(
                      Icons.refresh,
                      size: 34,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
