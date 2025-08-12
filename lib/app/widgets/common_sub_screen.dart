import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class CommonSubScreen extends StatelessWidget {
  const CommonSubScreen({
    super.key,
    this.btnText,
    required this.appBarTitle,
    required this.child,
    this.isBack = true,
    this.onTap,
    this.backColor,
  }) : assert(
         (btnText == null && onTap == null) ||
             (btnText != null && onTap != null),
         'Please provide both onTap and btn text',
       );
  final String? btnText;
  final Color? backColor;
  final String appBarTitle;
  final Widget child;
  final bool isBack;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      bottomNavigationBar: btnText != null && onTap != null
          ? AppButton(isBottomPad: true, label: btnText!, onPressed: onTap!)
          : null,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leadingWidth: isBack ? AppSizes.appPadding + 40 : 0,
        leading: isBack
            ? Padding(
                padding: EdgeInsets.only(left: AppSizes.appPadding),
                child: const BackBtn(),
              )
            : const SizedBox.shrink(),
        title: Text(appBarTitle, style: context.style.s22w700),
      ),
      body: child,
    );
  }
}

class CommonSubAppBarScreen extends StatelessWidget {
  const CommonSubAppBarScreen({
    super.key,
    required this.title,
    required this.child,
    this.bottomBtn,
  });
  final String title;
  final Widget child;
  final Widget? bottomBtn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.find<GlobalController>().isDark
          ? context.color.whiteLight
          : context.color.fff5f5f5,
      bottomNavigationBar: bottomBtn,
      body: Column(
        children: [
          ColoredBox(
            color: context.color.white,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 10,
                bottom: 6,
                right: AppSizes.appPadding,
                left: AppSizes.appPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: SvgAssets(
                      AppIcons.arrowBackIc,
                      color: context.color.primary,
                    ),
                  ),
                  Text(title, style: context.style.s22w700),
                  Opacity(
                    opacity: 0,
                    child: SvgAssets(
                      AppIcons.arrowBackIc,
                      color: context.color.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.color.white,
                  context.color.white.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
