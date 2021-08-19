import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:platform_widget/src/platform_widget.dart';

import '../platform_widget.dart';

class PlatformApp extends PlatformWidget<CupertinoApp, MaterialApp> {
  final platformType uiWidget;
  final CupertinoThemeData cupertinoTheme;
  final ThemeData materialTheme;
  final Widget home;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final Locale locale;
  final String? initialRoute;
  final Map<String, Widget Function(BuildContext)>? routes;
  final Route<dynamic> Function(RouteSettings)? onUnknownRoute;
  final Route<dynamic> Function(RouteSettings)? onGenerateRoute;
  final ThemeMode themMode;
  const PlatformApp({
    required this.uiWidget,
    required this.home,
    required this.materialTheme,
    required this.cupertinoTheme,
    required this.localizationsDelegates,
    required this.supportedLocales,
    required this.locale,
    required this.themMode,
    this.onGenerateRoute,
    this.initialRoute,
    this.onUnknownRoute,
    this.routes,
  }) : super(
          ui: uiWidget,
        );

  @override
  CupertinoApp buildIosWidget(
    BuildContext context,
  ) =>
      CupertinoApp(
        onUnknownRoute: onUnknownRoute,
        theme: cupertinoTheme,
        home: home,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
      );

  @override
  MaterialApp buildAndroidWidget(
    BuildContext context,
  ) =>
      MaterialApp(
        themeMode: themMode,
        theme: materialTheme,
        locale: locale,
        home: home,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
      );
}
