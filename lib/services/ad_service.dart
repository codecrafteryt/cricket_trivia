/*
  ---------------------------------------
  Project: Cricket Trivia Game Mobile Application
  ---------------------------------------
  Description: Google Mobile Ads – app IDs and ad unit IDs for Android & iOS
*/
import 'dart:io';

class AdUnitIds {
  // App IDs (used in AndroidManifest / Info.plist and initialize())
  static const String androidAppId = 'ca-app-pub-1302610560371949~1814722343';
  static const String iosAppId = 'ca-app-pub-1302610560371949~4897148851';

  // Android ad units
  static const String androidBanner = 'ca-app-pub-1302610560371949/7052538907';
  static const String androidInterstitial = 'ca-app-pub-1302610560371949/5739457234';
  static const String androidRewardedInterstitial = 'ca-app-pub-1302610560371949/1632691268';
  static const String androidRewarded = 'ca-app-pub-1302610560371949/9191617085';

  // iOS ad units
  static const String iosBanner = 'ca-app-pub-1302610560371949/6492333959';
  static const String iosInterstitial = 'ca-app-pub-1302610560371949/9661422779';
  static const String iosRewarded = 'ca-app-pub-1302610560371949/2800500954';
  static const String iosRewardedInterstitial = 'ca-app-pub-1302610560371949/3231745796';

  static String get banner => Platform.isIOS ? iosBanner : androidBanner;
  static String get interstitial => Platform.isIOS ? iosInterstitial : androidInterstitial;
  static String get rewarded => Platform.isIOS ? iosRewarded : androidRewarded;
  static String get rewardedInterstitial => Platform.isIOS ? iosRewardedInterstitial : androidRewardedInterstitial;
}
