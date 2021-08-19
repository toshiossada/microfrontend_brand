import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:platform_widget/src/platform_widget.dart';

import '../platform_widget.dart';

class PlatformIconButton extends PlatformWidget<GestureDetector, IconButton> {
  final platformType uiWidget;
  final VoidCallback onPressed;
  final Widget? child;
  final IconData icon;
  final IconData? cupertinoIcon;
  final Color color;

  const PlatformIconButton({
    required this.uiWidget,
    required this.onPressed,
    required this.icon,
    required this.color,
    this.child,
    this.cupertinoIcon,
  }) : super(
          ui: uiWidget,
        );

  @override
  IconButton buildAndroidWidget(
    BuildContext context,
  ) =>
      IconButton(
        icon: Icon(
          icon,
        ),
        color: color,
        onPressed: onPressed,
      );

  @override
  GestureDetector buildIosWidget(
    BuildContext context,
  ) =>
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        child: Icon(
          cupertinoIcon,
        ),
      );
}
