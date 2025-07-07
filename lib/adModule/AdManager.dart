import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AdConfig.dart';

class AdManager {
  static AdManager? _instance;
  List<NativeAd> nativeFullList = <NativeAd>[];
  List<NativeAd> nativeLanguageList = <NativeAd>[];
  List<NativeAd> nativeOnboardingList = <NativeAd>[];
  List<NativeAd> nativeSmallOnboardingList = <NativeAd>[];

  AdManager._();

  static AdManager? get instance {
    _instance ??= AdManager._();
    return _instance;
  }

  AdConfig? config;

  void setAdConfig(AdConfig? fig) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;
    config = fig;
    if (config?.versionCode == versionName || config?.versionCode?.split(',').contains(versionName) == true) {
      config?.isAdStatus = false;
    }
    if (kDebugMode) {
      print('versionName: $versionName');
      print('versionCode: ${config?.versionCode}');
      print('isAdStatus: ${config?.isAdStatus}');
    }
    String jsonStr = jsonEncode(config?.toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ad_config', jsonStr);
  }

  Future<AdConfig?> getAdConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = prefs.getString('ad_config');
    if (json != null) {
      AdConfig savedConfig = AdConfig.fromJson(jsonDecode(json));
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String versionName = packageInfo.version;
      if (config?.versionCode?.split(',').contains(versionName) == true) {
        savedConfig.isAdStatus = false;
      }
      return savedConfig;
    } else {
      return null;
    }
  }
}
