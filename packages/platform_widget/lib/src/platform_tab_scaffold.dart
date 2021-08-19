import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:platform_widget/platform_widget.dart';
import 'package:platform_widget/src/platform_widget.dart';

class PlatformTabScaffold extends PlatformWidget<CupertinoTabScaffold, Widget> {
  final Key? keyTab;
  final platformType uiWidget;
  final int currentIndex;
  final void Function(int) onTap;
  final List<BottomNavigationBarItem> items;
  final Widget? body;
  final Widget Function(BuildContext, int) tabBuilder;
  final bool showBottomNavigationBar;
  final Color? backgroundColor;
  final Color? boxShadowColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? borderRadius;
  final double? blurRadius;
  final double? spreadRadius;
  final double? bottomNavigationBarItemHeight;
  final double selectedFontSize;
  final double unselectedFontSize;
  final double? iconSize;
  final double? boxShadowOffset;

  const PlatformTabScaffold({
    required this.uiWidget,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.tabBuilder,
    required this.showBottomNavigationBar,
    required this.selectedFontSize,
    required this.unselectedFontSize,
    this.keyTab,
    this.body,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.iconSize,
    this.borderRadius,
    this.blurRadius,
    this.spreadRadius,
    this.bottomNavigationBarItemHeight,
    this.backgroundColor,
    this.boxShadowColor,
    this.boxShadowOffset,
  }) : super(
          ui: uiWidget,
          keyWidget: keyTab,
        );

  @override
  Widget buildAndroidWidget(
    BuildContext context,
  ) =>
      Container(
        height: bottomNavigationBarItemHeight ?? 60,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              borderRadius ?? 16,
            ),
            topLeft: Radius.circular(
              borderRadius ?? 16,
            ),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(
                0.0,
                boxShadowOffset ?? 0.0,
              ),
              color: boxShadowColor ?? Colors.black26,
              spreadRadius: spreadRadius ?? 1,
              blurRadius: blurRadius ?? 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              borderRadius ?? 16.0,
            ),
            topRight: Radius.circular(
              borderRadius ?? 16.0,
            ),
          ),
          child: SingleChildScrollView(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            child: BottomNavigationBar(
                iconSize: iconSize ?? 20,
                currentIndex: currentIndex,
                onTap: onTap,
                items: items,
                selectedFontSize: selectedFontSize,
                unselectedFontSize: unselectedFontSize
                // selectedFontSize: selectedFontSize ??
                //     Theme.of(
                //       context,
                //     ).bottomNavigationBarTheme.selectedLabelStyle!.fontSize,
                // unselectedFontSize: unselectedFontSize ??
                //     Theme.of(
                //       context,
                // ignore: lines_longer_than_80_chars
                //     ).bottomNavigationBarTheme.unselectedLabelStyle!.fontSize,
                ),
          ),
        ),
      );

  @override
  CupertinoTabScaffold buildIosWidget(BuildContext context) {
    const dummyIcon = Icon(IconData(0x0020));
    return CupertinoTabScaffold(
      tabBar: showBottomNavigationBar
          ? CupertinoTabBar(items: items)
          : CupertinoTabBar(items: [
              BottomNavigationBarItem(
                  icon: dummyIcon, backgroundColor: backgroundColor),
              const BottomNavigationBarItem(icon: dummyIcon)
            ]),
      tabBuilder: tabBuilder,
    );
  }
}
