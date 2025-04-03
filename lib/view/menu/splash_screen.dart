/*
        ---------------------------------------
        Project: Crick trivia Game Mobile Application
        Date: April 2, 2024
        Author: Ameer from Pakistan
        ---------------------------------------
        Description: All logic controller for quiz
      */
  import 'dart:async';
  import 'package:cricket_trivia/utils/extensions/extentions.dart';
  import 'package:cricket_trivia/utils/values/style.dart';
  import 'package:cricket_trivia/view/widget/loading.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:get/get.dart';
  import 'menu.dart';

  class SplashScreen extends StatefulWidget {
    const SplashScreen({super.key});

    @override
    _SplashScreenState createState() => _SplashScreenState();
  }

  class _SplashScreenState extends State<SplashScreen> {
    double progress = 0.0;

    @override
    void initState() {
      super.initState();
      _startProgress();
    }

    void _startProgress() {
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (progress < 1.0) {
          setState(() {
            progress += 0.05;
          });
        } else {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 200), () {
            if (mounted) {
              Get.to(() => Menu());
            }
          });
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF042165), Color(0xFFD76D77)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    shadows: [
                      Shadow(
                        offset: Offset(8.w, 8.h),
                        blurRadius: 8.r,
                        color: const Color.fromRGBO(34, 32, 75, 1),
                      ),
                    ],
                  )
                ),
              ),
              91.sbh,
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomLoadingSpinner(),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }