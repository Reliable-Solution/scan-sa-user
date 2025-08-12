import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/controllers/favorite_controller.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/app/widgets/restaurants_widget.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {
  final refreshController = RefreshController();

  void initCall() {
    Get.find<FavoriteController>().getFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    return CommonSubScreen(
      appBarTitle: 'favorite'.tr,
      isBack: false,
      child: GetBuilder<FavoriteController>(
        builder: (controller) {
          return SmartRefresher(
            controller: refreshController,
            onRefresh: () {
              controller.getFavoriteList().then((value) {
                refreshController.refreshCompleted();
              });
            },
            child:
                !controller.isFavoriteLoad && controller.wishStoreList.isEmpty
                ? const Center(
                    child: Text('No store available in your wish list'),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.appPadding,
                    ),
                    itemCount: controller.isFavoriteLoad
                        ? 10
                        : controller.wishStoreList.length,
                    itemBuilder: (context, index) {
                      final data = controller.isFavoriteLoad
                          ? null
                          : controller.wishStoreList[index];
                      return RestaurantsWidget(index: index, store: data);
                    },
                  ),
          );
        },
      ),
    );
  }
}
