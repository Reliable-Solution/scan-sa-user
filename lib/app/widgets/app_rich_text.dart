import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/app/theme/app_theme.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class AppRichText extends StatelessWidget {
  const AppRichText({
    super.key,
    required this.text1,
    required this.text2,
    this.text3,
    this.text4,
    this.textStyle1,
    this.textStyle2,
    this.onTap1,
    this.onTap2,
  });
  final String text1;
  final String text2;
  final String? text3;
  final String? text4;
  final TextStyle? textStyle1;
  final TextStyle? textStyle2;
  final Function()? onTap1;
  final Function()? onTap2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style:
            (textStyle1 ??
                    context.style.s14w700.copyWith(
                      color: context.color.lightText,
                    ))
                .copyWith(fontFamily: FontFamily.satoshi),
        children: [
          TextSpan(
            text: text2,
            style:
                (textStyle2 ??
                        context.style.s14w700.copyWith(
                          color: context.color.blueColor,
                        ))
                    .copyWith(fontFamily: FontFamily.satoshi),
            recognizer: TapGestureRecognizer()..onTap = onTap1,
          ),
          if (text3 != null)
            TextSpan(
              text: text3,
              style:
                  (textStyle1 ??
                          context.style.s14w700.copyWith(
                            color: context.color.lightText,
                          ))
                      .copyWith(fontFamily: FontFamily.satoshi),
            ),

          TextSpan(
            text: text4,
            style:
                (textStyle2 ??
                        context.style.s14w700.copyWith(
                          color: context.color.blueColor,
                        ))
                    .copyWith(fontFamily: FontFamily.satoshi),
            recognizer: TapGestureRecognizer()..onTap = onTap2,
          ),
        ],
      ),
    );
  }
}
