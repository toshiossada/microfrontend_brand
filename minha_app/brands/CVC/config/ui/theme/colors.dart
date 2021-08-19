import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:commons/shared/theme/shared_colors.dart';

class AppColors implements BaseAppColors{
  final primaryColor = Color(0xff263C70);
  final onPrimaryColor = Colors.white;
  final onPrimaryAlpha15Color = SharedColors.alphaWhite15;
  final onPrimaryAlpha40Color = SharedColors.alphaWhite40;
  final onPrimaryAlpha70Color = SharedColors.alphaWhite70;

  final secondaryColor = Color(0xffF8DB1C);
  final onSecondaryColor = Colors.black;
  final onSecondaryColor12 = Colors.black12;
  final onSecondaryColor45 = Colors.black45;

  final primaryColorDark = Color(0xff192748);
  final primaryColorLight = Color(0xff335094);
  final primaryAlpha70Color = Color(0xffD9DBE9);

  final backgroundColor = Colors.white;
  final onBackgroundColor = Colors.black;

  final errorColor = Color(0xffD73A21);
  final onErrorColor = Colors.white;

  final primaryColorHover = Color(0xff335094);
  final primaryColorRegular = Color(0xff237FD0);

  final secondaryColorLight = Color(0xffFFE561);
  final tertiaryColor = Color(0xff11AF71);
  final tertiaryColorLight = Color(0xff16DF90);
  final alertColor = Color(0xffFF8B00);
  final spotlightColor = Color(0xffCC0E9E);

  // final unSelectedColor = SharedColors.gray;
  // final hoverColor = SharedColors.gray1;
  // final focusedColor = SharedColors.gray3;
  // final selectedColor = SharedColors.gray4;

  final flightColor = Color(0xff038EAD);
  final hotelColor = Color(0xffBF0268);
  final packagesColor = Color(0xffE55402);
}
