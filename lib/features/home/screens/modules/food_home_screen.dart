import 'package:flutter/material.dart';
import 'package:scan_sa_user/features/home/widgets/views/category_view.dart';
import 'package:scan_sa_user/features/home/widgets/views/best_reviewed_item_view.dart';
import 'package:scan_sa_user/features/home/widgets/views/best_store_nearby_view.dart';
import 'package:scan_sa_user/features/home/widgets/views/most_popular_item_view.dart';
import 'package:scan_sa_user/features/home/widgets/views/new_on_mart_view.dart';
import 'package:scan_sa_user/features/home/widgets/views/special_offer_view.dart';
import 'package:scan_sa_user/features/home/widgets/banner_view.dart';

class FoodHomeScreen extends StatelessWidget {
  const FoodHomeScreen({super.key, required this.fromBookTable});
  final bool fromBookTable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!fromBookTable) const BannerView(isFeatured: false),
        const CategoryView(),
        if (!fromBookTable) ...[
          const SpecialOfferView(isFood: true, isShop: false),
          // const HighlightWidget(),
          // const TopOffersNearMe(),
          const BestReviewItemView(),
          const BestStoreNearbyView(),
          // const ItemThatYouLoveView(forShop: false),
          const MostPopularItemView(isFood: true, isShop: false),
          // const JustForYouView(),
          const NewOnMartView(
            isNewStore: true,
          ),
        ],
      ],
    );
  }
}
