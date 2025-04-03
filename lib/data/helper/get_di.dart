  /*
        ---------------------------------------
        Project: Cricket Trivia Game Mobile Application
        Date: April 1, 2024
        Author: Ameer from Pakistan
        ---------------------------------------
        Description: Dependency Injection
      */
  import 'package:cricket_trivia/controller/quiz_controller.dart';
  import 'package:cricket_trivia/controller/sound_controller.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:get/get_instance/get_instance.dart';
  import 'package:shared_preferences/shared_preferences.dart';

  class DependencyInjection { // controllers DI
    static void init() async {
      final sharedPreferences = await SharedPreferences.getInstance();
      Get.lazyPut(() => sharedPreferences, fenix: true);
     Get.lazyPut(() => QuizController(sharedPreferences: Get.find(),), fenix: true);
     Get.lazyPut(() => SoundController(sharedPreferences: Get.find(),), fenix: true);
      // Get.put<SettingController>(SettingController(sharedPreferences: sharedPreferences),  permanent: true);
    }
  }