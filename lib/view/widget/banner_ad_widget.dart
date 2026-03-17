/*
  ---------------------------------------
  Project: Cricket Trivia Game Mobile Application
  ---------------------------------------
  Description: Banner ad placeholder for AdWidget
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cricket_trivia/controller/ad_controller.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  final AdController adController = Get.find<AdController>();
  Worker? _worker;

  @override
  void initState() {
    super.initState();
    _worker = ever(adController.isBannerLoaded, (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _worker?.dispose();
    adController.releaseBannerAd();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    adController.loadBanner(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!adController.isBannerLoaded.value) {
      return const SizedBox.shrink();
    }
    final ad = adController.bannerAd;
    if (ad == null) {
      return const SizedBox.shrink();
    }
    final w = ad.size.width.toDouble();
    final h = ad.size.height.toDouble().clamp(0.0, 150.0);
    return SafeArea(
      child: SizedBox(
        width: w,
        height: h,
        child: AdWidget(ad: ad),
      ),
    );
  }
}
