/*
      ---------------------------------------
      Project: Crick trivia Game Mobile Application
      Date: April 2, 2024
      Author: Ameer from Pakistan
      ---------------------------------------
      Description: Quiz Screen UI
    */
  import 'package:cricket_trivia/controller/ad_controller.dart';
  import 'package:cricket_trivia/controller/quiz_controller.dart';
  import 'package:cricket_trivia/utils/extensions/extentions.dart';
  import 'package:cricket_trivia/utils/values/style.dart';
  import 'package:cricket_trivia/view/widget/custom_app_bar.dart';
  import 'package:cricket_trivia/view/widget/custom_button.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:get/get.dart';
  import '../../utils/values/my_color.dart' show MyColors;

  class QuizScreen extends StatelessWidget {
    final QuizController quizController = Get.find();
    final AdController adController = Get.find();
    QuizScreen({Key? key}) : super(key: key);

    void _showReviveDialog(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF042165),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            border: Border.all(color: MyColors.btnBorderColor, width: 4),
          ),
          padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 32.h + MediaQuery.of(ctx).padding.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Wrong answer!',
                style: kSize11DarkW500Text.copyWith(
                  color: Colors.white,
                  fontSize: 26.sp,
                ),
              ),
              12.sbh,
              Text(
                'Watch a short ad to continue from here, or restart from level 1.',
                textAlign: TextAlign.center,
                style: kSize14DarkW400Text.copyWith(
                  color: MyColors.btnColor,
                  fontSize: 16.sp,
                ),
              ),
              24.sbh,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Restart',
                      textStyle: kSize14DarkW400Text.copyWith(
                        fontSize: 16.sp,
                        color: const Color(0xFF042165),
                      ),
                      height: 56.h,
                      width: double.infinity,
                      borderRadius: 20.r,
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        quizController.restartFromBeginning();
                      },
                    ),
                  ),
                  16.sbw,
                  Expanded(
                    child: CustomButton(
                      text: 'Revive',
                      textStyle: kSize14DarkW400Text.copyWith(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                      height: 56.h,
                      width: double.infinity,
                      borderRadius: 20.r,
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        adController.showRewarded(
                          onReward: quizController.continueAfterRevive,
                          onFailedToShow: () => quizController.restartFromBeginning(),
                          onAdDismissedWithoutReward: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

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
            child: Obx(() {
              if (quizController.showReviveDialog.value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  quizController.showReviveDialog.value = false;
                  _showReviveDialog(context);
                });
              }
              return Column(
              children: [
                CustomAppBar(onMusicTap: () {}, onMenuTap: () {}),
                Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Container(
                    width: 350.w,
                    height: 400.h,
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
                        Container(
                          height: 180.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          child: quizController.questions[quizController.currentQuestionIndex.value].imagePath != null
                              ? Image.asset(
                            quizController.questions[quizController.currentQuestionIndex.value].imagePath!,
                            fit: BoxFit.contain,
                          )
                              : const Center(
                            child: Icon(
                              Icons.sports_cricket,
                              size: 100,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              quizController.questions[quizController.currentQuestionIndex.value].question,
                              textAlign: TextAlign.center,
                              style: kSize14DarkW400Text.copyWith(
                                fontSize: 30.sp,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(2.w, 2.h),
                                    blurRadius: 2.r,
                                    color: MyColors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: List.generate(
                      quizController.questions[quizController.currentQuestionIndex.value].options.length,
                          (index) => _buildAnswerOption(index, quizController),
                    ),
                  ),
                ),
              ],
            );
            }),
          ),
        ),
      );
    }

    Widget _buildAnswerOption(int index, QuizController controller) {
      bool isSelected = controller.selectedAnswerIndex.value == index;
      bool isCorrect = controller.questions[controller.currentQuestionIndex.value].correctAnswerIndex == index;
      Color optionColor = isSelected
          ? (isCorrect ? Colors.green : Color.fromRGBO(242, 126, 58, 1))
          : (controller.isAnswered.value && isCorrect ? Colors.green : MyColors.btnColor);
      return GestureDetector(
        onTap: () {
          if (!controller.isAnswered.value) {
            controller.answerQuestion(index);
          }
        },
        child: Container(
          height: 92.h,
          width: 155.w,
          decoration: BoxDecoration(
            color: optionColor,
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(
              color: MyColors.btnBorderColor,
              width: 13.w,
            ),
          ),
          child: Center(
            child: Text(
              controller.questions[controller.currentQuestionIndex.value].options[index],
              textAlign: TextAlign.center,
              style: kSize14DarkW400Text.copyWith(
                fontSize: 15.sp,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2.w, 2.h),
                    blurRadius: 2.r,
                    color: MyColors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }