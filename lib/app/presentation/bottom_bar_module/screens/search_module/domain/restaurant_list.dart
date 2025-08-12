import 'package:flutter/material.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/widgets/restaurants_widget.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    super.key,
    required this.list,
    required this.isLoad,
    this.isScroll = true,
  });
  final List<Store> list;
  final bool isLoad;
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    return isScroll
        ? Expanded(
            child: !isLoad && list.isEmpty
                ? const Center(child: Text('No restaurant found'))
                : isLoad
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: list.length,
                    itemBuilder: (context, index) =>
                        RestaurantsWidget(index: index),
                  ),
          )
        : list.isEmpty
        ? Container(
            height: MediaQuery.sizeOf(context).height * .5,
            alignment: Alignment.center,
            child: !isLoad && list.isEmpty
                ? const Text('No restaurant found')
                : const Center(child: CircularProgressIndicator()),
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: AppSizes.appPadding,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) =>
                RestaurantsWidget(index: index, store: list[index]),
          );
  }
}
