 import 'package:cricket_trivia/utils/extensions/extentions.dart';
import 'package:cricket_trivia/utils/values/my_color.dart';
import 'package:cricket_trivia/utils/values/style.dart';
import 'package:cricket_trivia/view/player/player_screen.dart';
import 'package:cricket_trivia/view/player/top_matches_screen.dart';
import 'package:cricket_trivia/view/quiz/quiz_screen.dart';
import 'package:cricket_trivia/view/widget/custom_app_bar.dart';
import 'package:cricket_trivia/view/widget/custom_button.dart';
import 'package:cricket_trivia/view/widget/music_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

 class Menu extends StatelessWidget {
   const Menu({super.key});
 
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
                     shadows: [
                       Shadow(
                         offset: Offset(8.w, 8.h),
                         blurRadius: 8.r,
                         color: const Color.fromRGBO(34, 32, 75, 1),
                       ),
                     ],
                   ),
               ),
             ),
             45.sbh,
             CustomButton(
                 text: "Quiz",
                 textStyle: kSize14DarkW400Text.copyWith(
                   fontSize: 32.sp,
                   color: const Color.fromRGBO(34, 32, 75, 1),
                 ),
                 height: 92.h,
                 width: 215.w,
                 borderRadius: 32.r,
                 onPressed: (){
                   Get.to(() => QuizScreen(),);
                 }
             ),
             51.sbh,
             CustomButton(
                 text: "Players",
                 textStyle: kSize14DarkW400Text.copyWith(
                   fontSize: 32.sp,
                   color: const Color.fromRGBO(34, 32, 75, 1),
                 ),
                 height: 92.h,
                 width: 215.w,
                 borderRadius: 32.r,
                 onPressed: (){
                   Get.to(() => TopMatchesScreen(),);
                 }
             ),
             71.sbh,
             MusicButton()
           ],
         ),
       ),
     );
   }
 }
 