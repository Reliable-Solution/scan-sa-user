import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class HelpNSupport extends StatelessWidget {
  const HelpNSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [Color(0xFF4744A1), Color(0xFF151444)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              gradientWidget(),
              gradientWidget(isRight: true),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top + 10,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.appPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: Get.back,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: SvgAssets(
                                AppIcons.arrowBackIc,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            context.l10n.helpSupport,
                            style: context.style.s22w700.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Opacity(
                            opacity: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: SvgAssets(
                                AppIcons.arrowBackIc,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SvgAssets(AppIcons.helpSupportIc),
                  ],
                ),
              ),
            ],
          ),
          rowWidget(
            context,
            title: context.l10n.helpSupport,
            desc: 'HQ- Prince faisal lbn mishaal lbn saud...',
            icon: AppIcons.locationFillIc,
            roundColor: const Color(0xFFDEF4FF),
            color: const Color(0xFF4285F4),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
            child: Divider(color: context.color.borderColor, height: 0),
          ),
          rowWidget(
            context,
            title: 'Call',
            desc: '+971 50 123 4567.',
            icon: AppIcons.callLightIc,
            roundColor: const Color(0xFFFFEFDE),
            color: const Color(0xFFFF8300),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
            child: Divider(color: context.color.borderColor, height: 0),
          ),
          rowWidget(
            context,
            title: 'Email',
            desc: 'abc@gmail.com',
            icon: AppIcons.locationFillIc,
            roundColor: const Color(0xFFDFFFDE),
            color: const Color(0xFF44D440),
          ),
        ],
      ),
    );
  }

  Widget gradientWidget({bool isRight = false}) {
    return Positioned(
      right: isRight ? 0 : null,
      top: 0,
      bottom: 0,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
            colors: isRight
                ? [
                    const Color(0xFF4744A1).withValues(alpha: 0),
                    const Color(0xFF211F59).withValues(alpha: .5),
                    const Color(0xFF211F59),
                  ]
                : [
                    const Color(0xFF211F59),
                    const Color(0xFF211F59).withValues(alpha: .5),
                    const Color(0xFF4744A1).withValues(alpha: 0),
                  ],
          ),
        ),
      ),
    );
  }

  Widget rowWidget(
    BuildContext context, {
    required String title,
    required String desc,
    required String icon,
    required Color color,
    required Color roundColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Row(
        spacing: 10,
        children: [
          CircleAvatar(
            backgroundColor: roundColor,
            radius: 30,
            child: SvgAssets(icon, width: 25, color: color),
          ),
          Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.style.s16w700),
              Text(
                desc,
                style: context.style.s14w700.copyWith(
                  color: context.color.ff6c6c6c,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
