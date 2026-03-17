/*
  ---------------------------------------
  Project: Cricket Trivia Game Mobile Application
  ---------------------------------------
  Description: Google Mobile Ads – load/show banner, interstitial, rewarded; 2-turn & 5-min rules
*/
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_service.dart';

class AdController extends GetxController {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  final RxBool isBannerLoaded = false.obs;
  final RxBool isInterstitialLoaded = false.obs;
  final RxBool isRewardedLoaded = false.obs;

  int _questionsAnsweredThisSession = 0;
  Timer? _fiveMinuteTimer;
  bool _fiveMinuteAdShown = false;

  static const int _questionsBetweenInterstitials = 2;
  static const Duration _fiveMinuteInterval = Duration(minutes: 5);

  BannerAd? get bannerAd => _bannerAd;

  @override
  void onInit() {
    super.onInit();
    loadInterstitial();
    loadRewarded();
  }

  @override
  void onClose() {
    _fiveMinuteTimer?.cancel();
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.onClose();
  }

  void startSessionTimer() {
    _fiveMinuteTimer?.cancel();
    _fiveMinuteAdShown = false;
    _fiveMinuteTimer = Timer(_fiveMinuteInterval, () {
      if (!_fiveMinuteAdShown) {
        _fiveMinuteAdShown = true;
        showInterstitial();
      }
    });
  }

  void recordQuestionAnswered() {
    _questionsAnsweredThisSession++;
  }

  bool shouldShowInterstitialAfterThisTurn() {
    return _questionsAnsweredThisSession > 0 &&
        _questionsAnsweredThisSession % _questionsBetweenInterstitials == 0;
  }

  /// Call when [BannerAdWidget] is disposed so the next screen can load a new [BannerAd].
  /// Reusing the same [BannerAd] in a new [AdWidget] after dispose causes SDK assert.
  void releaseBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
    isBannerLoaded.value = false;
  }

  Future<void> loadBanner(BuildContext context) async {
    if (_bannerAd != null) return;
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.sizeOf(context).width.truncate(),
    );
    if (size == null) return;
    _bannerAd = BannerAd(
      adUnitId: AdUnitIds.banner,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => isBannerLoaded.value = true,
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          _bannerAd = null;
        },
      ),
    )..load();
  }

  void loadInterstitial() {
    InterstitialAd.load(
      adUnitId: AdUnitIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd?.dispose();
          _interstitialAd = ad;
          _setInterstitialCallbacks(ad);
          isInterstitialLoaded.value = true;
        },
        onAdFailedToLoad: (err) {
          debugPrint('Interstitial failed to load: $err');
          isInterstitialLoaded.value = false;
        },
      ),
    );
  }

  void _setInterstitialCallbacks(InterstitialAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _interstitialAd = null;
        isInterstitialLoaded.value = false;
        loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (a, e) {
        a.dispose();
        _interstitialAd = null;
        isInterstitialLoaded.value = false;
        loadInterstitial();
      },
    );
  }

  void showInterstitial({VoidCallback? whenClosed}) {
    if (_interstitialAd == null) {
      whenClosed?.call();
      return;
    }
    final ad = _interstitialAd!;
    _interstitialAd = null;
    isInterstitialLoaded.value = false;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        loadInterstitial();
        whenClosed?.call();
      },
      onAdFailedToShowFullScreenContent: (a, e) {
        a.dispose();
        loadInterstitial();
        whenClosed?.call();
      },
    );
    ad.show();
  }

  void loadRewarded() {
    RewardedAd.load(
      adUnitId: AdUnitIds.rewarded,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd?.dispose();
          _rewardedAd = ad;
          _setRewardedCallbacks(ad);
          isRewardedLoaded.value = true;
        },
        onAdFailedToLoad: (err) {
          debugPrint('Rewarded failed to load: $err');
          isRewardedLoaded.value = false;
        },
      ),
    );
  }

  void _setRewardedCallbacks(RewardedAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _rewardedAd = null;
        isRewardedLoaded.value = false;
        loadRewarded();
      },
      onAdFailedToShowFullScreenContent: (a, e) {
        a.dispose();
        _rewardedAd = null;
        isRewardedLoaded.value = false;
        loadRewarded();
      },
    );
  }

  void showRewarded({
    required VoidCallback onReward,
    VoidCallback? onFailedToShow,
    VoidCallback? onAdDismissedWithoutReward,
  }) {
    if (_rewardedAd == null) {
      onFailedToShow?.call();
      return;
    }
    final ad = _rewardedAd!;
    _rewardedAd = null;
    isRewardedLoaded.value = false;
    var rewardEarned = false;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        loadRewarded();
        if (rewardEarned) {
          onReward();
        } else {
          onAdDismissedWithoutReward?.call();
        }
      },
      onAdFailedToShowFullScreenContent: (a, e) {
        a.dispose();
        loadRewarded();
        onFailedToShow?.call();
      },
    );
    ad.show(
      onUserEarnedReward: (_, __) => rewardEarned = true,
    );
  }
}
