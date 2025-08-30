import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/features/language/controllers/language_controller.dart';
import 'package:scan_sa_user/features/language/domain/models/language_model.dart';
import 'package:scan_sa_user/util/app_constants.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';

class LanguageCardWidget extends StatelessWidget {
  const LanguageCardWidget({
    super.key,
    required this.languageModel,
    required this.localizationController,
    required this.index,
    this.fromBottomSheet = false,
    this.fromWeb = false,
  });
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  final bool fromBottomSheet;
  final bool fromWeb;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (fromBottomSheet) {
          localizationController.setLanguage(
            Locale(
              AppConstants.languages[index].languageCode!,
              AppConstants.languages[index].countryCode,
            ),
            fromBottomSheet: fromBottomSheet,
          );
        }
        localizationController.setSelectLanguageIndex(index);
      },
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        decoration: !fromWeb
            ? BoxDecoration(
                color: localizationController.selectedLanguageIndex == index
                    ? context.color.secondary.withValues(alpha: 0.05)
                    : null,
                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                border: localizationController.selectedLanguageIndex == index
                    ? Border.all(
                        color: context.color.secondary,
                      )
                    : null,
              )
            : BoxDecoration(
                color: localizationController.selectedLanguageIndex == index
                    ? context.color.secondary.withValues(alpha: 0.05)
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                border: Border.all(
                  color: localizationController.selectedLanguageIndex == index
                      ? context.color.secondary.withValues(alpha: 0.2)
                      : Theme.of(context).disabledColor.withValues(alpha: 0.3),
                ),
              ),
        child: Row(
          children: [
            Image.asset(languageModel.imageUrl!, width: 36, height: 36),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Text(
              languageModel.languageName!,
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
            const Spacer(),
            localizationController.selectedLanguageIndex == index
                ? Icon(
                    Icons.check_circle,
                    color: context.color.secondary,
                    size: 25,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
