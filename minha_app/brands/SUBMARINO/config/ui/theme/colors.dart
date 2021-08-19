import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:commons/shared/theme/shared_colors.dart';

class AppColors implements BaseAppColors {
  final primaryColor = Color(0xff237FD0);
  final onPrimaryColor = Colors.white;
  final onPrimaryAlpha15Color = SharedColors.alphaWhite15;
  final onPrimaryAlpha40Color = SharedColors.alphaWhite40;
  final onPrimaryAlpha70Color = SharedColors.alphaWhite70;

  final secondaryColor = Color(0xffF8DB1C);
  final onSecondaryColor = Colors.black;
  final onSecondaryColor12 = Colors.black12;
  final onSecondaryColor45 = Colors.black45;

  final primaryColorDark = Color(0xff175F9F);
  final primaryColorLight = Color(0xff72BDFF);
  final primaryAlpha70Color = Color(0xffD9DBE9);

  final backgroundColor = Colors.white;
  final onBackgroundColor = Colors.black;

  final errorColor = Color(0xffFF3344);
  final onErrorColor = Colors.white;

  final primaryColorHover = Color(0xff2374BB);
  final primaryColorRegular = Color(0xff237FD0);

  final secondaryColorLight = Color(0xffFAE661);
  final tertiaryColor = Color(0xff67C453);
  final tertiaryColorLight = Color(0xff7DCC6C);
  final alertColor = Color(0xffFF5D00);
  final spotlightColor = Color(0xffFF00CC);

  // finalunSelectedColor = SharedColors.gray;
  // finalhoverColor = SharedColors.gray1;
  // finalfocusedColor = SharedColors.gray3;
  // finalselectedColor = SharedColors.gray4;

  final flightColor = Color(0xff0033FF);
  final hotelColor = Color(0xff97007C);
  final packagesColor = Color(0xffFF5D00);
}
