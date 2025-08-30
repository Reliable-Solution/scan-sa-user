import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/helper/string_extension.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/images.dart';

/// DO NOT remove this code because this is very hard to did this

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({
    super.key,
    required this.pageIndex,
    required this.fromSplash,
  });
  final int pageIndex;
  final bool fromSplash;

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen>
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
    List selectionList = ['Order Food', 'Book Table', 'Scan QR'];
    final center = getCenter(context);
    return Scaffold(
      backgroundColor: context.color.primary,
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
                          selectionList.length,
                          (index) {
                            final angle =
                                (2 * pi / selectionList.length) * index;
                            final x = radius * cos(angle);
                            final y = radius * sin(angle);
                            return Positioned(
                              left: center.dx + x - outerCircleRad,
                              top: 250 + y - outerCircleRad,
                              child: Transform.rotate(
                                angle: -_rotation.value,
                                child: GestureDetector(
                                  onTap: () {
                                    "pp $index".print;
                                    if (index == 2) {
                                      Get.toNamed(
                                        'store?slug=smart-shopping14&from=qrScan',
                                      );
                                    } else {
                                      Get.offAllNamed(
                                        RouteHelper.getBottomRoute(
                                          fromSplash: widget.fromSplash,
                                          fromBookTable: index == 1,
                                        ),
                                      );
                                      // Get.toNamed(RouteHelper.getQrRoute());
                                    }
                                  },
                                  child: Image.asset(
                                    switch (selectionList[index]) {
                                      'Order Food' => Images.orderFoodImg,
                                      'Book Table' => Images.bookSlotImg,
                                      _ => Images.qrScanImg
                                    },
                                    width: outerCircleRad * 2,
                                  ),
                                  // child: Stack(
                                  //   alignment: Alignment.center,
                                  //   children: [
                                  //     Transform.rotate(
                                  //       angle: .4,
                                  //       child: SvgAssets(
                                  //         Images.categoryBackIc,
                                  //         width: outerCircleRad * 2,
                                  //       ),
                                  //     ),
                                  //     Column(
                                  //       spacing: 5,
                                  //       children: [
                                  //         // Hero(
                                  //         //   tag: 'module.moduleName ?? ' '',
                                  //         //   child: SvgAssets(Images.closeEyeIc),
                                  //         // ),
                                  //         SizedBox(
                                  //           width: 80,
                                  //           child: Text(
                                  //             selectionList[index],
                                  //             textAlign: TextAlign.center,
                                  //             maxLines: 2,
                                  //             overflow: TextOverflow.ellipsis,
                                  //             style: context.style.s18w700
                                  //                 .copyWith(
                                  //               color: Colors.black,
                                  //               height: 1.2,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
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
                SvgAssets(Images.logoBackIc, width: 120),
                Image.asset(Images.logo, width: 100),
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
