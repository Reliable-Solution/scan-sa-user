import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/app/presentation/location_module/controller/location_controller.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/prediction_model.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class LocationSearchDialogWidget extends StatelessWidget {
  const LocationSearchDialogWidget({
    super.key,
    required this.mapController,
    this.isPickedUp,
    this.isFrom = false,
  });
  final GoogleMapController? mapController;
  final bool? isPickedUp;
  final bool isFrom;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Container(
      width: 500,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: TypeAheadField(
            controller: controller,

            // textCapitalization: TextCapitalization.words,
            // autofocus: true,
            // textInputAction: TextInputAction.search,
            // keyboardType: TextInputType.streetAddress,
            // decoration: InputDecoration(
            //   hintText: 'search_location'.tr,
            //   border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(10),
            //     borderSide: const BorderSide(style: BorderStyle.none, width: 0),
            //   ),
            //   hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
            //     fontSize: Dimensions.fontSizeDefault,
            //     color: Theme.of(context).disabledColor,
            //   ),
            //   filled: true,
            //   fillColor: Theme.of(context).cardColor,
            // ),
            // style: Theme.of(context).textTheme.displayMedium!.copyWith(
            //   color: Theme.of(context).textTheme.bodyLarge!.color,
            //   fontSize: Dimensions.fontSizeLarge,
            // ),
            suggestionsCallback: (pattern) async {
              return Get.find<LocationController>().searchLocation(
                context,
                pattern,
              );
            },
            builder: (context, controller, focusNode) => AppTextField(
              hintText: 'search_location'.tr,
              controller: controller,
              focusNode: focusNode,
              suffixIcon: IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.close),
              ),
            ),
            decorationBuilder: (context, child) => DecoratedBox(
              decoration: BoxDecoration(
                color: context.color.whiteLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: child,
            ),

            itemBuilder: (context, PredictionModel suggestion) {
              return Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Row(
                  spacing: 8,
                  children: [
                    Icon(Icons.location_on, color: context.color.primary),
                    Expanded(
                      child: Text(
                        suggestion.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.style.s16w500,
                      ),
                    ),
                  ],
                ),
              );
            },

            onSelected: (PredictionModel value) {
              if (isPickedUp == null) {
                Get.find<LocationController>().setLocation(
                  value.placeId,
                  value.description,
                  mapController,
                );
              } else {
                // Get.find<ParcelController>().setLocationFromPlace(
                //   value.placeId,
                //   value.description,
                //   isPickedUp,
                // );
              }
              Get.back();
            },
          ),
        ),
      ),
    );
  }
}
