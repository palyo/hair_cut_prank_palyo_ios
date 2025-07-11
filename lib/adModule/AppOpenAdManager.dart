import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prankers/adModule/AdManager.dart';
import 'package:prankers/extensions/app_colors.dart';
import 'package:prankers/extensions/app_text_styles.dart';
import 'package:prankers/provider/MainController.dart';

class AppOpenAdManager {
  static final AppOpenAdManager _instance = AppOpenAdManager._internal();
  factory AppOpenAdManager() => _instance;
  final controller = Get.find<MainController>();
  AppOpenAdManager._internal();
  AppOpenAd? _appOpenAd;
  bool _isLoading = false;
  bool _isShowingAd = false;
  DateTime? _loadTime;
  Future<void> preloadAd() async {
    if (_isLoading || _appOpenAd != null) return;
    AdManager.instance?.config ??= await AdManager.instance?.getAdConfig();
    if (AdManager.instance?.config?.isOpenAdStatus == false) return;
    _isLoading = true;
    AppOpenAd.load(
      adUnitId: AdManager.instance?.config?.open ?? '',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _loadTime = DateTime.now();
          _isLoading = false;
        },
        onAdFailedToLoad: (error) {
          _isLoading = false;
          debugPrint('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  bool get isAdAvailable {
    return _appOpenAd != null &&
        _loadTime != null &&
        DateTime.now().difference(_loadTime!).inHours < 4;
  }

  Future<void> showAdIfAvailable(
    BuildContext context, {
    Function(bool)? onFailed,
  }) async {
    if (controller.isPremium.value) {
      onFailed?.call(true);
      return;
    }
    if (_isShowingAd) return;
    if (isAdAvailable) {
      _showAd(context, onFailed: onFailed);
    } else {
      _loadAndShowRuntime(context, onFailed: onFailed);
    }
  }

  void _showAd(BuildContext context, {Function(bool)? onFailed}) {
    if (_appOpenAd == null) {
      onFailed?.call(true);
      return;
    }
    _isShowingAd = true;
    _appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => debugPrint('Ad showed'),
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        preloadAd();
        onFailed?.call(false);
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        preloadAd();
        onFailed?.call(true);
      },
    );
    _appOpenAd?.show();
  }

  Future<void> _loadAndShowRuntime(
    BuildContext context, {
    Function(bool)? onFailed,
  }) async {
    if (_isLoading) return;
    _isLoading = true;
    final Completer<void> adShown = Completer<void>();
    _showLoadingDialog(context);
    Timer(const Duration(seconds: 5), () {
      if (!adShown.isCompleted) {
        Navigator.of(context, rootNavigator: true).pop(); // close dialog
        _isLoading = false;
        onFailed?.call(true);
        adShown.complete();
      }
    });
    AppOpenAd.load(
      adUnitId: AdManager.instance?.config?.open ?? '',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _loadTime = DateTime.now();
          if (!adShown.isCompleted) {
            Navigator.of(context, rootNavigator: true).pop();
            _showAd(context, onFailed: onFailed);
            adShown.complete();
            onFailed?.call(false);
          }
        },
        onAdFailedToLoad: (error) {
          if (!adShown.isCompleted) {
            Navigator.of(context, rootNavigator: true).pop();
            _isLoading = false;
            onFailed?.call(true);
            adShown.complete();
          }
        },
      ),
    );
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: colorBackground,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: SizedBox(
            width: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 24.sp,
                  height: 24.sp,
                  child: CircularProgressIndicator(
                    color: colorAccent,
                    strokeWidth: 2.sp,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Ad loading...',
                  style: AppTextStyles.of(context).bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
