import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/app_colors.dart';
import '../extensions/app_text_styles.dart';

AppBar buildAppBar(
  BuildContext context, {
  String? text,
  IconData? icon,
  List<Widget>? actions,
  bool isBack = true,
  Function()? onPressed,
}) {
  return AppBar(
    elevation: 0,
    centerTitle: false,
    forceMaterialTransparency: true,
    backgroundColor: colorPrimary,
    leading:
        isBack
            ? Padding(
              padding: EdgeInsets.only(left: 12.sp, right: 14.sp),
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  icon ?? Icons.arrow_back_rounded,
                  size: 28.sp,
                  color: colorText,
                ),
                color: colorText,
              ),
            )
            : null,
    title:
        text != null
            ? Text(
              text ?? '',
              style: AppTextStyles.of(context).headline4.copyWith(fontWeight: FontWeight.w600),
            )
            : const SizedBox.shrink(),
    actions: actions,
  );
}
