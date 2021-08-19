import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../platform_widget.dart';

class PlatformPageScaffoldSliver
    extends PlatformWidget<CupertinoPageScaffold, Widget> {
  final Key? keyPage;
  final platformType uiWidget;
  final Widget body;
  final Widget topNavegationBar;
  final Widget bottomNavegationBar;
  final bool canShowTopBar;
  final bool canShowBottomBar;
  final Color backgroundColor;
  final double topExpandedHeightBar;
  final double bodyItemExtendHeight;
  final double bodyItemCollapseHeight;
  final bool? canScrollPhysics;
  final double topNavegationBarElevation;
  final Color topNavegationBarShadowColor;
  final Color topNavegationBarColor;
  final bool hasScrollBody;
  final ScrollController scrollController;
  final double textFactorScale;
  const PlatformPageScaffoldSliver({
    required this.uiWidget,
    required this.body,
    required this.topNavegationBar,
    required this.bottomNavegationBar,
    required this.canShowTopBar,
    required this.canShowBottomBar,
    required this.backgroundColor,
    required this.topExpandedHeightBar,
    required this.bodyItemExtendHeight,
    required this.bodyItemCollapseHeight,
    required this.topNavegationBarElevation,
    required this.topNavegationBarShadowColor,
    required this.topNavegationBarColor,
    required this.hasScrollBody,
    required this.scrollController,
    required this.textFactorScale,
    this.canScrollPhysics,
    this.keyPage,
  }) : super(
          ui: uiWidget,
          keyWidget: keyPage,
        );

  @override
  Widget buildAndroidWidget(
    BuildContext context,
  ) {
    final _topNavegationBar = canShowTopBar
        ? SliverAppBar(
            backgroundColor: topNavegationBarColor,
            forceElevated: true,
            elevation: topNavegationBarElevation,
            shadowColor: topNavegationBarShadowColor,
            floating: true,
            expandedHeight: topExpandedHeightBar,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: canShowTopBar ? topNavegationBar : null,
            ),
          )
        : const SliverPadding(
            padding: EdgeInsets.zero,
          );
    return SafeArea(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: textFactorScale),
        child: Scaffold(
          key: keyPage,
          backgroundColor: backgroundColor,
          extendBody: true,
          body: CustomScrollView(
            controller: scrollController,
            physics: canScrollPhysics ??
                    false || (bodyItemCollapseHeight < bodyItemExtendHeight)
                ? const ClampingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            slivers: [
              _topNavegationBar,
              SliverFillRemaining(
                fillOverscroll: true,
                hasScrollBody: hasScrollBody,
                child: Container(
                  color: backgroundColor,
                  height: bodyItemExtendHeight,
                  child: body,
                ),
              )
            ],
          ),
          bottomNavigationBar: canShowBottomBar ? bottomNavegationBar : null,
        ),
      ),
    );
  }

  @override
  CupertinoPageScaffold buildIosWidget(
    BuildContext context,
  ) =>
      CupertinoPageScaffold(
        backgroundColor: backgroundColor,
        child: body,
      );
}
