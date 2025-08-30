import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/util/app_sizes.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';

class CommonSheet extends StatelessWidget {
  const CommonSheet({super.key, required this.children, this.padding});
  final List<Widget> children;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          GestureDetector(
            onTap: Get.back,
            child: CircleAvatar(
              backgroundColor: context.color.primary.withValues(alpha: .5),
              child: const Icon(Icons.close_rounded, color: Color(0xFFE6E6E6)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.color.whiteLight,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            padding: (padding ??
                    EdgeInsets.symmetric(
                      horizontal: AppSizes.appPadding,
                      vertical: 30,
                    ).copyWith(bottom: 40))
                .add(
              EdgeInsets.only(
                bottom: MediaQuery.paddingOf(context).bottom,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
