import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_strings.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

enum ButtonType { white, yellow, green, black, red }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.btnColor,
    this.isBottomPad = false,
    this.txtColor,
    this.buttonType = ButtonType.black,
    this.textStyle,
  });
  final String label;
  final Function() onPressed;
  final Color? btnColor;
  final Color? txtColor;
  final TextStyle? textStyle;
  final bool isBottomPad;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    // final greenBtnColor = ;
    final shadowData = buttonType == ButtonType.green
        ? _greenShadow
        : buttonType == ButtonType.red
        ? _redShadow
        : buttonType == ButtonType.yellow
        ? _yellowShadow
        : buttonType == ButtonType.white
        ? _whiteShadow
        : _blackShadow;
    return Padding(
      padding: isBottomPad ? AppPadding.bottomPad(context) : EdgeInsets.zero,
      child: GestureDetector(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 55.h,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: btnColor ?? context.color.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    label,
                    style:
                        textStyle ??
                        context.style.s18w700.copyWith(
                          color: txtColor ?? context.color.white,
                        ),
                  ),
                ),

                /// left shadow
                Container(
                  height: 40.h,
                  width: .1,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 10,
                  ),
                  decoration: shadowData.left,
                ),

                /// top shadow
                Container(
                  height: .1,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: shadowData.top,
                ),

                /// right shadow
                Positioned(
                  right: 0,
                  child: Container(
                    height: 40.h,
                    width: 1,

                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7.5.h,
                    ),
                    decoration: shadowData.right,
                  ),
                ),

                /// bottom shadow
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: .1,
                    // width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: shadowData.bottom,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final _blackShadow = BoxShadowModel(
  top: BoxDecoration(
    color: const Color(0xFFD4D4D4).withValues(alpha: .21),
    boxShadow: [
      BoxShadow(
        blurRadius: 7.8,
        spreadRadius: 4,
        color: const Color(0xffb5b5b5).withValues(alpha: .28),
      ),
    ],
  ),
  bottom: BoxDecoration(
    color: Colors.black26,
    boxShadow: [
      BoxShadow(
        blurRadius: 12.2,
        spreadRadius: 4,
        color: Colors.black.withValues(alpha: .35),
      ),
    ],
  ),
  right: BoxDecoration(
    color: const Color(0xFFA0a0a0).withValues(alpha: .06),
    boxShadow: [
      BoxShadow(
        blurRadius: 7,
        spreadRadius: 4,
        color: const Color(0xff787878).withValues(alpha: .37),
      ),
    ],
  ),
  left: BoxDecoration(
    color: const Color(0xFFA0a0a0).withValues(alpha: .06),
    boxShadow: [
      BoxShadow(
        blurRadius: 6,
        spreadRadius: 4,
        color: const Color(0xff7c7c7c).withValues(alpha: .17),
      ),
    ],
  ),
);

final _greenShadow = BoxShadowModel(
  top: BoxDecoration(
    color: const Color(0xFFD4D4D4).withValues(alpha: .40.h),
    boxShadow: [
      BoxShadow(
        blurRadius: 7.8,
        spreadRadius: 4,
        color: const Color(0xffb5b5b5).withValues(alpha: .28),
      ),
    ],
  ),
  bottom: BoxDecoration(
    color: Colors.black12,
    boxShadow: [
      BoxShadow(
        blurRadius: 12.2,
        spreadRadius: 4,
        color: Colors.black.withValues(alpha: .35),
      ),
    ],
  ),
  right: BoxDecoration(
    color: const Color(0xFFA0a0a0).withValues(alpha: .08),
    boxShadow: [
      BoxShadow(
        blurRadius: 7,
        spreadRadius: 4,
        color: const Color(0xff787878).withValues(alpha: .39),
      ),
    ],
  ),
  left: BoxDecoration(
    color: const Color(0xff7c7c7c).withValues(alpha: .17),
    boxShadow: [
      BoxShadow(
        blurRadius: 6,
        spreadRadius: 4,
        color: const Color(0xff7c7c7c).withValues(alpha: .17),
      ),
    ],
  ),
);

