import 'package:scan_sa_user/features/search/controllers/search_controller.dart'
    as search;
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/common/widgets/footer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/common/widgets/item_view.dart';
import 'package:scan_sa_user/common/widgets/web_item_view.dart';

class ItemViewWidget extends StatelessWidget {
  const ItemViewWidget({super.key, required this.isItem});
  final bool isItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<search.SearchController>(
        builder: (searchController) {
          return SingleChildScrollView(
            child: FooterView(
              child: SizedBox(
                width: Dimensions.webMaxWidth,
                child: ResponsiveHelper.isDesktop(context)
                    ? WebItemsView(
                        isStore: isItem,
                        items: searchController.searchItemList,
                        stores: searchController.searchStoreList,
                      )
                    : ItemsView(
                        isStore: isItem,
                        items: searchController.searchItemList,
                        stores: searchController.searchStoreList,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
