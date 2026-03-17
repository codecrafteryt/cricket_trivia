/*
---------------------------------------
Project: Crick trivia Game Mobile Application
Date: March 29, 2024
Author: Ameer from Pakistan
---------------------------------------
Description: Menu UI code
*/

import 'package:cricket_trivia/controller/ad_controller.dart';
import 'package:cricket_trivia/utils/extensions/extentions.dart';
import 'package:cricket_trivia/utils/values/style.dart';
import 'package:cricket_trivia/view/player/top_matches_screen.dart';
import 'package:cricket_trivia/view/quiz/quiz_screen.dart';
import 'package:cricket_trivia/view/widget/banner_ad_widget.dart';
import 'package:cricket_trivia/view/widget/custom_button.dart';
import 'package:cricket_trivia/view/widget/music_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  void initState() {
    super.initState();
    Get.find<AdController>().startSessionTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF042165),
              Color(0xFFD76D77),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              /// Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Image.asset(
                        'assets/images/icon.png',
                        width: 255.w,
                        height: 255.h,
                      ),

                      12.sbh,

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Stump the Fans: \nCricket Trivia",
                          textAlign: TextAlign.center,
                          style: kSize11DarkW500Text.copyWith(
                            color: Colors.white,
                            fontSize: 45,
                          ),
                        ),
                      ),
                      10.sbh,
                      CustomButton(
                        text: "Quiz",
                        textStyle: kSize11DarkW500Text.copyWith(
                          color: Colors.black,
                          fontSize: 45,
                        ),
                        height: 92.h,
                        width: 215.w,
                        borderRadius: 32.r,
                        onPressed: () {
                          Get.to(() => QuizScreen());
                        },
                      ),
                      10.sbh,
                      /// Players Button
                      CustomButton(
                        text: "Players",
                        textStyle: kSize11DarkW500Text.copyWith(
                          color: Colors.black,
                          fontSize: 45,
                        ),
                        height: 92.h,
                        width: 215.w,
                        borderRadius: 32.r,
                        onPressed: () {
                          Get.to(() => TopMatchesScreen());
                        },
                      ),
                      20.sbh,
                      MusicButton(),
                      40.sbh,
                    ],
                  ),
                ),
              ),
              /// Banner Ad Fixed at Bottom (max height to avoid overflow)
              SizedBox(
                height: 100,
                child: const BannerAdWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}