/*
        ---------------------------------------
        Project: Crick trivia Game Mobile Application
        Date: April 2, 2024
        Author: Ameer from Pakistan
        ---------------------------------------
        Description: All logic controller for quiz
      */
  import 'package:cricket_trivia/utils/extensions/extentions.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:get/get.dart';
  import '../../controller/quiz_controller.dart';
  import '../../utils/values/my_color.dart';
  import '../../utils/values/style.dart';
  import '../widget/custom_button.dart';

  class MatchDetailsScreen extends StatelessWidget {
    final QuizController controller = Get.find();
    final String title;
    final String story;
    final String image;
    MatchDetailsScreen({required this.title, required this.story, required this.image});
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: MyColors.black,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF042165), Color(0xFFD76D77)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0.h),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Color(0xFFDCFAA0),
                            border: Border.all(color: MyColors.btnBorderColor, width: 13.w),
                            borderRadius: BorderRadius.circular(23.r),
                          ),
                          child: Column(
                            children: [
                              Text(
                                title,
                                textAlign: TextAlign.center,
                                style: kSize14DarkW400Text.copyWith(
                                  color: MyColors.white,
                                  fontSize: 40,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.w, 2.h),
                                      blurRadius: 3.r,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              30.sbh,
                              Text(
                                story,
                                textAlign: TextAlign.center,
                                style: kSize14DarkW400Text.copyWith(
                                  color: MyColors.white,
                                  fontSize: 18,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.w, 2.h),
                                      blurRadius: 3.r,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              60.sbh,
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -46.h,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CustomButton(
                              text: "Read More",
                              textStyle: kSize14DarkW400Text.copyWith(
                                fontSize: 15.sp,
                                color: const Color.fromRGBO(34, 32, 75, 1),
                              ),
                              height: 92.h,
                              width: 155.w,
                              borderRadius: 32.r,
                              onPressed: controller.openMatchStory,
                            ),
                          ),
                        ),
                      ],
                    ),
                    90.sbh,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          text: "Previous",
                          textStyle: kSize14DarkW400Text.copyWith(
                            fontSize: 15.sp,
                            color: const Color.fromRGBO(34, 32, 75, 1),
                          ),
                          height: 92.h,
                          width: 155.w,
                          borderRadius: 32.r,
                          onPressed: () {
                            print("Previous button tapped");
                            Get.back();
                            Future.delayed(Duration(milliseconds: 100), () {
                              controller.previousPage();
                            });
                          },

                        ),
                        10.sbw,
                        CustomButton(
                          text: "Next",
                          textStyle: kSize14DarkW400Text.copyWith(
                            fontSize: 15.sp,
                            color: const Color.fromRGBO(34, 32, 75, 1),
                          ),
                          height: 92.h,
                          width: 155.w,
                          borderRadius: 32.r,
                          onPressed: () {
                            print("Next button tapped");
                            Get.back();
                            Future.delayed(Duration(milliseconds: 100), () {
                              controller.nextPage();
                            });
                          },

                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
