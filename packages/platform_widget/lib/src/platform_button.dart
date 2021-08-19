import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:platform_widget/src/platform_widget.dart';
import '../platform_widget.dart';

class PlatformButton extends PlatformWidget<CupertinoButton, ElevatedButton> {
  final Key keyButton;
  final VoidCallback onPressed;
  final Widget child;
  final platformType uiWidget;

  const PlatformButton({
    required this.uiWidget,
    required this.keyButton,
    required this.child,
    required this.onPressed,
  }) : super(
          keyWidget: keyButton,
          ui: uiWidget,
        );

  @override
  ElevatedButton buildAndroidWidget(
    BuildContext context,
  ) =>
      ElevatedButton(
        child: child,
        onPressed: onPressed,
      );

  @override
  CupertinoButton buildIosWidget(
    BuildContext context,
  ) =>
      CupertinoButton(
        child: child,
        onPressed: onPressed,
        color: Colors.blue,
      );
}