final _redShadow = BoxShadowModel(
  top: BoxDecoration(
    color: Colors.red,
    boxShadow: [
      BoxShadow(
        blurRadius: 7.8,
        spreadRadius: 4,
        color: Colors.white.withValues(alpha: .28),
      ),
    ],
  ),
  bottom: BoxDecoration(
    color: Colors.black26,
    boxShadow: [
      BoxShadow(
        blurRadius: 12.2,
        spreadRadius: 4,
        color: Colors.black.withValues(alpha: .25),
      ),
    ],
  ),
  right: BoxDecoration(
    color: const Color(0xFFa0a0a0).withValues(alpha: .06),
    boxShadow: [
      BoxShadow(
        blurRadius: 7,
        spreadRadius: 4,
        color: const Color(0xff7c7c7c).withValues(alpha: .25),
      ),
    ],
  ),
  left: BoxDecoration(
    color: const Color(0xFFa0a0a0).withValues(alpha: .06),
    boxShadow: [
      BoxShadow(
        blurRadius: 7,
        spreadRadius: 4,
        color: const Color(0xff787878).withValues(alpha: .25),
      ),
    ],
  ),
);

final _yellowShadow = BoxShadowModel(
  top: BoxDecoration(
    color: const Color(0xFFF7CC36),
    boxShadow: [
      BoxShadow(
        blurRadius: 5,
        spreadRadius: 3,
        color: Colors.white.withValues(alpha: .25),
      ),
    ],
  ),
  bottom: const BoxDecoration(
    color: Color(0xFFF9B701),
    // boxShadow: [
    //   BoxShadow(blurRadius: 7, spreadRadius: 3, color: Color(0xffF8B701)),
    // ],
  ),
  right: const BoxDecoration(
    color: Color(0xFFF9B701),
    boxShadow: [
      BoxShadow(blurRadius: 8, spreadRadius: 2, color: Color(0xffF8B701)),
    ],
  ),
  left: const BoxDecoration(
    color: Color(0xFFF9B701),
    boxShadow: [
      BoxShadow(blurRadius: 8, spreadRadius: 2, color: Color(0xffF8B701)),
    ],
  ),
);

final _whiteShadow = BoxShadowModel(
  top: BoxDecoration(
    color: const Color(0xFFF5F5F5),
    boxShadow: [
      BoxShadow(
        blurRadius: 7.8,
        spreadRadius: 4,
        color: Colors.white.withValues(alpha: .9),
      ),
    ],
  ),
  bottom: BoxDecoration(
    color: const Color(0xFFF5F5F5).withValues(alpha: .21),
    boxShadow: [
      BoxShadow(
        blurRadius: 12.2,
        spreadRadius: 4,
        color: Colors.black.withValues(alpha: .05),
      ),
    ],
  ),
  right: BoxDecoration(
    color: const Color(0xFFa0a0a0).withValues(alpha: .06),
    boxShadow: [
      BoxShadow(
        blurRadius: 6,
        spreadRadius: 4,
        color: const Color(0xfff5f5f5).withValues(alpha: .05),
      ),
    ],
  ),
  left: BoxDecoration(
    color: const Color(0xFFF5F5F5).withValues(alpha: .06),
    boxShadow: [
      BoxShadow(
        blurRadius: 7,
        spreadRadius: 4,
        color: const Color(0xff787878).withValues(alpha: .05),
      ),
    ],
  ),
);

class BoxShadowModel {
  BoxShadowModel({
    required this.top,
    required this.bottom,
    required this.right,
    required this.left,
  });
  final BoxDecoration top;
  final BoxDecoration bottom;
  final BoxDecoration right;
  final BoxDecoration left;
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final String icon;
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: context.color.borderColor, width: 2),
            ),
            child: Text(
              label,
              style: context.style.s18w700.copyWith(
                color: context.color.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgAssets(
              icon,
              color: label == context.l10n.apple ? context.color.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}

class BackBtn extends StatelessWidget {
  const BackBtn({super.key, this.btnColor, this.iconColor, this.onTap});
  final Color? btnColor;
  final Color? iconColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
        Get.back();
      },
      child: Hero(
        tag: AppStrings.backBtnTag,
        child: CircleAvatar(
          backgroundColor: btnColor ?? context.color.grey,
          child: SvgAssets(
            AppIcons.arrowBackIc,
            color: iconColor ?? context.color.primary,
          ),
        ),
      ),
    );
  }
}
