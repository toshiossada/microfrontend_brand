import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:platform_widget/src/platform_utils.dart';
import 'package:platform_widget/src/platform_widget.dart';

class PlatformToast extends PlatformWidget<SnackBar, SnackBar> {
  final platformType uiWidget;
  final Widget content;
  final Color backgroundColor;
  final double elevation;
  final Duration duration;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double width;
  final ShapeBorder shape;
  final SnackBarBehavior behavior;

  const PlatformToast({
    required this.uiWidget,
    required this.content,
    required this.backgroundColor,
    required this.elevation,
    required this.duration,
    required this.margin,
    required this.padding,
    required this.width,
    required this.shape,
    required this.behavior,
  }) : super(
          ui: uiWidget,
        );

  @override
  SnackBar buildAndroidWidget(
    BuildContext context,
  ) =>
      SnackBar(
        content: content,
        backgroundColor: backgroundColor,
        elevation: elevation,
        duration: duration,
        margin: margin,
        padding: padding,
        width: width,
        shape: shape,
        behavior: behavior,
      );

  @override
  SnackBar buildIosWidget(
    BuildContext context,
  ) =>
      SnackBar(
        content: content,
        backgroundColor: backgroundColor,
        elevation: elevation,
        duration: duration,
        margin: margin,
        padding: padding,
        width: width,
        shape: shape,
        behavior: behavior,
      );
}
