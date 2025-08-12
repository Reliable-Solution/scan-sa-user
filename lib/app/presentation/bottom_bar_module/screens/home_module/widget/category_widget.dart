import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/provider/home_controller.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/circular_shimmer.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/rectangular_shimmer.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Obx(() {
      final categoryList = homeController.categoryList.value;
      final isLoading = homeController.isCategoryLoading.value;
      return (categoryList?.isEmpty ?? true)
          ? const SizedBox()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.appPadding,
                  ).copyWith(top: 20),
                  child: Row(
                    spacing: 10,
                    children: [
                      Text(
                        "WHAT'S ON YOUR MIND?",
                        style: context.style.s14w700,
                      ),
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                context.color.borderColor,
                                context.color.white,
                              ],
                            ),
                          ),
                          child: const SizedBox(height: 2),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 8),
                  height: 105,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.appPadding,
                    ),
                    scrollDirection: Axis.horizontal,
                    children: categoryList!.map((e) {
                      return GestureDetector(
                        onTap: () {
                          if (!isLoading) {
                            AppPages.categoryDetailScreen.push(
                              arguments: {
                                'categoryId': e.id?.toString() ?? '',
                                'categoryName': e.name?.toString() ?? '',
                              },
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            spacing: 4,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (!isLoading)
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundColor: context.color.grey,
                                    ),
                                  if (!isLoading)
                                    if (e.imageFullUrl?.isNotEmpty ?? false)
                                      Image.network(
                                        e.imageFullUrl ?? '',
                                        width: 60,
                                        height: 60,
                                      )
                                    else
                                      Image.asset(
                                        AppIcons.logo,
                                        width: 60,
                                        height: 60,
                                      )
                                  else
                                    const CircularShimmer(size: 30),
                                ],
                              ),
                              if (isLoading)
                                const RectangularShimmer(height: 10, width: 60)
                              else
                                Text(
                                  e.name ?? '',
                                  style: context.style.s12w700,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
    });
  }
}
