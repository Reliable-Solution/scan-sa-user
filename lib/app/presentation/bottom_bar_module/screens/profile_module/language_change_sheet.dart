import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/selection_circle.dart';
import 'package:scan_sa_user/l10n/locale.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

void showChangeLanSheet() {
  Get.bottomSheet(const LanguageChangeSheet());
}

class LanguageChangeSheet extends StatefulWidget {
  const LanguageChangeSheet({super.key});

  @override
  State<LanguageChangeSheet> createState() => _LanguageChangeSheetState();
}

class _LanguageChangeSheetState extends State<LanguageChangeSheet> {
  String lanCode = '';

  @override
  void initState() {
    lanCode = Get.find<GlobalController>().locale.value.languageCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.color.whiteLight,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.appPadding,
            vertical: 20,
          ).copyWith(bottom: MediaQuery.paddingOf(context).bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.l10n.chooseLanguage, style: context.style.s22w700),
              Text(
                context.l10n.chooseLanguageToProceed,
                style: context.style.s14w600.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.color.darkTextGrey,
                ),
              ),
              const SizedBox(height: 20),
              lanWidget(
                context,
                lanCode: 'en',
                icon: AppIcons.english,
                lan: 'English',
              ),
              lanWidget(
                context,
                lanCode: 'ar',
                icon: AppIcons.arabic,
                lan: 'Arabic',
              ),
              const SizedBox(height: 20),
              AppButton(
                label: 'Update',
                onPressed: () {
                  Get.back();
                  LocalizationService.updateLocale(lanCode);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget lanWidget(
    BuildContext context, {
    required String lanCode,
    required String icon,
    required String lan,
  }) {
    return GestureDetector(
      onTap: () => setState(() => this.lanCode = lanCode),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          spacing: 10,
          children: [
            Image.asset(icon, width: 40),
            Text(lan, style: context.style.s16w700),
            const Spacer(),
            SelectionCircle(isSelected: this.lanCode == lanCode),
          ],
        ),
      ),
    );
  }
}
