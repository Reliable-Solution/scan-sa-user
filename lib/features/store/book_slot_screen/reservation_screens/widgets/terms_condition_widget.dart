import 'package:flutter/material.dart';
import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/util/app_sizes.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/images.dart';

class TermsConditionWidget extends StatefulWidget {
  const TermsConditionWidget({super.key});

  @override
  State<TermsConditionWidget> createState() => _TermsConditionWidgetState();
}

class _TermsConditionWidgetState extends State<TermsConditionWidget> {
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 14,
          color: context.color.grey,
          margin: const EdgeInsets.symmetric(vertical: 20),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpand = !isExpand;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Terms & conditions',
                          style: context.style.s18w700.copyWith(
                            color: context.color.primary,
                          ),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: isExpand ? 2 : 0,
                        child: SvgAssets(Images.arrowBottomIc, height: 9),
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpand)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    '1.Reservation Confirmation\nYour reservation is confirmed only once you receive a confirmation message/email from us. Walk-ins will be seated based on availability.\n'
                    '2. Reservation Timing\nPlease arrive on time. We hold your table for 15 minutes past the reserved time. After that, we may release it to other guests.\n'
                    '3. Group Reservations\nFor parties of more than 6 guests, a deposit or advance notice may be required. Custom arrangements like decorations or cakes must be informed in advance.',
                    style: context.style.s16w700.copyWith(
                      color: context.color.ff9c9c9c,
                    ),
                  ),
                ),
              Divider(height: 24, color: context.color.borderColor),
            ],
          ),
        ),
      ],
    );
  }
}
