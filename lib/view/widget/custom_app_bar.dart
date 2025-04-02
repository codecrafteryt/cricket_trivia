import 'package:cricket_trivia/utils/values/my_color.dart';
import 'package:cricket_trivia/utils/values/style.dart';
import 'package:cricket_trivia/view/menu/menu.dart';
import 'package:cricket_trivia/view/widget/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'music_button.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onMusicTap;
  final VoidCallback onMenuTap;

  const CustomAppBar({
    Key? key,
    this.title = "QUIZ",
    this.fontSize = 32.0,
    this.textColor = Colors.white,
    this.backgroundColor = const Color(0xFFD2F5B0),
    this.borderColor = const Color(0xFF2C5530),
    required this.onMusicTap,
    required this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.07; // Scalable icon size
    double borderWidth = MediaQuery.of(context).size.width * 0.008; // Scalable border

    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MusicButton(),
          Text(
            title,
            style: kSize14DarkW400Text.copyWith(
              fontSize: 45.sp,
              color: MyColors.white,
            )
          ),
          BackButtons(
            onTap: (){
              Get.to(() => Menu());
            },
          )
        ],
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback onTap,
    required Widget icon,
    required double iconSize,
    required double borderWidth,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(iconSize * 0.3),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(iconSize),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: icon,
      ),
    );
  }
}
