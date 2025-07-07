import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prankers/extensions/app_colors.dart';
import 'package:prankers/extensions/app_text_styles.dart';
import 'package:prankers/extensions/screen_size.dart';

Widget buildLanguageAd(BuildContext context) {
  return Container(
    height: 265,
    width: context.screenWidth,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: colorCard,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style:
                ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: colorText.withAlpha(25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(
                    colorAccent.withAlpha(25),
                  ),
                ),
            child: Text(
              'Load more',
              style: AppTextStyles.of(
                context,
              ).button.copyWith(color: colorText.withAlpha(50)),
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: colorText.withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        decoration: BoxDecoration(
                          color: colorText.withAlpha(25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              'Ad',
                              style: AppTextStyles.of(context).bodyMedium
                                  .copyWith(color: colorText.withAlpha(50)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorText.withAlpha(25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                            style: AppTextStyles.of(context).bodyBoldLarge
                                .copyWith(color: colorText.withAlpha(0)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: colorText.withAlpha(25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. It is often used in graphic design, web design, and publishing to fill a space or to provide a visual impression of how a final product will look.'
                      '\n',
                      style: AppTextStyles.of(
                        context,
                      ).bodySmall.copyWith(color: colorText.withAlpha(0)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: colorText.withAlpha(25),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    ),
  );
}

Widget buildOnboardingAd(BuildContext context) {
  return Container(
    height: 265,
    width: context.screenWidth,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: colorCard,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style:
                ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: colorText.withAlpha(25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(
                    colorAccent.withAlpha(25),
                  ),
                ),
            child: Text(
              'Load more',
              style: AppTextStyles.of(
                context,
              ).button.copyWith(color: colorText.withAlpha(50)),
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: colorText.withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        decoration: BoxDecoration(
                          color: colorText.withAlpha(25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              'Ad',
                              style: AppTextStyles.of(context).bodyMedium
                                  .copyWith(color: colorText.withAlpha(50)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorText.withAlpha(25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                            style: AppTextStyles.of(context).bodyBoldLarge
                                .copyWith(color: colorText.withAlpha(0)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: colorText.withAlpha(25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. It is often used in graphic design, web design, and publishing to fill a space or to provide a visual impression of how a final product will look.'
                      '\n',
                      style: AppTextStyles.of(
                        context,
                      ).bodySmall.copyWith(color: colorText.withAlpha(0)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: colorText.withAlpha(25),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    ),
  );
}

Widget buildSmallOnboardingAd(BuildContext context) {
  return Container(
    height: 134,
    width: context.screenWidth,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: colorCard,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style:
                ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: colorText.withAlpha(25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(
                    colorAccent.withAlpha(25),
                  ),
                ),
            child: Text(
              'Load more',
              style: AppTextStyles.of(
                context,
              ).button.copyWith(color: colorText.withAlpha(50)),
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: colorText.withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        decoration: BoxDecoration(
                          color: colorText.withAlpha(25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              'Ad',
                              style: AppTextStyles.of(context).bodyMedium
                                  .copyWith(color: colorText.withAlpha(50)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorText.withAlpha(25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                            style: AppTextStyles.of(context).bodyBoldLarge
                                .copyWith(color: colorText.withAlpha(0)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: colorText.withAlpha(25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. It is often used in graphic design, web design, and publishing to fill a space or to provide a visual impression of how a final product will look.'
                      '\n',
                      style: AppTextStyles.of(
                        context,
                      ).bodySmall.copyWith(color: colorText.withAlpha(0)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildFullOnboardingAd(BuildContext context) {
  return Container(
    width: context.screenWidth,
    height: context.screenHeight,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: colorCard,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: colorText.withAlpha(25),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: colorText.withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        decoration: BoxDecoration(
                          color: colorText.withAlpha(25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              'Ad',
                              style: AppTextStyles.of(context).bodyMedium
                                  .copyWith(color: colorText.withAlpha(50)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorText.withAlpha(25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                            style: AppTextStyles.of(context).bodyBoldLarge
                                .copyWith(color: colorText.withAlpha(0)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: colorText.withAlpha(25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. It is often used in graphic design, web design, and publishing to fill a space or to provide a visual impression of how a final product will look.'
                      '\n',
                      style: AppTextStyles.of(
                        context,
                      ).bodySmall.copyWith(color: colorText.withAlpha(0)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style:
                ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: colorText.withAlpha(25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(
                    colorAccent.withAlpha(25),
                  ),
                ),
            child: Text(
              'Load more',
              style: AppTextStyles.of(
                context,
              ).button.copyWith(color: colorText.withAlpha(50)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSmallAd(BuildContext context) {
  return Container(
    height: 134,
    width: context.screenWidth,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: colorCard,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: colorText.withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        decoration: BoxDecoration(
                          color: colorText.withAlpha(25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              'Ad',
                              style: AppTextStyles.of(context).bodyMedium
                                  .copyWith(color: colorText.withAlpha(50)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorText.withAlpha(25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                            style: AppTextStyles.of(context).bodyBoldLarge
                                .copyWith(color: colorText.withAlpha(0)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: colorText.withAlpha(25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. It is often used in graphic design, web design, and publishing to fill a space or to provide a visual impression of how a final product will look.'
                      '\n',
                      style: AppTextStyles.of(
                        context,
                      ).bodySmall.copyWith(color: colorText.withAlpha(0)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style:
                ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: colorText.withAlpha(25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(
                    colorAccent.withAlpha(25),
                  ),
                ),
            child: Text(
              'Load more',
              style: AppTextStyles.of(
                context,
              ).button.copyWith(color: colorText.withAlpha(50)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildMediumAd(BuildContext context) {
  return Container(
    height: 265,
    width: context.screenWidth,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: colorCard,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: colorText.withAlpha(25),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: colorText.withAlpha(25),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        decoration: BoxDecoration(
                          color: colorText.withAlpha(25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              'Ad',
                              style: AppTextStyles.of(context).bodyMedium
                                  .copyWith(color: colorText.withAlpha(50)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorText.withAlpha(25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                            style: AppTextStyles.of(context).bodyBoldLarge
                                .copyWith(color: colorText.withAlpha(0)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: colorText.withAlpha(25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. It is often used in graphic design, web design, and publishing to fill a space or to provide a visual impression of how a final product will look.'
                      '\n',
                      style: AppTextStyles.of(
                        context,
                      ).bodySmall.copyWith(color: colorText.withAlpha(0)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style:
                ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: colorText.withAlpha(25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(
                    colorAccent.withAlpha(25),
                  ),
                ),
            child: Text(
              'Load more',
              style: AppTextStyles.of(
                context,
              ).button.copyWith(color: colorText.withAlpha(50)),
            ),
          ),
        ),
      ],
    ),
  );
}
