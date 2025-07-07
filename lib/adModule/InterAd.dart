import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prankers/adModule/AdManager.dart';
import 'package:prankers/adModule/AdStateController.dart';
import 'package:prankers/extensions/app_colors.dart';
import 'package:prankers/extensions/app_text_styles.dart';
import 'package:prankers/provider/MainController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterAd {
  static final InterAd _instance = InterAd._internal();

  factory InterAd() => _instance;

  InterAd._internal();

  final controller = Get.find<MainController>();
  InterstitialAd? _interstitialAd;
  bool _isLoadingAd = false;

  bool get isAdAvailable => _interstitialAd != null;

  RewardedInterstitialAd? _rewardedInterstitialAd;
  bool _isLoadingRewardedInter = false;

  bool get isRewardedAdAvailable => _rewardedInterstitialAd != null;

  Future<void> preloadAd() async {
    if (_isLoadingAd || _interstitialAd != null) return;
    AdManager.instance?.config ??= await AdManager.instance?.getAdConfig();
    if (AdManager.instance?.config?.isInterAdStatus == false) return;
    _isLoadingAd = true;
    InterstitialAd.load(
      adUnitId: AdManager.instance?.config?.inter ?? '',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoadingAd = false;
          debugPrint("Interstitial ad preloaded");
        },
        onAdFailedToLoad: (error) {
          debugPrint("Interstitial failed to preload: $error");
          _isLoadingAd = false;
        },
      ),
    );
  }

  Future<void> preloadRewardedInterstitialAd() async {
    if (_isLoadingRewardedInter || _rewardedInterstitialAd != null) return;
    AdManager.instance?.config ??= await AdManager.instance?.getAdConfig();
    if (AdManager.instance?.config?.isInterAdStatus == false) return;

    _isLoadingRewardedInter = true;
    RewardedInterstitialAd.load(
      adUnitId: AdManager.instance?.config?.rewardedInter ?? '',
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedInterstitialAd = ad;
          _isLoadingRewardedInter = false;
          debugPrint("Rewarded Interstitial Ad preloaded");
        },
        onAdFailedToLoad: (err) {
          debugPrint("Failed to load rewarded interstitial: $err");
          _isLoadingRewardedInter = false;
        },
      ),
    );
  }

  Future<void> showRewardedInterstitialAd(BuildContext context, VoidCallback onRewarded, VoidCallback onFinished) async {
    if (!(AdManager.instance?.config?.isAdStatus ?? false) || controller.isPremium.value) {
      onFinished();
      return;
    }

    if (_rewardedInterstitialAd != null) {
      AdStateController.instance.isShowingInterstitial = true;
      _rewardedInterstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _rewardedInterstitialAd = null;
          preloadRewardedInterstitialAd();
          onFinished();
          Future.delayed(const Duration(milliseconds: 700), () {
            AdStateController.instance.isShowingInterstitial = false;
          });
        },
        onAdFailedToShowFullScreenContent: (ad, err) {
          ad.dispose();
          _rewardedInterstitialAd = null;
          preloadRewardedInterstitialAd();
          onFinished();
          Future.delayed(const Duration(milliseconds: 700), () {
            AdStateController.instance.isShowingInterstitial = false;
          });
        },
      );

      _rewardedInterstitialAd?.show(
        onUserEarnedReward: (ad, reward) {
          onRewarded();
        },
      );
    } else {
      await _showLoadingDialogWithTimeoutReward(context, onFinished);
    }
  }

  Future<bool> isShowInterThisTime() async {
    var prefs = await SharedPreferences.getInstance();
    var interCount = prefs.getInt("COUNT_INTERID_ADTYPE") ?? 0;
    prefs.setInt("COUNT_INTERID_ADTYPE", interCount + 1);
    var type = (AdManager.instance?.config?.interShowType ?? "ON").replaceAll("-BACKOFF", "").split("-").map((value) => value == "ON").toList();
    var mod = interCount % type.length;
    return type[mod];
  }

  Future<bool> isShowInterInitialFlowThisTime() async {
    var prefs = await SharedPreferences.getInstance();
    var interCount = prefs.getInt("COUNT_INTER_INITIAL_ID_ADTYPE") ?? 0;
    prefs.setInt("COUNT_INTER_INITIAL_ID_ADTYPE", interCount + 1);
    var type = (AdManager.instance?.config?.interInitialShowType ?? "ON")
        .replaceAll("-BACKOFF", "")
        .split("-")
        .map((value) => value == "ON")
        .toList();
    var mod = interCount % type.length;
    return type[mod];
  }

  Future<void> showAd(BuildContext context, VoidCallback onFinished) async {
    if (!(AdManager.instance?.config?.isAdStatus ?? false) || controller.isPremium.value) {
      onFinished();
      return;
    }
    if (!await isShowInterThisTime()) {
      onFinished();
      return;
    }
    if (_interstitialAd != null) {
      AdStateController.instance.isShowingInterstitial = true;
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _interstitialAd = null;
          preloadAd();
          onFinished();
          Future.delayed(const Duration(milliseconds: 700), () {
            AdStateController.instance.isShowingInterstitial = false;
          });
        },
        onAdFailedToShowFullScreenContent: (ad, err) {
          ad.dispose();
          _interstitialAd = null;
          preloadAd();
          onFinished();
          Future.delayed(const Duration(milliseconds: 700), () {
            AdStateController.instance.isShowingInterstitial = false;
          });
        },
      );
      _interstitialAd?.show();
    } else {
      await _showLoadingDialogWithTimeout(context, onFinished);
    }
  }

  Future<void> showInitialFlowAd(BuildContext context, VoidCallback onFinished) async {
    if (!(AdManager.instance?.config?.isAdStatus ?? false) || controller.isPremium.value) {
      onFinished();
      return;
    }
    if (!await isShowInterInitialFlowThisTime()) {
      onFinished();
      return;
    }
    if (_interstitialAd != null) {
      AdStateController.instance.isShowingInterstitial = true;
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _interstitialAd = null;
          preloadAd();
          onFinished();
          Future.delayed(const Duration(milliseconds: 700), () {
            AdStateController.instance.isShowingInterstitial = false;
          });
        },
        onAdFailedToShowFullScreenContent: (ad, err) {
          ad.dispose();
          _interstitialAd = null;
          preloadAd();
          onFinished();
          Future.delayed(const Duration(milliseconds: 700), () {
            AdStateController.instance.isShowingInterstitial = false;
          });
        },
      );
      _interstitialAd?.show();
    } else {
      await _showLoadingDialogWithTimeout(context, onFinished);
    }
  }

  Future<void> showForceAd(BuildContext context, VoidCallback onFinished) async {
    if (!(AdManager.instance?.config?.isAdStatus ?? false) || controller.isPremium.value) {
      onFinished();
      return;
    }
    if (_interstitialAd != null) {
      AdStateController.instance.isShowingInterstitial = true;
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _interstitialAd = null;
          preloadAd();
          onFinished();
          Future.delayed(const Duration(milliseconds: 700), () {
            AdStateController.instance.isShowingInterstitial = false;
          });
        },
        onAdFailedToShowFullScreenContent: (ad, err) {
          ad.dispose();
          _interstitialAd = null;
          preloadAd();
          onFinished();
          Future.delayed(const Duration(milliseconds: 700), () {
            AdStateController.instance.isShowingInterstitial = false;
          });
        },
      );
      _interstitialAd?.show();
    } else {
      await _showLoadingDialogWithTimeout(context, onFinished);
    }
  }

  Future<void> _showLoadingDialogWithTimeout(BuildContext context, VoidCallback onFinished) async {
    bool adShown = false;
    showDialog(
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
                  child: CircularProgressIndicator(color: colorAccent, strokeWidth: 2.sp),
                ),
                SizedBox(height: 16),
                Text('Ad loading...', style: AppTextStyles.of(context).bodyLarge, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
    InterstitialAd.load(
      adUnitId: AdManager.instance?.config?.inter ?? '',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (adShown) return;
          Navigator.of(context, rootNavigator: true).pop(); // Close dialog
          adShown = true;
          _interstitialAd = ad;
          showAd(context, onFinished);
        },
        onAdFailedToLoad: (err) {
          if (!adShown) {
            Navigator.of(context, rootNavigator: true).pop(); // Close dialog
            adShown = true;
            onFinished(); // Fallback
          }
        },
      ),
    );
    await Future.delayed(const Duration(seconds: 5));
    if (!adShown) {
      Navigator.of(context, rootNavigator: true).pop(); // Close dialog
      adShown = true;
      onFinished(); // Fallback
    }
  }

  Future<void> _showLoadingDialogWithTimeoutReward(BuildContext context, VoidCallback onFinished) async {
    bool adShown = false;
    showDialog(
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
                  child: CircularProgressIndicator(color: colorAccent, strokeWidth: 2.sp),
                ),
                SizedBox(height: 16),
                Text('Ad loading...', style: AppTextStyles.of(context).bodyLarge, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
    RewardedInterstitialAd.load(
      adUnitId: AdManager.instance?.config?.rewardedInter ?? '',
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (adShown) return;
          Navigator.of(context, rootNavigator: true).pop();
          adShown = true;
          _rewardedInterstitialAd = ad;
          showRewardedInterstitialAd(context, () {}, onFinished);
        },
        onAdFailedToLoad: (err) {
          if (!adShown) {
            Navigator.of(context, rootNavigator: true).pop();
            adShown = true;
            onFinished();
          }
        },
      ),
    );
    await Future.delayed(const Duration(seconds: 5));
    if (!adShown) {
      Navigator.of(context, rootNavigator: true).pop(); // Close dialog
      adShown = true;
      onFinished(); // Fallback
    }
  }
}
