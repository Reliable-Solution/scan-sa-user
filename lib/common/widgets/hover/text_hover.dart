import 'package:flutter/material.dart';

class TextHover extends StatefulWidget {
  const TextHover({super.key, required this.builder});
  final Widget Function(bool isHovered) builder;

  @override
  State<TextHover> createState() => _TextHoverState();
}

class _TextHoverState extends State<TextHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return widget.builder(isHovered);
  }

  void onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
