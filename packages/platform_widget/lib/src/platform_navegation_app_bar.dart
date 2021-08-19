import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:platform_widget/platform_widget.dart';
import 'package:platform_widget/src/platform_widget.dart';

class PlatformNavegationAppBar
    extends PlatformWidget<CupertinoNavigationBar, AppBar>
    with PreferredSizeWidget, ObstructingPreferredSizeWidget {
  final platformType uiWidget;
  final Widget title;
  final Widget? leading;
  final Color? backgroundColor;
  final double? toolbarHeight;
  final double? paddingTop;
  final bool? centerTitle;
  final double? elevation;
  final Color? shadowColor;
  final bool? automaticallyImplyLeading;
  final Brightness? brightness;
  final bool? primary;
  final Color? borderLineBottomColor;
  final double? borderLineBottomHeight;
  final List<Widget>? actions;

  PlatformNavegationAppBar({
    required this.uiWidget,
    required this.title,
    this.leading,
    this.backgroundColor,
    this.centerTitle = false,
    this.elevation,
    this.toolbarHeight,
    this.paddingTop,
    this.shadowColor,
    this.borderLineBottomColor,
    this.borderLineBottomHeight,
    this.actions = const [],
    this.automaticallyImplyLeading,
    this.brightness,
    this.primary,
  }) : super(
          ui: uiWidget,
        );

  @override
  bool shouldFullyObstruct(BuildContext context) => true;

  @override
  Size get preferredSize {
    final __toolbarHeight = toolbarHeight ?? 0;
    final __paddingTop = paddingTop ?? 0;
    final totalHeight = __toolbarHeight + __paddingTop + 16;
    return Size.fromHeight(
      totalHeight > 0 ? totalHeight : kToolbarHeight,
    );
  }

  @override
  CupertinoNavigationBar buildIosWidget(BuildContext context) =>
      CupertinoNavigationBar(
        middle: title,
        trailing: actions != null ? Row(children: actions!) : null,
        leading: leading,
        backgroundColor: backgroundColor,
      );

  @override
  AppBar buildAndroidWidget(BuildContext context) {
    Widget _itemPositionedWidget(Widget _widget) => Transform.translate(
          offset: const Offset(0, 8),
          child: _widget,
        );

    return AppBar(
      bottom: PreferredSize(
        child: Container(
          color: borderLineBottomColor ?? Colors.grey[300],
          height: borderLineBottomHeight ?? 0,
        ),
        preferredSize: Size.fromHeight(
          borderLineBottomHeight ?? 0,
        ),
      ),
      primary: primary ?? true,
      brightness: brightness ?? Brightness.light,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      title: _itemPositionedWidget(title),
      leading: leading != null ? _itemPositionedWidget(leading!) : null,
      shadowColor: shadowColor ?? Colors.white24,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      elevation: elevation,
      toolbarHeight: toolbarHeight,
      actions: actions?.map<Widget>(_itemPositionedWidget).toList(),
    );
  }
}
