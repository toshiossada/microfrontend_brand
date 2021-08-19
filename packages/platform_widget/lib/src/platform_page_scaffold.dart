import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../platform_widget.dart';
import './platform_navegation_app_bar.dart';

class PlatformPageScaffold
    extends PlatformWidget<CupertinoPageScaffold, Scaffold> {
  final Key? keyPage;
  final platformType uiWidget;
  final Widget body;
  final PlatformNavegationAppBar? topNavegationBar;
  final Widget? bottomNavegationBar;
  final bool showNavigationAppBar;
  final Color? backgroundColor;

  const PlatformPageScaffold({
    required this.uiWidget,
    required this.body,
    required this.showNavigationAppBar,
    this.topNavegationBar,
    this.backgroundColor,
    this.keyPage,
    this.bottomNavegationBar,
  }) : super(
          ui: uiWidget,
          keyWidget: keyPage,
        );

  @override
  Scaffold buildAndroidWidget(
    BuildContext context,
  ) =>
      Scaffold(
        key: keyPage,
        backgroundColor: backgroundColor,
        extendBody: true,
        appBar: showNavigationAppBar ? topNavegationBar : null,
        body: body,
        bottomNavigationBar: showNavigationAppBar ? bottomNavegationBar : null,
      );

  @override
  CupertinoPageScaffold buildIosWidget(
    BuildContext context,
  ) =>
      CupertinoPageScaffold(
        backgroundColor: backgroundColor,
        navigationBar: showNavigationAppBar ? topNavegationBar : null,
        child: body,
      );
}
