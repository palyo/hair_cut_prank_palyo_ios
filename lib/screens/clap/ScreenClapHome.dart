import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:prankers/extensions/app_colors.dart';
import 'package:prankers/extensions/app_text_styles.dart';
import 'package:prankers/extensions/screen_size.dart';
import 'package:prankers/screens/clap/ClapDetector.dart';

import 'ClappingDetector.dart';

class ScreenClapHome extends StatefulWidget {
  const ScreenClapHome({super.key});

  @override
  State<ScreenClapHome> createState() => _ScreenClapHomeState();
}

class _ScreenClapHomeState extends State<ScreenClapHome> {
  bool _isServiceEnabled = false;
  String _selectedAlert = 'police';

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.background(context),
        body: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom / 2),
          child: Stack(
            children: [
              Image.asset('assets/ic_player_background.webp', width: context.screenWidth, fit: BoxFit.cover),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 12.sp),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset('assets/icons/ic_navigation_back.webp', width: 56.sp, height: 56.sp, fit: BoxFit.contain),
                        ),
                        SizedBox(width: 12.sp),
                        Center(child: Text('Clap Detector', style: AppTextStyles.accentToolbarText(context))),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.sp),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(ClappingDetector());
                      },
                      child: Image.asset('assets/alert/${_isServiceEnabled ? 'ic_power_enabled' : 'ic_power_disabled'}.webp', height: 120.sp),
                    ),
                  ),
                  SizedBox(height: 12.sp),
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: false,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: GridView.count(
                          padding: EdgeInsets.zero,
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.87,
                          children: [
                            buildCategory('ic_alert_police', 'police', "Police"),
                            buildCategory('ic_alert_alarm', 'alarm', "Alarm"),
                            buildCategory('ic_alert_yahoo', 'yahoo', "Yahoo"),
                            buildCategory('ic_alert_dog', 'dog', "Dog"),
                            buildCategory('ic_alert_clock', 'clock', "Clock"),
                            buildCategory('ic_alert_buzz', 'buzz', "Buzz"),
                            buildCategory('ic_alert_broken', 'broken', "Broken"),
                            buildCategory('ic_alert_aircraft', 'aircraft', "Air craft"),
                            buildCategory('ic_alert_speaker', 'speaker', "Speaker"),
                            buildCategory('ic_alert_beep', 'beep', "Beep"),
                            buildCategory('ic_alert_thunder', 'thunder', "Thunder"),
                            buildCategory('ic_alert_game', 'game', "Game"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildCategory(String icon, String key, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAlert = key;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.sp),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.card(context),
            borderRadius: BorderRadius.circular(24.sp),
            border: Border.all(color: _selectedAlert == key ? AppColors.text(context) : Colors.transparent, width: 2),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(child: Image.asset('assets/alert/$icon.webp', height: 68.sp)),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Text(title, style: AppTextStyles.subheading3(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
