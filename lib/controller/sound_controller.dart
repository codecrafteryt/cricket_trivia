  /*
          ---------------------------------------
          Project: Crick trivia Game Mobile Application
          Date: April 2, 2024
          Author: Ameer from Pakistan
          ---------------------------------------
          Description: All logic controller for quiz
        */
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:audioplayers/audioplayers.dart';

  class SoundController extends GetxController {
    final SharedPreferences sharedPreferences;
    SoundController({required this.sharedPreferences});

    // Audio player for background music only
    final AudioPlayer _backgroundMusicPlayer = AudioPlayer();

    // SharedPreferences key
    static const String _musicKey = 'music_enabled';

    // Observable with saved state
    late RxBool isMusicOn;

    // Getter for audio player
    AudioPlayer get backgroundMusicPlayer => _backgroundMusicPlayer;

    void _setupAudio() async {
      try {
        // Setup background music
        await _setupBackgroundMusic();
      } catch (e) {
        debugPrint('Error setting up audio: $e');
      }
    }

    Future<void> _setupBackgroundMusic() async {
      try {
        // Configure audio to continue playing in background
        await _backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
        await _backgroundMusicPlayer.setPlayerMode(PlayerMode.mediaPlayer);
        await _backgroundMusicPlayer.setSourceAsset('audio/music.wav'); // Set the audio source

        if (isMusicOn.value) {
          // Start playing if music is enabled
          await _backgroundMusicPlayer.resume();
        }
      } catch (e) {
        debugPrint('Error setting up background music: $e');
      }
    }

    void toggleMusic() {
      isMusicOn.value = !isMusicOn.value; // Toggle music state
      sharedPreferences.setBool(_musicKey, isMusicOn.value); // Save to SharedPreferences

      if (isMusicOn.value) {
        _backgroundMusicPlayer.resume();
      } else {
        _backgroundMusicPlayer.pause();
      }
    }

    @override
    void onInit() {
      super.onInit();
      // Load saved settings, default to false
      isMusicOn = RxBool(sharedPreferences.getBool(_musicKey) ?? false);

      Future.delayed(Duration.zero, () {
        _setupAudio();
      });
    }

    @override
    void onClose() {
      _backgroundMusicPlayer.dispose();
      super.onClose();
    }
  }