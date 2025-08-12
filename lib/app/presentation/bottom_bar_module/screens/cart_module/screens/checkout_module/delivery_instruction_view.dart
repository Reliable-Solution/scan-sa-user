import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/controllers/checkout_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class DeliveryInstructionView extends StatefulWidget {
  const DeliveryInstructionView({super.key});

  @override
  State<DeliveryInstructionView> createState() =>
      _DeliveryInstructionViewState();
}

class _DeliveryInstructionViewState extends State<DeliveryInstructionView> {
  ExpansibleController controller = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.color.borderColor, width: 2),
        borderRadius: BorderRadius.circular(10),
        color: Get.find<GlobalController>().isDark
            ? context.color.whiteLight
            : null,
      ),
      margin: const EdgeInsets.only(top: 20),
      child: GetBuilder<CheckoutController>(
        builder: (orderController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  key: widget.key,
                  controller: controller,
                  title: Text(
                    'add_more_delivery_instruction'.tr,
                    style: context.style.s16w700.copyWith(
                      color: context.color.ff9c9c9c,
                    ),
                  ),
                  trailing: Icon(
                    orderController.isExpanded ? Icons.remove : Icons.add,
                    size: 18,
                  ),
                  onExpansionChanged: (value) =>
                      orderController.expandedUpdate(value),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: AppConstants.deliveryInstructionList.length,
                      itemBuilder: (context, index) {
                        final isSelected =
                            orderController.selectedInstruction == index;
                        return InkWell(
                          onTap: () {
                            orderController.setInstruction(index);
                            if (controller.isExpanded) {
                              controller.collapse();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(
                                      context,
                                    ).primaryColor.withValues(alpha: 0.5)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusSmall,
                              ),
                            ),
                            padding: const EdgeInsets.all(
                              Dimensions.paddingSizeSmall,
                            ),
                            margin: const EdgeInsets.all(
                              Dimensions.paddingSizeExtraSmall,
                            ),
                            child: Row(
                              spacing: Dimensions.paddingSizeSmall,
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
                                  size: 18,
                                ),
                                Expanded(
                                  child: Text(
                                    AppConstants
                                        .deliveryInstructionList[index]
                                        .tr,
                                    style: context.style.s14w600.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: isSelected
                                          ? context.color.primary
                                          : Theme.of(context).disabledColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (orderController.selectedInstruction != -1)
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: orderController.isExpanded
                        ? Dimensions.paddingSizeSmall
                        : 0,
                    horizontal: 20,
                  ).add(const EdgeInsets.only(bottom: 10)),
                  child: Row(
                    children: [
                      Text(
                        AppConstants
                            .deliveryInstructionList[orderController
                                .selectedInstruction]
                            .tr,
                        style: context.style.s16w700,
                      ),
                      InkWell(
                        onTap: () => orderController.setInstruction(-1),
                        child: Icon(
                          Icons.clear,
                          size: 16,
                          color: context.color.primary,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
