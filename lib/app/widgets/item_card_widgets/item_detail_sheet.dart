import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/widgets/cart_btn.dart';
import 'package:scan_sa_user/app/widgets/common_sheet.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_strings.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

void showItemDetailSheet(Item item) {
  Get.bottomSheet(ItemDetailSheet(item: item), isScrollControlled: true);
}

class ItemDetailSheet extends StatefulWidget {
  const ItemDetailSheet({super.key, required this.item});
  final Item item;

  @override
  State<ItemDetailSheet> createState() => _ItemDetailSheetState();
}

class _ItemDetailSheetState extends State<ItemDetailSheet> {
  Map<String, dynamic> variantData = {};
  int? cartIndex;
  num? variantPrice;
  final cartController = Get.find<CartController>();
  @override
  void initState() {
    widget.item.choiceOptions?.forEach(
      (element) =>
          variantData.addAll({'${element.name}': element.options?.firstOrNull}),
    );
    variantPrice = widget.item.variations?.firstOrNull?.price;
    selectedVariant = variantData.values.join('-');
    cartIndex = cartController.isExistInCart(
      widget.item.id,
      selectedVariant,
      false,
      null,
    );
    isAlreadyCart();
    super.initState();
  }

  void selectVariant(String option, String name) {
    setState(() {
      variantData[name.trim()] = option.trim();
      selectedVariant = variantData.values.join('-');
      cartIndex = cartController.isExistInCart(
        widget.item.id,
        selectedVariant,
        false,
        null,
      );
      variantPrice = widget.item.variations
          ?.where((e) => e.type == selectedVariant)
          .firstOrNull
          ?.price;

      isAlreadyCart();
    });
  }

  String selectedVariant = '';
  int cartValue = 0;

  bool isAlreadyCart() {
    final cartData = Get.find<CartController>().cartList.where((element) {
      return element.variation?.firstOrNull?.type == selectedVariant;
    }).toList();
    cartValue = cartData.firstOrNull?.quantity ?? 0;
    cartIndex = cartController.isExistInCart(
      widget.item.id,
      selectedVariant,
      false,
      null,
    );
    return cartData.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return GetBuilder<CartController>(
      builder: (cartController) {
        return CommonSheet(
          padding: EdgeInsets.zero,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: (item.imagesFullUrl?.firstOrNull?.isEmpty ?? true)
                  ? Image.asset(
                      AppIcons.logo,
                      height: MediaQuery.sizeOf(context).width * .5,
                      width: double.infinity,
                    )
                  : Image.network(
                      item.imagesFullUrl?.firstOrNull ?? '',
                      height: MediaQuery.sizeOf(context).width * .5,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.appPadding,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name ?? '',
                          style: context.style.s20w900.copyWith(
                            color: context.color.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '${AppStrings.dinar} ${variantPrice ?? item.price ?? 0}',
                        style: context.style.s20w900,
                      ),
                    ],
                  ),
                  ReadMoreText(
                    item.description ?? '',
                    trimMode: TrimMode.Line,
                    trimLines: 3,
                  ),
                  Divider(color: context.color.darkTextGrey, height: 40),
                  if ((widget.item.variations?.isNotEmpty ?? false) &&
                      (widget.item.choiceOptions?.isNotEmpty ?? false))
                    ...widget.item.choiceOptions?.map(
                          (e) => Column(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.name ?? '',
                                style: context.style.s18w700.copyWith(
                                  color: context.color.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                child: ListView.builder(
                                  itemCount: e.options?.length ?? 0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final option = e.options?[index];
                                    final isSelected =
                                        variantData[e.name ?? ''] ==
                                        option?.trim();

                                    return GestureDetector(
                                      onTap: () => selectVariant(
                                        option ?? '',
                                        e.name ?? '',
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                          bottom: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: isSelected
                                              ? context.color.primary
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: context.color.primary,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        child: Text(
                                          (e.options?[index] ?? '').trim(),
                                          style: context.style.s16w500.copyWith(
                                            color: isSelected
                                                ? context.color.white
                                                : null,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : null,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ) ??
                        [],
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: CartBtn(
                      cartValue: cartValue,
                      height: 50,
                      color: context.color.primary,
                      textColor: context.color.white,
                      isAddBtn: !isAlreadyCart(),
                      onTapAdd: () => cartController
                          .itemDirectlyAddToCart(
                            item,
                            context,
                            variation: widget.item.variations
                                ?.where(
                                  (element) => element.type == selectedVariant,
                                )
                                .toList(),
                          )
                          .then((value) => isAlreadyCart()),
                      onTap: (isRemove) => (cartValue == 1 && isRemove)
                          ? cartController.removeFromCart(cartIndex ?? 0)
                          : cartController.setQuantity(
                              !isRemove,
                              cartIndex ?? 0,
                              10,
                              10,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
