  /*
        ---------------------------------------
        Project: Crick trivia Game Mobile Application
        Date: April 2, 2024
        Author: Ameer from Pakistan
        ---------------------------------------
        Description: Loading Animation
      */
  import 'dart:math';
  import 'package:flutter/material.dart';

  class CustomLoadingSpinner extends StatefulWidget {
    const CustomLoadingSpinner({Key? key}) : super(key: key);

    @override
    State<CustomLoadingSpinner> createState() => _CustomLoadingSpinnerState();
  }

  class _CustomLoadingSpinnerState extends State<CustomLoadingSpinner> with SingleTickerProviderStateMixin {
    late AnimationController _controller;

    @override
    void initState() {
      super.initState();
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
      )..repeat();
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      // Fixed size of 305x305
      const size = 305.0;
      const radius = size / 2;
      const dashWidth = 46.0; // Scaled for 305px container
      const dashHeight = 12.0; // Scaled for 305px container
      const circleRadius = 122.0; // Position dashes at 80% of radius

      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Rotating dashed circle
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * pi,
                  child: Stack(
                    alignment: Alignment.center,
                    children: List.generate(12, (index) {
                      final angle = index * pi / 6;
                      return Transform.translate(
                        offset: Offset(
                          cos(angle) * circleRadius,
                          sin(angle) * circleRadius,
                        ),
                        child: Transform.rotate(
                          angle: angle + pi/2, // Rotate to align with circle radius
                          child: Container(
                            width: dashWidth,
                            height: dashHeight,
                            decoration: BoxDecoration(
                              color: Colors.green.shade600,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
            // "Load" text
            const Text(
              "Load",
              style: TextStyle(
                color: Colors.white,
                fontSize: 67.0, // Scaled for 305px container
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(6.0, 6.0),
                    blurRadius: 6.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }