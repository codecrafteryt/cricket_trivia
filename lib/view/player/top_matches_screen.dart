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
  import 'package:cricket_trivia/view/widget/custom_app_bar.dart';
  import 'package:cricket_trivia/view/widget/custom_button.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import '../../utils/values/my_color.dart';
  import '../../utils/values/style.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';

  class TopMatchesScreen extends StatelessWidget {
    final QuizController controller = Get.find();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                50.sbh,
                CustomAppBar(onMusicTap: (){}, onMenuTap: (){}),
                42.sbh,
                SizedBox(
                  height: 650.h,
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.currentPage.value = index;
                    },
                    itemCount: controller.matches.length,
                    itemBuilder: (context, index) {
                      final match = controller.matches[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w,),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              height: 503.h,
                              width: 593.w,
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: Color(0xFFDCFAA0),
                                border: Border.all(color: MyColors.btnBorderColor, width: 13.w),
                                borderRadius: BorderRadius.circular(23.r),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.r),
                                          child: Image.asset(
                                            match["image"]!,
                                            height: 308.h,
                                            width: 308.w,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        30.sbh,
                                        Text(
                                          match["title"]!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(2.w, 2.h),
                                                blurRadius: 3.r,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 450.h,
                              child: Column(
                                children: [
                                  CustomButton(
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
                                  17.sbh,
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
                                        onPressed: controller.previousPage,
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
                                        onPressed: controller.nextPage,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }