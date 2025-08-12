import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class GetItHook<T extends GetxController> extends StatefulWidget {
  const GetItHook({super.key, required T controller})
    : _controller = controller;

  @override
  State<GetItHook> createState() => _GetItHookState<T>();

  void _onInit() => onInit();

  void onInit();

  bool get canDisposeController;

  Widget build(BuildContext context);

  T get controller => _controller;

  final T _controller;

  void onDispose();

  void _unRegister() {
    if (canDisposeController) {
      Get.delete<T>();
    }
  }
}

class _GetItHookState<T extends GetxController> extends State<GetItHook> {
  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void initState() {
    super.initState();
    widget._onInit();
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
    widget._unRegister();
  }
}
