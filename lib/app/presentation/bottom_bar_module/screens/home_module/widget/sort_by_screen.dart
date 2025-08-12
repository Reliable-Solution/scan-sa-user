import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/provider/home_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/common_sheet.dart';
import 'package:scan_sa_user/app/widgets/selection_circle.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

void showSortBySheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => const SortBySheet(),
  );
}

class SortBySheet extends StatefulWidget {
  const SortBySheet({super.key});

  @override
  State<SortBySheet> createState() => _SortBySheetState();
}

class _SortBySheetState extends State<SortBySheet> {
  final selectedSort = ValueNotifier(0);
  List<({String icon, String title})> get sortList => [
    (icon: AppIcons.recommendedIc, title: context.l10n.recommended),
    (icon: AppIcons.nearMeIc, title: 'Popular'),
    (icon: AppIcons.ratingsIc, title: context.l10n.ratings),
    (icon: AppIcons.nearMeIc, title: 'Newly joined'),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectedSort.value = Get.find<HomeController>().selectedSort.value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      padding: EdgeInsets.all(AppSizes.appPadding),
      children: [
        Text(context.l10n.sortBy, style: context.style.s24w700),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          itemCount: sortList.length,
          padding: const EdgeInsets.only(bottom: 30, top: 20),
          itemBuilder: (context, index) {
            return ValueListenableBuilder<int>(
              valueListenable: selectedSort,
              builder: (context, selectedSort, child) {
                final isSelected = selectedSort == index + 1;
                return GestureDetector(
                  onTap: () {
                    this.selectedSort.value = index + 1;
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      spacing: 12,
                      children: [
                        SvgAssets(sortList[index].icon, width: 24, height: 24),
                        Text(
                          sortList[index].title,
                          style: context.style.s18w700.copyWith(
                            color: context.color.ff6c6c6c,
                          ),
                        ),
                        const Spacer(),
                        SelectionCircle(isSelected: isSelected),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) =>
              Divider(color: context.color.grey, height: 0),
        ),
        AppButton(
          label: context.l10n.showResult,
          onPressed: () => Get.find<HomeController>().changeSortSelection(
            selectedSort.value,
          ),
        ),
      ],
    );
  }
}
