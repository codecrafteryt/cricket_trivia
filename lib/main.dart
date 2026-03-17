/*
        ---------------------------------------
        Project: Cricket Trivia Game Mobile Application
        Date: April 2, 2024
        Author: Ameer from Pakistan
        ---------------------------------------
        Description: App entry – Mobile Ads, DI, upgrade check, portrait only
      */
  import 'package:cricket_trivia/view/menu/splash_screen.dart';
  import 'package:cricket_trivia/view/widget/upgrade_bottom_sheet.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:get/get_navigation/src/root/get_material_app.dart';
  import 'package:get/get_navigation/src/routes/transitions_type.dart';
  import 'package:google_mobile_ads/google_mobile_ads.dart';
  import 'data/helper/get_di.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await MobileAds.instance.initialize();
    DependencyInjection.init();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});
    @override
    Widget build(BuildContext context) {
      ScreenUtil.init(context);
      return ScreenUtilInit(
          designSize: const Size(375, 880),
          minTextAdapt: false,
          splitScreenMode: false,
          builder: (_, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              defaultTransition: Transition.leftToRight,
              home: const UpgradeBottomSheetWidget(child: SplashScreen()),
            );
          });
    }
  }
