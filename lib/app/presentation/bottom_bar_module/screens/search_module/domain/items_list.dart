import 'package:flutter/material.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/widgets/item_card_widgets/items_widget.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.list,
    required this.isLoad,
    this.isScroll = true,
  });
  final List<Item> list;
  final bool isLoad;
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    return isScroll
        ? Expanded(
            child: !isLoad && list.isEmpty
                ? const Center(child: Text('No items found'))
                : isLoad
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: list.length,
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Divider(height: 32, color: context.color.grey),
                    ),
                    itemBuilder: (context, index) => ItemsWidget(
                      cartValue: 1,
                      isAddBtn: true,
                      item: list[index],
                      onCartTap: (isRemove) {},
                    ),
                  ),
          )
        : list.isEmpty
        ? Container(
            height: MediaQuery.sizeOf(context).height * .5,
            alignment: Alignment.center,
            child: !isLoad && list.isEmpty
                ? const Text('No items found')
                : const Center(child: CircularProgressIndicator()),
          )
        : ListView.separated(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: AppSizes.appPadding,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Divider(height: 32, color: context.color.grey),
            ),
            itemBuilder: (context, index) => ItemsWidget(
              cartValue: 1,
              isAddBtn: true,
              item: list[index],
              onCartTap: (isRemove) {},
            ),
          );
  }
}
