import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prankers/adModule/AdManager.dart';

typedef AdList = List<NativeAd>;

class NativeAdPool {
  NativeAdPool({
    required this.tag,
    required AdList Function() list,
    this.adUnitId,
    required this.factoryId,
  }) : _listGetter = list;

  final String tag;
  final AdList Function() _listGetter;
  final String? adUnitId;
  final String factoryId;

  Future<void> init(BuildContext context) async {
    AdManager.instance?.config ??= await AdManager.instance?.getAdConfig();
    if (AdManager.instance?.config?.isAdStatus == false) return;
    _preloadAdsIfNeeded();
  }

  bool get isNativeAvailable => _listGetter().isNotEmpty;

  NativeAd? getNativeAd() {
    final list = _listGetter();
    if (list.isNotEmpty) {
      final ad = list.removeAt(0);
      _preloadAdsIfNeeded();
      return ad;
    }
    return null;
  }

  void loadAdWithCallback(void Function(NativeAd?) onLoaded) {
    final preloaded = getNativeAd();
    if (preloaded != null) {
      onLoaded(preloaded);
      return;
    }
    _loadNativeAd(onLoaded: onLoaded);
  }

  void _preloadAdsIfNeeded() {
    final list = _listGetter();
    final adsToLoad = 1 - list.length;
    for (var i = 0; i < adsToLoad; i++) {
      _loadNativeAd(storeInPool: true);
    }
  }

  void _loadNativeAd({
    bool storeInPool = false,
    void Function(NativeAd?)? onLoaded,
  }) {
    final nativeAd = NativeAd(
      adUnitId: adUnitId ?? AdManager.instance?.config?.nativeAd ?? '',
      factoryId: factoryId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('$tag: Native Ad Loaded');
          if (storeInPool) _listGetter().add(ad as NativeAd);
          onLoaded?.call(ad as NativeAd);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('$tag: Native Ad Failed -> ${error.message}');
          ad.dispose();
          onLoaded?.call(null);
        },
      ),
    );
    nativeAd.load();
  }
}
