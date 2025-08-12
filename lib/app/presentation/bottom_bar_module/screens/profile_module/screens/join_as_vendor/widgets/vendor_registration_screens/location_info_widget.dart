import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/select_location_view_widget.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class LocationInfoWidget extends StatelessWidget {
  const LocationInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreRegistrationController>(
      builder: (storeController) {
        return Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'location_info'.tr,
              style: context.style.s18w700.copyWith(
                color: context.color.primary,
              ),
            ),
            SelectLocationViewWidget(
              fromView: true,
              addressController: TextEditingController(),
            ),
          ],
        );
      },
    );
  }
}
