import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prankers/adModule/AdManager.dart';
import 'package:prankers/adModule/InterAd.dart';
import 'package:prankers/extensions/app_colors.dart';
import 'package:prankers/extensions/screen_size.dart';
import 'package:prankers/languages/I10n/app_localizations.dart';
import 'package:prankers/provider/LifecycleHandler.dart';
import 'package:prankers/provider/MainController.dart';
import 'package:prankers/screens/premium/ScreenPremium.dart';

import '../extensions/app_text_styles.dart';
import 'ScreenCategoryItem.dart';

class ScreenPlayer extends StatefulWidget {
  final String? category;
  final String? item;

  const ScreenPlayer({super.key, this.category, this.item});

  @override
  State<ScreenPlayer> createState() => _ScreenPlayerState();
}

class _ScreenPlayerState extends State<ScreenPlayer> {
  final controller = Get.find<MainController>();
  final LifecycleHandler _lifecycleHandler = LifecycleHandler();
  bool isRewarded = false;
  bool isPlayAfter = false;
  bool isPlaying = false;
  bool isLooping = false;
  bool isModified = false;
  int _selectedDelayInSeconds = 5;
  String sound = '';

  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _delayTimer;

  int bannerHeight = 65;
  AdWidget? _adWidget;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    sound = getSound();
    _audioPlayer.onPlayerComplete.listen((event) {
      if (!isLooping || isModified) {
        isModified = false;
        setState(() {
          isPlaying = false;
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _lifecycleHandler.init(context);
    });
  }

  Future<void> _loadAd() async {
    if (controller.isPremium.value == false &&
        AdManager.instance?.config?.isAdStatus == true &&
        AdManager.instance?.config?.isNativeAdStatus == true) {
      final adUnitId = AdManager.instance?.config?.banner ?? 'ca-app-pub-3940256099942544/8388050270';
      final AnchoredAdaptiveBannerAdSize? size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate(),
      );

      if (size == null) {
        debugPrint('Unable to get adaptive banner size.');
        return;
      }

      final BannerAd banner = BannerAd(
        size: size,
        adUnitId: adUnitId,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint('Ad loaded.');
            setState(() {
              var banner = ad as BannerAd;
              bannerHeight = banner.size.height;
              _adWidget = AdWidget(ad: banner);
              _isBannerAdReady = true;
            });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint('Ad failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(extras: {"collapsible": "bottom"}),
      );

      banner.load();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _playSound() async {
    await _audioPlayer.stop();

    _audioPlayer.setReleaseMode(isLooping ? ReleaseMode.loop : ReleaseMode.stop);

    await _audioPlayer.play(AssetSource(sound));
  }

  Future<void> _stopSound() async {
    _delayTimer?.cancel();
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _audioPlayer.dispose();
    _adWidget = null;
    _lifecycleHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    return Obx(() {
      return Scaffold(
        backgroundColor: colorBackground,
        body: Stack(
          children: [
            Image.asset('assets/ic_player_background.webp', width: context.screenWidth, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 24.sp),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 16.sp),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset('assets/icons/ic_navigation_back.webp', width: 56.sp, height: 56.sp, fit: BoxFit.contain),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.off(ScreenPremium());
                        },
                        child: Image.asset(
                          'assets/icons/ic_action_premium.webp',
                          width: context.isTabletSize ? 100.sp : 56.sp,
                          height: context.isTabletSize ? 100.sp : 56.sp,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 16.sp),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: Image.asset('assets/categories/full_vector/${widget.category}/${widget.item}.webp', fit: BoxFit.fitHeight)),
                        SizedBox(height: 12.sp),
                        GestureDetector(
                          onTap: () {
                            if (isPlaying) {
                              _stopSound();
                            } else {
                              if (isRewarded) {
                                if (isPlayAfter) {
                                  _delayTimer?.cancel();
                                  _delayTimer = Timer(Duration(seconds: _selectedDelayInSeconds), () {
                                    _playSound();
                                  });
                                } else {
                                  _playSound();
                                }
                              } else {
                                InterAd().showRewardedInterstitialAd(
                                  context,
                                  () {
                                    isRewarded = true;
                                    if (isPlayAfter) {
                                      _delayTimer?.cancel();
                                      _delayTimer = Timer(Duration(seconds: _selectedDelayInSeconds), () {
                                        _playSound();
                                      });
                                    } else {
                                      _playSound();
                                    }
                                  },
                                  () {
                                    isRewarded = true;
                                    if (isPlayAfter) {
                                      _delayTimer?.cancel();
                                      _delayTimer = Timer(Duration(seconds: _selectedDelayInSeconds), () {
                                        _playSound();
                                      });
                                    } else {
                                      _playSound();
                                    }
                                  },
                                );
                              }
                            }

                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            fit: StackFit.passthrough,
                            children: [
                              Image.asset('assets/icons/${isPlaying ? 'ic_action_button_stop' : 'ic_action_button_play'}.webp', height: 56.sp),
                              Positioned(
                                left: 0,
                                top: 0,
                                right: 0,
                                bottom: 4.sp,
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (controller.isPremium.value == false && AdManager.instance?.config?.isAdStatus == true) ...[
                                        SvgPicture.asset(
                                          'assets/icons/ic_action_crown.svg',
                                          width: 24,
                                          height: 24,
                                          colorFilter: ColorFilter.mode(colorText, BlendMode.srcIn),
                                        ),
                                        SizedBox(width: 12.sp),
                                      ],
                                      Text(
                                        isPlaying ? loc?.action_stop ?? '' : loc?.action_play ?? '',
                                        style: AppTextStyles.of(context).headline5.copyWith(fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.sp),
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12.sp), topRight: Radius.circular(12.sp)),
                    child: Container(
                      color: colorCard,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).padding.bottom +
                              (controller.isPremium.value == false &&
                                      AdManager.instance?.config?.isAdStatus == true &&
                                      AdManager.instance?.config?.isNativeAdStatus == true
                                  ? (_isBannerAdReady ? bannerHeight.toDouble() : 65)
                                  : 0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12.sp, top: 12.sp, right: 12.sp),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _showDelayPicker(context);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)?.action_play_after ?? '',
                                      style: AppTextStyles.of(context).bodyLarge.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(width: 6.sp),
                                  StatefulBuilder(
                                    builder: (context, state) {
                                      return Switch(
                                        value: isPlayAfter,
                                        activeColor: categoryCard,
                                        activeTrackColor: categoryCard.withAlpha(50),
                                        inactiveTrackColor: colorCard,
                                        onChanged: (bool value) {
                                          state(() {
                                            isPlayAfter = value;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  Spacer(),
                                  Text(
                                    AppLocalizations.of(context)?.action_loop ?? '',
                                    style: AppTextStyles.of(context).bodyLarge.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 6.sp),
                                  Switch(
                                    value: isLooping,
                                    activeColor: categoryCard,
                                    activeTrackColor: categoryCard.withAlpha(50),
                                    inactiveTrackColor: colorCard,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isLooping = value;
                                        isModified = true;
                                      });

                                      if (isPlaying) {
                                        _audioPlayer.setReleaseMode(isLooping ? ReleaseMode.loop : ReleaseMode.stop);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.sp),
                              child: SizedBox(height: context.isTabletSize ? 250.sp : 150.sp, child: _buildCategoryList()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (controller.isPremium.value == false &&
                AdManager.instance?.config?.isAdStatus == true &&
                AdManager.instance?.config?.isNativeAdStatus == true)
              if (_isBannerAdReady && _adWidget != null)
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom,
                  left: 0,
                  right: 0,
                  child: SizedBox(width: context.screenWidth, height: bannerHeight.toDouble(), child: _adWidget),
                )
              else
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom,
                  left: 0,
                  right: 0,
                  child: Container(height: 65, color: colorCard),
                ),
          ],
        ),
      );
    });
  }

  Widget buildCategory(String icon, String key, String title) {
    return GestureDetector(
      onTap: () {
        goto(key);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.sp),
        child: Container(
          color: categoryCard,
          child: Stack(
            children: [
              Image.asset('assets/categories/ic_category_bg.webp'),
              Positioned.fill(child: Image.asset('assets/categories/$icon.webp')),
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/categories/ic_category_bg_label.webp', fit: BoxFit.fitWidth),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.only(top: 12.sp),
                        child: Center(
                          child: Text(title, style: AppTextStyles.of(context).accentButton, textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goto(String category) {
    InterAd().showAd(context, () {
      Get.off(ScreenCategoryItem(category: category, isPlayer: true));
    });
  }

  Widget _buildCategoryList() {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      children:
          [
                buildCategory('ic_category_hair_clipper', 'hair_clipper', AppLocalizations.of(context)?.category_hair_clipper ?? ''),
                buildCategory('ic_category_hair_cut', 'hair_cut', AppLocalizations.of(context)?.category_hair_cut ?? ''),
                buildCategory('ic_category_taser', 'taser', AppLocalizations.of(context)?.category_taser ?? ''),
                buildCategory('ic_category_gun', 'gun', AppLocalizations.of(context)?.category_gun ?? ''),
                buildCategory('ic_category_fart', 'fart', AppLocalizations.of(context)?.category_fart ?? ''),
                buildCategory('ic_category_bomb_sound', 'bomb_sound', AppLocalizations.of(context)?.category_bomb_sound ?? ''),
                buildCategory('ic_category_animals', 'animals', AppLocalizations.of(context)?.category_animals ?? ''),
                buildCategory('ic_category_air_horn', 'air_horn', AppLocalizations.of(context)?.category_air_horn ?? ''),
                buildCategory('ic_category_horror_sound', 'horror_sound', AppLocalizations.of(context)?.category_horror_sound ?? ''),
                buildCategory('ic_category_police_siren', 'police_siren', AppLocalizations.of(context)?.category_police_siren ?? ''),
              ]
              .map(
                (widget) => Padding(
                  padding: EdgeInsets.only(right: 12.sp),
                  child: SizedBox(width: context.isTabletSize ? 210.sp : 120.sp, child: widget),
                ),
              )
              .toList(),
    );
  }

  String getSound() {
    return 'sounds/${widget.category}/${widget.item}.mp3';
  }

  void _showDelayPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      backgroundColor: colorCard,
      builder: (_) {
        final List<int> delayOptions = [5, 10, 15, 30, 60];
        return Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: colorText.withAlpha(40), borderRadius: BorderRadius.circular(2)),
              ),
              SizedBox(height: 4.sp),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.sp),
                child: Text('Select Delay Time', style: AppTextStyles.of(context).headline3),
              ),
              ...delayOptions.map((seconds) {
                final label = seconds < 60 ? '$seconds seconds' : '${seconds ~/ 60} minute';
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 2.sp),
                  title: Text(label, style: AppTextStyles.of(context).headline5),
                  onTap: () {
                    _selectedDelayInSeconds = seconds;
                    Navigator.pop(context);
                  },
                );
              }).toList(),

              SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
