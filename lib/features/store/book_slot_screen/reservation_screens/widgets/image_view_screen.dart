import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/common/widgets/custom_image.dart';
import 'package:scan_sa_user/features/store/domain/models/store_menu_model.dart';
import 'package:scan_sa_user/util/app_sizes.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/images.dart';

class MenuViewerScreen extends StatefulWidget {
  const MenuViewerScreen({
    super.key,
    required this.menuList,
    required this.initialIndex,
  });
  final List<MenuModelData> menuList;
  final int initialIndex;

  @override
  State<MenuViewerScreen> createState() => _MenuViewerScreenState();
}

class _MenuViewerScreenState extends State<MenuViewerScreen> {
  int currentPage = 1;
  PageController? _pageController;

  void pageChange(int page) {
    setState(() {
      currentPage = page + 1;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialIndex);
    currentPage = widget.initialIndex + 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postList = widget.menuList;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          PageView.builder(
            itemCount: postList.length,
            controller: _pageController,
            onPageChanged: pageChange,
            itemBuilder: (context, index) {
              final feed = postList[index];
              return _ZoomAbleImage(imageUrl: feed.imageUrl ?? '');
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              right: AppSizes.appPadding,
              top: MediaQuery.paddingOf(context).top + 12,
              bottom: 12,
              left: 10,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: Get.back,
                    child: ColoredBox(
                      color: Colors.transparent,
                      child: SvgAssets(
                        Images.arrowBackIc,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Menu',
                  style: context.style.s24w700.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoomAbleImage extends StatefulWidget {
  const _ZoomAbleImage({required this.imageUrl});
  final String imageUrl;

  @override
  State<_ZoomAbleImage> createState() => _ZoomAbleImageState();
}

class _ZoomAbleImageState extends State<_ZoomAbleImage>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  Animation<Matrix4>? _animation;
  late AnimationController _animationController;
  TapDownDetails? _doubleTapDetails;
  bool _zoomed = false;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.addListener(() {
      _transformationController.value = _animation!.value;
    });
  }

  void _handleDoubleTap() {
    final tapPosition = _doubleTapDetails!.localPosition;

    final zoomedMatrix = Matrix4.identity()
      ..translate(-tapPosition.dx * 2, -tapPosition.dy * 2)
      ..scale(3.0);

    final targetMatrix = _zoomed ? Matrix4.identity() : zoomedMatrix;

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: targetMatrix,
    ).animate(
      CurveTween(curve: Curves.easeInOut).animate(_animationController),
    );

    _animationController.forward(from: 0);
    _zoomed = !_zoomed;
    setState(() {});
  }

  void resetZoomAnimated() {
    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(
      CurveTween(curve: Curves.easeInOut).animate(_animationController),
    );

    _animationController.forward(from: 0);
    _zoomed = false;
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (details) => _doubleTapDetails = details,
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        transformationController: _transformationController,
        panEnabled: _zoomed,
        minScale: 1,
        maxScale: 4,
        boundaryMargin: const EdgeInsets.all(100),
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: CustomImage(
            image: widget.imageUrl,
            // color: Colors.black,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).width * 1.414,
          ),
        ),
      ),
    );
  }
}
