import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/address_widget.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/cache_image_network.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final globalController = Get.find<GlobalController>();
    return Scaffold(
      // backgroundColor: context.color.secondary,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * .4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFF5BE01).withValues(alpha: .25),
                  Colors.white.withValues(alpha: 0),
                ],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            primary: false,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top + 10,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: AppSizes.appPadding,
                      ),
                      child: const AddressWidget(isCategoryScreen: true),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Container(
                          height: 125.w,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFF5BE01).withValues(),
                                const Color(0xFFF8D250).withValues(alpha: .69),
                                const Color(0xFFFDF3CF).withValues(alpha: .19),
                                Colors.white.withValues(alpha: 0),
                              ],
                              stops: const [.2, .34, .51, .79],
                              end: Alignment.centerLeft,
                              begin: Alignment.centerRight,
                            ),
                          ),
                        ),
                        Image.asset(AppIcons.homeImg, width: 180.w),
                        Positioned(
                          left: 0,
                          child: Padding(
                            padding: EdgeInsets.only(left: AppSizes.appPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SATISFY YOUR',
                                  style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w900,
                                    color: globalController.isDark
                                        ? context.color.primary
                                        : context.color.ff6A2100,
                                  ),
                                ),
                                Text(
                                  'CRAVINGS',
                                  style: TextStyle(
                                    fontSize: 42.sp,
                                    height: 1.1,
                                    fontWeight: FontWeight.w900,
                                    color: globalController.isDark
                                        ? context.color.primary
                                        : context.color.ff6A2100,
                                  ),
                                ),
                                Text(
                                  'FAST',
                                  style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w900,
                                    color: globalController.isDark
                                        ? context.color.primary
                                        : context.color.ff6A2100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.appPadding,
                  vertical: 20,
                ),
                child: Column(
                  spacing: 24.sp,
                  children: [
                    Row(
                      spacing: AppSizes.appPadding,
                      children: [
                        foodWidget(
                          context,
                          icon: AppIcons.maggie,
                          title: 'ORDER FOOD',
                          description: 'AT DOOR STEP',
                          index: 1,
                        ),
                        foodWidget(
                          context,
                          icon: AppIcons.takeAway,
                          title: 'PICK UP',
                          description: 'YOUR MEAL',
                          index: 2,
                        ),
                      ],
                    ),
                    Row(
                      spacing: AppSizes.appPadding,
                      children: [
                        foodWidget(
                          context,
                          icon: AppIcons.bookSlot,
                          title: 'BOOK SLOT',
                          description: 'AT RESTAURANT',
                          index: 3,
                        ),
                        foodWidget(
                          context,
                          icon: AppIcons.qrScanImg,
                          title: 'SCAN QR',
                          description: 'AT TABLE',
                          screen: AppPages.qrScannerScreen,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget foodWidget(
    BuildContext context, {
    required String icon,
    required String title,
    required String description,
    int? index,
    String? screen,
  }) {
    final globalController = Get.find<GlobalController>();
    return Expanded(
      child: GestureDetector(
        onTap: () => index == null
            ? screen?.push()
            : AppPages.homeScreen.push(arguments: index),
        child: Container(
          height: 160.w,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: context.color.whiteLight,
            border: globalController.isDark
                ? Border.all(color: const Color(0xFf454545))
                : null,
            boxShadow: [
              BoxShadow(
                color: context.color.ff9c9c9c.withValues(alpha: .25),
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(icon, width: 120.w),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.style.s18w700.copyWith(
                        fontWeight: FontWeight.w900,
                        color: context.color.primary,
                      ),
                    ),
                    Text(
                      description,
                      style: context.style.s14w700.copyWith(
                        fontWeight: FontWeight.w900,
                        color: context.color.lightText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// DO NOT remove this code because this is very hard to did this

class SpinnerPage extends StatefulWidget {
  const SpinnerPage({super.key});

  @override
  State<SpinnerPage> createState() => _SpinnerPageState();
}

class _SpinnerPageState extends State<SpinnerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final RxDouble _rotation = 0.0.obs;
  final RxDouble _velocity = 0.0.obs;
  final RxDouble _lastAngle = 0.0.obs;
  final RxBool _dragging = false.obs;
  final double _friction = .989; // Adjust for faster/slower stop
  final double _minVelocity = 0.001; // Stop threshold
  final double radius = 130;
  final double outerCircleRad = 60;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    );
    _controller.addListener(_updateRotation);
  }

  void _updateRotation() {
    if (!_dragging.value) {
      _velocity.value *= _friction;
      if (_velocity.value.abs() < _minVelocity) {
        _velocity.value = 0;
        _controller.stop();
      }
    }
    _rotation.value += _velocity.value;
  }

  void _startDrag(DragStartDetails details, Offset center) {
    _dragging.value = true;
    _controller.stop();
    final pos = details.localPosition - center;
    _lastAngle.value = atan2(pos.dy, pos.dx);
  }

  void _updateDrag(DragUpdateDetails details, Offset center) {
    if (!_dragging.value) return;
    final pos = details.localPosition - center;
    final angle = atan2(pos.dy, pos.dx);
    final delta = angle - _lastAngle.value;
    _rotation.value += delta;
    _velocity.value = delta;
    _lastAngle.value = angle;
  }

  void _endDrag(DragEndDetails details) {
    _dragging.value = false;
    _controller.repeat(period: const Duration(seconds: 8));
  }

  Offset getCenter(BuildContext context) {
    return Offset(context.sizes.width / 2, 250);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // List<String> get categoryList => [context.l10n.restaurant, context.l10n.cafe];

  @override
  Widget build(BuildContext context) {
    final center = getCenter(context);
    final globalController = Get.find<GlobalController>();
    return Scaffold(
      backgroundColor: context.color.secondary,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// 🌀 Only the rotating dial responds to gestures
            GestureDetector(
              onPanStart: (details) => _startDrag(details, center),
              onPanUpdate: (details) => _updateDrag(details, center),
              onPanEnd: _endDrag,
              child: SizedBox(
                height: 500,
                child: ColoredBox(
                  color: Colors.transparent,
                  child: Obx(
                    () => Transform.rotate(
                      angle: _rotation.value,
                      child: Stack(
                        children: List.generate(
                          globalController.moduleList.length,
                          (index) {
                            final module = globalController.moduleList[index];
                            final angle =
                                (2 * pi / globalController.moduleList.length) *
                                index;
                            final x = radius * cos(angle);
                            final y = radius * sin(angle);
                            return Positioned(
                              left: center.dx + x - outerCircleRad,
                              top: 250 + y - outerCircleRad,
                              child: Transform.rotate(
                                angle: -_rotation.value,
                                child: GestureDetector(
                                  onTap: () {
                                    // '==>> ${globalController.configModel?.moduleConfig?.toJson()}'
                                    //     .print;
                                    globalController
                                        .configModel
                                        ?.moduleConfig
                                        ?.module = globalController
                                        .getModuleConfig(module?.moduleType);
                                    globalController
                                      ..module = module
                                      ..update();
                                    Get.find<ApiClient>().updateHeader(
                                      moduleID: module?.id,
                                    );
                                    AppPages.bottomBarScreen.offAll();
                                    // bottomController.changeCategory(index);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Transform.rotate(
                                        angle: .4,
                                        child: SvgAssets(
                                          AppIcons.categoryBackIc,
                                          width: outerCircleRad * 2,
                                        ),
                                      ),
                                      Column(
                                        spacing: 5,
                                        children: [
                                          Hero(
                                            tag: module?.moduleName ?? '',
                                            child: CacheImageNetwork(
                                              module?.iconFullUrl ?? '',
                                              color: Colors.transparent,
                                              width: 40,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                            child: Text(
                                              module?.moduleName ?? '',
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: context.style.s18w700
                                                  .copyWith(
                                                    color: Colors.black,
                                                    height: 1,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// 🏠 Center logo (not gesture-sensitive)
            Stack(
              alignment: Alignment.center,
              children: [
                SvgAssets(AppIcons.logoBackIc, width: 120),
                Image.asset(AppIcons.logo, width: 100),
              ],
            ),
          ],
        ),
      ),
    );
    //  GestureDetector(
    //   onPanStart: (details) => _startDrag(details, center),
    //   onPanUpdate: (details) => _updateDrag(details, center),
    //   onPanEnd: _endDrag,
    //   child: Stack(
    //     alignment: Alignment.center,
    //     children: [
    //       ColoredBox(
    //         color: Colors.transparent,
    //         child: Transform.rotate(
    //           angle: _rotation.value,
    //           child: Stack(
    //             children: List.generate(categoryList.length, (index) {
    //               final angle = (2 * pi / categoryList.length) * index;
    //               final x = radius * cos(angle);
    //               final y = radius * sin(angle);
    //               return Positioned(
    //                 left: center.dx + x - outerCircleRad,
    //                 top: center.dy + y - outerCircleRad,
    //                 child: Transform.rotate(
    //                   angle: -_rotation.value,
    //                   child: Stack(
    //                     alignment: Alignment.center,
    //                     children: [
    //                       Transform.rotate(
    //                         angle: .4,
    //                         child: SvgAssets(
    //                           AppIcons.categoryBackIc,
    //                           width: outerCircleRad * 2,
    //                         ),
    //                       ),
    //                       Column(
    //                         children: [
    //                           Image.asset(AppIcons.burgerImg, width: 50),
    //                           Text(
    //                             categoryList[index],
    //                             style: context.style.s18w700.copyWith(
    //                               color: context.color.primary,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             }),
    //           ),
    //         ),
    //       ),
    //       Stack(
    //         alignment: Alignment.center,
    //         children: [
    //           SvgAssets(AppIcons.logoBackIc, width: 120),
    //           Image.asset(AppIcons.logo, width: 100),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
