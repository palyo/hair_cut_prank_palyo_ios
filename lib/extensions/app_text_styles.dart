import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prankers/extensions/screen_size.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle baseTextStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'DM Sans',
      color: AppColors.text(context),
    );
  }

  // Headline styles
  static TextStyle headline1(BuildContext context) {
    return baseTextStyle(context).copyWith(
      fontSize: 36.sp,
      fontWeight: FontWeight.bold,
      height: 1.2,
      color: AppColors.text(context),
    );
  }

  static TextStyle headline2(BuildContext context) {
    return baseTextStyle(context).copyWith(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      height: 1.3,
    );
  }

  static TextStyle headline1_5(BuildContext context) {
    return baseTextStyle(context).copyWith(
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
      height: 1.3,
    );
  }

  // Subheading styles
  static TextStyle subheading1(BuildContext context) {
    return baseTextStyle(context).copyWith(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );
  }

  static TextStyle subheading2(BuildContext context) {
    return baseTextStyle(context).copyWith(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      height: 1.2,
    );
  }

  static TextStyle subheading3(BuildContext context) {
    return baseTextStyle(context).copyWith(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      height: 1.2,
    );
  }

  // Body text styles
  static TextStyle bodyText1(BuildContext context) {
    return baseTextStyle(context).copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      height: 1.2,
    );
  }

  // Body text styles
  static TextStyle bodyText2(BuildContext context) {
    return baseTextStyle(context).copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      height: 1.2,
    );
  }

  static TextStyle bodyText3(BuildContext context) {
    return baseTextStyle(context).copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      height: 1.2,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    return baseTextStyle(context).copyWith(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.text(context),
    );
  }

  static TextStyle accentButtonText(BuildContext context) {
    return baseTextStyle(context).copyWith(
        fontSize: context.isTabletSize?24.sp:18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.accentText(context));
  }

  static TextStyle accentToolbarText(BuildContext context) {
    return baseTextStyle(context).copyWith(
        fontSize: context.isTabletSize?42.sp:24.sp,
        fontWeight: FontWeight.w900,
        color: AppColors.accentText(context));
  }
}
