  /*
          ---------------------------------------
          Project: Crick trivia Game Mobile Application
          Date: April 2, 2024
          Author: Ameer from Pakistan
          ---------------------------------------
          Description: All logic controller for quiz
        */
  import 'package:cricket_trivia/controller/quiz_controller.dart';
  import 'package:cricket_trivia/utils/extensions/extentions.dart';
  import 'package:cricket_trivia/utils/values/my_color.dart';
  import 'package:cricket_trivia/utils/values/style.dart';
  import 'package:cricket_trivia/view/menu/menu.dart';
  import 'package:cricket_trivia/view/quiz/quiz_screen.dart';
  import 'package:cricket_trivia/view/widget/custom_app_bar.dart';
  import 'package:cricket_trivia/view/widget/custom_button.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:get/get.dart';

  class ResultScreen extends StatelessWidget {
    final QuizController controller = Get.find();
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF042165), Color(0xFFD76D77)],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppBar(onMusicTap: (){}, onMenuTap: (){}),
                  24.sbh,
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: MyColors.btnColor,
                      borderRadius: BorderRadius.circular(32.r),
                      border: Border.all(
                        color: MyColors.btnBorderColor,
                        width: 13.w,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Result:",
                          style: kSize11DarkW500Text.copyWith(
                            color: Colors.white,
                            fontSize: 45,
                            shadows: [
                              Shadow(
                                offset: Offset(2.w, 2.h),
                                blurRadius: 2.r,
                                color: const Color.fromRGBO(34, 32, 75, 1),
                              ),
                            ],
                          ),
                        ),
                       16.sbh,
                        Text(
                          "${controller.score.value}/${controller.questions.length}",
                          style: kSize14DarkW400Text.copyWith(
                            fontSize: 96.sp,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(2.w, 2.h),
                                blurRadius: 2.r,
                                color: const Color.fromRGBO(34, 32, 75, 1),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                  113.sbh,
                  CustomButton(
                      text: "Retry",
                      textStyle: kSize14DarkW400Text.copyWith(
                        color: Colors.white,
                        fontSize: 32.sp,
                        shadows: [
                          Shadow(
                            offset: Offset(2.w, 2.h),
                            blurRadius: 2.r,
                            color: const Color.fromRGBO(34, 32, 75, 1),
                          ),
                        ],
                      ),
                      height: 92.h,
                      width: 215.w,
                      borderRadius: 32.r,
                      onPressed: (){
                        controller.resetQuiz();
                        Get.offAll(() => QuizScreen());
                      }
                  ),
                  51.sbh,
                  CustomButton(
                      text: "Menu",
                      textStyle: kSize14DarkW400Text.copyWith(
                        color: Colors.white,
                        fontSize: 32.sp,
                        shadows: [
                          Shadow(
                            offset: Offset(2.w, 2.h),
                            blurRadius: 2.r,
                            color: const Color.fromRGBO(34, 32, 75, 1),
                          ),
                        ],
                      ),
                      height: 92.h,
                      width: 215.w,
                      borderRadius: 32.r,
                      onPressed: (){
                        controller.resetQuiz();
                        Get.offAll(() => Menu());
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }