import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../provider/MainController.dart';

class AppColors {
  // Light Theme Colors
  static const Color lightPrimary = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF1F1F1);
  static const Color lightCardText = Color(0xFF000000);
  static const Color lightText = Color(0xFF000000);
  static const Color lightAccent = Color(0xFF3E64F3);
  static const Color lightAccentText = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF0C0C0C);
  static const Color darkBackground = Color(0xFF0C0C0C);
  static const Color darkCard = Color(0xFF090909);
  static const Color darkCardText = Color(0xFFFFFFFF);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkAccent = Color(0xFF3E64F3);
  static const Color darkAccentText = Color(0xFFFFFFFF);
  static const Color categoryCard = Color(0xFF17AEF4);

  static Color primary(BuildContext context) {
    final controller = Get.find<MainController>();
    final selectedTheme = controller.selectedTheme.value;
    if (selectedTheme == "dark") {
      return darkPrimary;
    } else if (selectedTheme == "system") {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark ? darkPrimary : lightPrimary;
    } else {
      return lightPrimary;
    }
  }

  static Color background(BuildContext context) {
    final controller = Get.find<MainController>();

    final selectedTheme = controller.selectedTheme.value;
    if (selectedTheme == "dark") {
      return darkBackground;
    } else if (selectedTheme == "system") {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark ? darkBackground : lightBackground;
    } else {
      return lightBackground;
    }
  }

  static Color card(BuildContext context) {
    final controller = Get.find<MainController>();

    final selectedTheme = controller.selectedTheme.value;
    if (selectedTheme == "dark") {
      return darkCard;
    } else if (selectedTheme == "system") {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark ? darkCard : lightCard;
    } else {
      return lightCard;
    }
  }

  static Color cardText(BuildContext context) {
    final controller = Get.find<MainController>();

    final selectedTheme = controller.selectedTheme.value;
    if (selectedTheme == "dark") {
      return darkCardText;
    } else if (selectedTheme == "system") {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark ? darkCardText : lightCardText;
    } else {
      return lightCardText;
    }
  }

  static Color text(BuildContext context) {
    final controller = Get.find<MainController>();

    final selectedTheme = controller.selectedTheme.value;
    if (selectedTheme == "dark") {
      return darkText;
    } else if (selectedTheme == "system") {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark ? darkText : lightText;
    } else {
      return lightText;
    }
  }

  static Color accentText(BuildContext context) {
    final controller = Get.find<MainController>();

    final selectedTheme = controller.selectedTheme.value;
    if (selectedTheme == "dark") {
      return darkAccentText;
    } else if (selectedTheme == "system") {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark ? darkAccentText : lightAccentText;
    } else {
      return lightAccentText;
    }
  }

  static Color accent(BuildContext context) {
    final controller = Get.find<MainController>();

    final selectedTheme = controller.selectedTheme.value;
    if (selectedTheme == "dark") {
      return darkAccent;
    } else if (selectedTheme == "system") {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark ? darkAccent : lightAccent;
    } else {
      return lightAccent;
    }
  }

  static Color accentButton(BuildContext context) {
    final controller = Get.find<MainController>();

    final selectedTheme = controller.selectedTheme.value;
    if (selectedTheme == "dark") {
      return darkAccent;
    } else if (selectedTheme == "system") {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark ? darkAccent : lightAccent.withAlpha(10);
    } else {
      return lightAccent.withAlpha(10);
    }
  }
}
