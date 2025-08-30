import 'package:scan_sa_user/features/category/controllers/category_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/app_sizes.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_image.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (splashController) {
        return GetBuilder<CategoryController>(
          builder: (categoryController) {
            return (categoryController.categoryList != null &&
                    categoryController.categoryList!.isEmpty)
                ? const SizedBox()
                : FoodCategoryView(
                    categoryController: categoryController,
                  );
          },
        );
      },
    );
  }
}

class FoodCategoryView extends StatelessWidget {
  const FoodCategoryView({super.key, required this.categoryController});
  final CategoryController categoryController;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              height: 120,
              child: categoryController.categoryList != null
                  ? ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeDefault,
                      ),
                      itemCount: categoryController.categoryList!.length > 10
                          ? 10
                          : categoryController.categoryList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeDefault,
                            right: Dimensions.paddingSizeDefault,
                            top: Dimensions.paddingSizeDefault,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (index == 9 &&
                                  categoryController.categoryList!.length >
                                      10) {
                                Get.toNamed(RouteHelper.getCategoryRoute());
                              } else {
                                Get.toNamed(
                                  RouteHelper.getCategoryItemRoute(
                                    categoryController.categoryList![index].id,
                                    categoryController
                                        .categoryList![index].name!,
                                  ),
                                );
                              }
                            },
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusSmall),
                            child: SizedBox(
                              width: 60,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                        child: CustomImage(
                                          image:
                                              '${categoryController.categoryList![index].imageFullUrl}',
                                          height: 60,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      (index == 9 &&
                                              categoryController
                                                      .categoryList!.length >
                                                  10)
                                          ? Positioned(
                                              right: 0,
                                              left: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(100),
                                                  ),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Theme.of(context)
                                                          .primaryColor
                                                          .withValues(
                                                            alpha: 0.4,
                                                          ),
                                                      Theme.of(context)
                                                          .primaryColor
                                                          .withValues(
                                                            alpha: 0.6,
                                                          ),
                                                      Theme.of(context)
                                                          .primaryColor
                                                          .withValues(
                                                            alpha: 0.4,
                                                          ),
                                                    ],
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '+${categoryController.categoryList!.length - 10}',
                                                    style:
                                                        robotoMedium.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeExtraLarge,
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  Expanded(
                                    child: Text(
                                      (index == 9 &&
                                              categoryController
                                                      .categoryList!.length >
                                                  10)
                                          ? 'see_all'.tr
                                          : categoryController
                                                  .categoryList![index].name ??
                                              '',
                                      style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: (index == 9 &&
                                                categoryController
                                                        .categoryList!.length >
                                                    10)
                                            ? context.color.secondary
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : FoodCategoryShimmer(categoryController: categoryController),
            ),
          ],
        ),
      ],
    );
  }
}

class FoodCategoryShimmer extends StatelessWidget {
  const FoodCategoryShimmer({super.key, required this.categoryController});
  final CategoryController categoryController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        left: Dimensions.paddingSizeDefault,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: Dimensions.paddingSizeDefault,
            left: Dimensions.paddingSizeDefault,
            top: Dimensions.paddingSizeDefault,
          ),
          child: SizedBox(
            width: 60,
            child: Column(
              spacing: 6,
              children: [
                ClipOval(
                  child: Shimmer(
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ),
                ),
                Shimmer(
                  child: Container(
                    height: 10,
                    width: 50,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PharmacyCategoryShimmer extends StatelessWidget {
  const PharmacyCategoryShimmer({super.key, required this.categoryController});
  final CategoryController categoryController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: Dimensions.paddingSizeDefault,
            left: Dimensions.paddingSizeDefault,
            top: Dimensions.paddingSizeDefault,
          ),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            enabled: true,
            child: Container(
              width: 70,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      bottom: Dimensions.paddingSizeSmall,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Expanded(
                    child: Container(
                      height: 10,
                      width: 50,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
