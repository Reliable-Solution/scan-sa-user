import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class CommonAuthScreen extends StatelessWidget {
  const CommonAuthScreen({
    super.key,
    required this.children,
    this.isRegisterScreen = false,
    this.icon,
    this.title,
    this.description,
  }) : assert(
         (isRegisterScreen ||
             (icon != null && title != null && description != null)),
         'Please add icons, title and description values',
       );
  final List<Widget> children;
  final bool isRegisterScreen;
  final String? icon;
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: context.padding.top + AppSizes.topPad,
              bottom: 10,
              left: AppSizes.appPadding,
              right: AppSizes.appPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: CircleAvatar(
                    backgroundColor: context.color.grey,
                    child: SvgAssets(AppIcons.arrowBackIc),
                  ),
                ),
                if (isRegisterScreen) ...[
                  Text(context.l10n.signUp, style: context.style.s30w700),
                  const CircleAvatar(backgroundColor: Colors.transparent),
                ],
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.appPadding,
                vertical: 10,
              ),
              child: Column(
                children: [
                  if (!isRegisterScreen) ...[
                    SvgAssets(icon!),
                    Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: context.style.s24w700,
                    ),
                    Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: context.style.s18w700,
                    ),
                  ],
                  ...children,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
