import 'dart:math';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/util/app_hero_tags.dart';
import 'package:scan_sa_user/util/images.dart';

class EntryAnimatedRotatingCircles extends StatefulWidget {
  const EntryAnimatedRotatingCircles({super.key, required this.child});
  final Widget child;

  @override
  State<EntryAnimatedRotatingCircles> createState() =>
      _EntryAnimatedRotatingCirclesState();
}

class _EntryAnimatedRotatingCirclesState
    extends State<EntryAnimatedRotatingCircles> with TickerProviderStateMixin {
  late AnimationController expandController;
  late AnimationController rotateController;
  late Animation<double> radiusFactor;

  final int itemCountOuter = 10;
  final int itemCountInner = 6;

  List<String> imageList = [
    Images.pizzaDishImg,
    Images.burgerImg,
    Images.maggieImg,
    Images.sodaImg,
    Images.shakeImg,
    Images.rolesImg,
    Images.pizzaDishImg,
    Images.maggieImg,
    Images.sodaImg,
    Images.rolesImg,
  ];

  @override
  void initState() {
    super.initState();

    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    radiusFactor = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: expandController, curve: Curves.easeInCubic),
    );

    rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    expandController.forward().whenComplete(() {
      rotateController.repeat();
    });
  }

  @override
  void dispose() {
    expandController.dispose();
    rotateController.dispose();
    super.dispose();
  }

  Widget _buildItem(int index, int total, Color color, double baseRadius) {
    return AnimatedBuilder(
      animation: Listenable.merge([expandController, rotateController]),
      builder: (_, __) {
        final currentRadius = baseRadius * radiusFactor.value;
        final angle = (2 * pi * index) / total;
        final rotatedAngle = angle +
            (currentRadius == baseRadius ? rotateController.value : 1) * 2 * pi;

        final x = currentRadius * cos(rotatedAngle);
        final y = currentRadius * sin(rotatedAngle);

        return Transform.translate(
          offset: Offset(x, y),
          child: Image.asset(imageList[index], width: 65, height: 65),
        );
      },
    );
  }

  Widget _buildDashedCircle(double radius) {
    return AnimatedBuilder(
      animation: Listenable.merge([expandController, rotateController]),
      builder: (_, __) {
        final currentRadius = radius * radiusFactor.value;
        return radiusFactor.value == 1
            ? Transform.rotate(
                angle: currentRadius != radius
                    ? 1
                    : rotateController.value * 2 * pi,
                child: CustomPaint(
                  size: Size(currentRadius * 2, currentRadius * 2),
                  painter: _RotatedWidget(Colors.white),
                ),
              )
            : const SizedBox();
      },
    );
  }

  Widget _buildSolidCircle(double radius) {
    return AnimatedBuilder(
      animation: expandController,
      builder: (_, __) {
        final currentRadius = radius * radiusFactor.value;
        return CustomPaint(
          size: Size(currentRadius * 2, currentRadius * 2),
          painter: SolidCirclePainter(Colors.white.withValues(alpha: .5)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sizes.height,
      width: context.sizes.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 20,
            child: SizedBox(
              height: context.sizes.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      expandController,
                      rotateController,
                    ]),
                    builder: (_, __) {
                      final currentRadius =
                          context.sizes.width * 0.55 * radiusFactor.value;
                      return Transform.rotate(
                        angle: currentRadius != currentRadius
                            ? 1
                            : rotateController.value * 2 * pi,
                        child: Image.asset(
                          Images.pizzaImg,
                          width: currentRadius,
                          height: currentRadius,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  _buildSolidCircle(context.sizes.width * 0.4),
                  _buildDashedCircle(context.sizes.width * 0.28),

                  // Outer items
                  ...List.generate(
                    itemCountOuter,
                    (i) => _buildItem(
                      i,
                      itemCountOuter,
                      Colors.blue,
                      context.sizes.width * 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: Listenable.merge([expandController]),
            builder: (_, __) {
              return Positioned(
                top: Tween(
                  begin: context.sizes.height,
                  end: 20 + context.sizes.width * 0.58,
                ).evaluate(radiusFactor),
                // (20 + context.sizes.width * 0.58) * (1-  radiusFactor.value),
                child: AnimatedBuilder(
                  animation: Listenable.merge([expandController]),
                  builder: (_, __) {
                    return SizedBox(
                      height: (context.sizes.height -
                              (20 + context.sizes.width * 0.58)) *
                          radiusFactor.value,
                      width: context.sizes.width,
                      child: widget.child,
                    );
                  },
                ),
              );
            },
          ),
          Positioned(
            top: 20 + context.sizes.width * 0.36,
            child: Hero(
              tag: AppHeroTags.splashLogo,
              child: SvgAssets(
                Images.logoIc,
                width: context.sizes.width * 0.28,
                height: context.sizes.width * 0.28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Solid border painter
class SolidCirclePainter extends CustomPainter {
  SolidCirclePainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _RotatedWidget extends CustomPainter {
  _RotatedWidget(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    const double dashLength = 6;
    const double gap = 4;

    final center = size.center(Offset.zero);
    final totalLength = 2 * pi * radius;
    final dashCount = (totalLength / (dashLength + gap)).floor();

    for (var i = 0; i < dashCount; i++) {
      final angle = (2 * pi * i) / dashCount;
      final x1 = center.dx + radius * cos(angle);
      final y1 = center.dy + radius * sin(angle);

      final x2 = center.dx + radius * cos(angle + dashLength / radius);
      final y2 = center.dy + radius * sin(angle + dashLength / radius);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
