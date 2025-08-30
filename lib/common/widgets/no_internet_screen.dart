import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/images.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.noInternet, width: 300, height: 300),
            Text(
              'oops'.tr,
              style: robotoBold.copyWith(
                fontSize: 30,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text(
              'no_internet_connection'.tr,
              textAlign: TextAlign.center,
              style: robotoRegular.copyWith(
                color: Theme.of(context).disabledColor,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () async {
                final List<ConnectivityResult> connectivityResult =
                    await Connectivity().checkConnectivity();

                if (!connectivityResult.contains(ConnectivityResult.none)) {
                  try {
                    Get.off(child);
                  } catch (e) {
                    Get.offAllNamed(RouteHelper.getInitialRoute());
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.color.secondary,
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
