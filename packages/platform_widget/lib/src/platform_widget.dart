import 'package:flutter/material.dart';
import 'package:platform_widget/platform_widget.dart';

abstract class PlatformWidget<IOS extends Widget, ANDROID extends Widget>
    extends StatelessWidget {
  final platformType? ui;
  final Key? keyWidget;

  const PlatformWidget({
    required this.ui,
    this.keyWidget,
  }) : super(
          key: keyWidget,
        );

  @override
  Widget build(
    BuildContext context,
  ) {
    final uiWidgetType = {
      platformType.material.toShortString(): buildAndroidWidget(
        context,
      ),
      platformType.cupertino.toShortString(): buildIosWidget(
        context,
      )
    };

    if (ui != null) {
      return uiWidgetType[ui!.toShortString()]!;
    }

    return buildAndroidWidget(context);
  }

  ANDROID buildAndroidWidget(
    BuildContext context,
  );
  IOS buildIosWidget(
    BuildContext context,
  );
}
