import 'package:flutter/material.dart';

class WidgetPadding extends StatelessWidget {
  const WidgetPadding({
    super.key,
    required this.child,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  factory WidgetPadding.only({
    required Widget child,
    Widget? top,
    Widget? bottom,
    Widget? left,
    Widget? right,
  }) {
    return WidgetPadding(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: child,
    );
  }

  factory WidgetPadding.symmetric({
    required Widget child,
    Widget? vertical,
    Widget? horizontal,
  }) {
    return WidgetPadding(
      top: vertical,
      bottom: vertical,
      left: horizontal,
      right: horizontal,
      child: child,
    );
  }

  factory WidgetPadding.all({required Widget child, Widget? widget}) {
    return WidgetPadding(
      top: widget,
      bottom: widget,
      left: widget,
      right: widget,
      child: child,
    );
  }
  final Widget child;
  final Widget? top;
  final Widget? bottom;
  final Widget? left;
  final Widget? right;

  @override
  Widget build(BuildContext context) {
    var current = child;

    if (left != null || right != null) {
      current = Row(
        children: [if (left != null) left!, current, if (right != null) right!],
      );
    }

    if (top != null || bottom != null) {
      current = Column(
        children: [if (top != null) top!, current, if (bottom != null) bottom!],
      );
    }

    return current;
  }
}
