import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:platform_widget/platform_widget.dart';
import 'package:platform_widget/src/platform_widget.dart';

class PlatformTextFormField
    extends PlatformWidget<CupertinoTextField, TextFormField> {
  final Key? keyTextForm;
  final platformType? uiWidget;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function(String?)? onSubmitted;
  final String Function(String?)? validator;
  final bool autofocus;
  final bool obscureText;
  final TextStyle? style;
  final InputDecoration? decoration;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final BoxDecoration? boxDecoration;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final Widget? prefix;
  final Widget? suffix;

  const PlatformTextFormField({
    this.keyTextForm,
    this.uiWidget,
    this.controller,
    this.style,
    this.decoration,
    this.maxLines,
    this.textCapitalization = TextCapitalization.none,
    this.boxDecoration,
    this.placeholder,
    this.onChanged,
    this.suffix,
    this.onSubmitted,
    this.textInputAction,
    this.prefix,
    this.onSaved,
    this.validator,
    this.autofocus = false,
    this.obscureText = false,
  }) : super(
          ui: uiWidget,
          keyWidget: keyTextForm,
        );

  @override
  TextFormField buildAndroidWidget(
    BuildContext context,
  ) =>
      TextFormField(
        key: keyWidget,
        controller: controller,
        onSaved: onSaved,
        validator: validator,
        autofocus: autofocus,
        obscureText: obscureText,
        style: style,
        maxLines: maxLines,
        textInputAction: textInputAction,
        decoration: decoration,
        textCapitalization: textCapitalization,
        onChanged: onChanged,
      );

  @override
  CupertinoTextField buildIosWidget(
    BuildContext context,
  ) =>
      CupertinoTextField(
        key: keyWidget,
        onSubmitted: onSubmitted,
        controller: controller,
        autofocus: autofocus,
        obscureText: obscureText,
        prefix: prefix,
        suffix: suffix,
        style: style,
        maxLines: maxLines,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        decoration: boxDecoration,
        placeholder: placeholder,
        onChanged: onChanged,
      );
}
