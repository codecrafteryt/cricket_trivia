/*
      ---------------------------------------
      Project: Crick trivia Game Mobile Application
      Date: April 2, 2024
      Author: Ameer from Pakistan
      ---------------------------------------
      Description: Custom Music Button
    */
import 'package:cricket_trivia/controller/sound_controller.dart';
import 'package:cricket_trivia/utils/values/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MusicButton extends StatelessWidget {
  const MusicButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Get your SoundController instance
    final SoundController soundController = Get.find();

    return GestureDetector(
      onTap: () {
        soundController.toggleMusic();
      },
      child: Container(
        width: 92.w,
        height: 92.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          color: MyColors.btnColor,
          border: Border.all(
            color: MyColors.btnBorderColor,
            width: 13.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(32.r),
              child: Image.asset(
                height: 55.h,
                width: 55.w,
                'assets/images/music.png',
                fit: BoxFit.contain,
              ),
            ),
            // Red line overlay when music is off
            Obx(() => soundController.isMusicOn.value
                ? const SizedBox.shrink()
                : CustomPaint(
              size: Size(70.w, 70.h),
              painter: LinePainter(),
            )),
          ],
        ),
      ),
    );
  }
}

// Custom painter for drawing the red line
class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.2),
      Offset(size.width * 0.8, size.height * 0.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}