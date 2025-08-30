import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/util/styles.dart';

class RatingProgressWidget extends StatelessWidget {
  const RatingProgressWidget({
    super.key,
    required this.ratingNumber,
    required this.ratingPercent,
    required this.progressValue,
  });
  final String ratingNumber;
  final num ratingPercent;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);

    return Row(
      children: [
        Text(
          ratingNumber,
          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(
          child: LinearProgressIndicator(
            minHeight: isDesktop
                ? Dimensions.paddingSizeSmall
                : Dimensions.paddingSizeExtraSmall,
            value: progressValue,
            backgroundColor: Theme.of(context).hintColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            valueColor: AlwaysStoppedAnimation<Color>(context.color.secondary),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          width: 30,
          child: Text(
            '${ratingPercent.toStringAsFixed(0)}%',
            style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .color
                  ?.withValues(alpha: 0.5),
            ),
          ),
        ),
      ],
    );
  }
}
