import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

void showAppDialog(
  BuildContext context, {
  required String title,
  required String icon,
  required String description,
  String? yesString,
  required Function() onYesTap,
}) {
  // showDialog(context: context, builder: (context) => const AppDialog());
  Get.dialog(
    AppDialog(
      title: title,
      icon: icon,
      description: description,
      onYesTap: onYesTap,
      yesString: yesString,
    ),
  );
}

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    required this.onYesTap,
    required this.yesString,
  });
  final String title;
  final String icon;
  final String description;
  final String? yesString;
  final Function() onYesTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.color.whiteLight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: CircleAvatar(radius: 50),
              ),
              Text(
                title,
                style: context.style.s22w700,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  description,
                  style: context.style.s16w500,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Yes',
                      btnColor: context.color.grey,
                      txtColor: context.color.primary,
                      onPressed: onYesTap,
                      buttonType: ButtonType.white,
                    ),
                  ),
                  Expanded(
                    child: AppButton(label: 'No', onPressed: Get.back),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
