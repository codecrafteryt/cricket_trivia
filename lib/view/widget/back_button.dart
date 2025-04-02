/*
      ---------------------------------------
      Project: Crick trivia Game Mobile Application
      Date: April 2, 2024
      Author: Ameer from Pakistan
      ---------------------------------------
      Description: Custom Back Button
    */
import 'package:cricket_trivia/utils/values/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButtons extends StatelessWidget {
  final VoidCallback onTap;
  const BackButtons({super.key, required this.onTap,});
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2.r),
          child: Image.asset(
            height: 55.h,
            width: 55.w,
            'assets/images/backBtn.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
