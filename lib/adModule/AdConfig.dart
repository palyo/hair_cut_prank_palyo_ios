class AdConfig {
  bool? isAdStatus;
  bool? isUrlRedirectStatus;
  bool? isInterAdStatus;
  bool? isOpenAdStatus;
  bool? isNativeAdStatus;
  bool? isNativeInitialAdStatus;
  String? redirectUrl;
  String? interShowType;
  String? interInitialShowType;
  String? nativeAd;
  String? inter;
  String? rewardedInter;
  String? banner;
  String? open;
  String? versionCode;
  String? privacyPolicy;
  String? termsOfUse;
  AdConfig({
    this.isAdStatus,
    this.isUrlRedirectStatus,
    this.isInterAdStatus,
    this.isOpenAdStatus,
    this.isNativeAdStatus,
    this.isNativeInitialAdStatus,
    this.redirectUrl,
    this.interShowType,
    this.interInitialShowType,
    this.nativeAd,
    this.inter,
    this.banner,
    this.open,
    this.versionCode,
    this.privacyPolicy,
    this.termsOfUse,
  });
  AdConfig.fromJson(Map<String, dynamic> json) {
    isAdStatus = json['isAdStatus'];
    isUrlRedirectStatus = json['isUrlRedirectStatus'];
    isInterAdStatus = json['isInterAdStatus'];
    isOpenAdStatus = json['isOpenAdStatus'];
    isNativeAdStatus = json['isNativeAdStatus'];
    isNativeInitialAdStatus = json['isNativeInitialAdStatus'];
    redirectUrl = json['redirectUrl'];
    interShowType = json['interShowType'];
    interInitialShowType = json['interInitialShowType'];
    nativeAd = json['native'];
    inter = json['inter'];
    rewardedInter = json['rewardedInter'];
    banner = json['banner'];
    open = json['open'];
    versionCode = json['versionCode'];
    privacyPolicy = json['privacyPolicy'];
    termsOfUse = json['termsOfUse'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAdStatus'] = isAdStatus;
    data['isUrlRedirectStatus'] = isUrlRedirectStatus;
    data['isInterAdStatus'] = isInterAdStatus;
    data['isOpenAdStatus'] = isOpenAdStatus;
    data['isNativeAdStatus'] = isNativeAdStatus;
    data['isNativeInitialAdStatus'] = isNativeInitialAdStatus;
    data['redirectUrl'] = redirectUrl;
    data['interShowType'] = interShowType;
    data['interInitialShowType'] = interInitialShowType;
    data['native'] = nativeAd;
    data['inter'] = inter;
    data['rewardedInter'] = rewardedInter;
    data['banner'] = banner;
    data['open'] = open;
    data['versionCode'] = versionCode;
    data['privacyPolicy'] = privacyPolicy;
    data['termsOfUse'] = termsOfUse;
    return data;
  }
}
