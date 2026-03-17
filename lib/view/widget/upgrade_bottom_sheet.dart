/*
  ---------------------------------------
  Project: Cricket Trivia Game Mobile Application
  ---------------------------------------
  Description: New update bottom sheet using upgrader package
*/
import 'package:cricket_trivia/utils/extensions/extentions.dart';
import 'package:cricket_trivia/utils/values/my_color.dart';
import 'package:cricket_trivia/utils/values/style.dart';
import 'package:cricket_trivia/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgrader/upgrader.dart';

class UpgradeBottomSheetWidget extends StatefulWidget {
  final Widget child;

  const UpgradeBottomSheetWidget({super.key, required this.child});

  @override
  State<UpgradeBottomSheetWidget> createState() => _UpgradeBottomSheetWidgetState();
}

class _UpgradeBottomSheetWidgetState extends State<UpgradeBottomSheetWidget> {
  final Upgrader _upgrader = Upgrader(
    durationUntilAlertAgain: const Duration(days: 3),
    debugLogging: false,
  );
  bool _initialized = false;
  bool _bottomSheetShownThisSession = false;

  @override
  void initState() {
    super.initState();
    _initAndListen();
  }

  Future<void> _initAndListen() async {
    await _upgrader.initialize();
    if (!mounted) return;
    setState(() => _initialized = true);
    _upgrader.updateVersionInfo().then((_) {
      if (!mounted) return;
      _upgrader.updateStream();
    });
    _upgrader.stateStream.listen((_) {
      if (!mounted || _bottomSheetShownThisSession) return;
      if (_upgrader.shouldDisplayUpgrade()) {
        _bottomSheetShownThisSession = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _showUpgradeBottomSheet();
        });
      }
    });
  }

  void _showUpgradeBottomSheet() {
    final releaseNotes = _upgrader.releaseNotes ?? 'Bug fixes and improvements.';
    final storeVersion = _upgrader.currentAppStoreVersion ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF042165),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          border: Border.all(color: MyColors.btnBorderColor, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 32.h + MediaQuery.of(ctx).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: MyColors.btnColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            24.sbh,
            Text(
              'New Update Available',
              textAlign: TextAlign.center,
              style: kSize11DarkW500Text.copyWith(
                color: Colors.white,
                fontSize: 26.sp,
                shadows: [
                  Shadow(
                    offset: Offset(2.w, 2.h),
                    blurRadius: 2.r,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            if (storeVersion.isNotEmpty) ...[
              8.sbh,
              Text(
                'Version $storeVersion',
                style: kSize14DarkW400Text.copyWith(
                  color: MyColors.btnColor,
                  fontSize: 16.sp,
                ),
              ),
            ],
            16.sbh,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: MyColors.btnColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: MyColors.btnBorderColor.withOpacity(0.5), width: 2),
              ),
              child: Text(
                releaseNotes,
                style: kSize14DarkW400Text.copyWith(
                  color: Colors.white,
                  fontSize: 14.sp,
                  height: 1.4,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            28.sbh,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Later',
                    textStyle: kSize14DarkW400Text.copyWith(
                      fontSize: 18.sp,
                      color: const Color(0xFF042165),
                    ),
                    height: 56.h,
                    width: double.infinity,
                    borderRadius: 20.r,
                    onPressed: () {
                      _upgrader.saveLastAlerted();
                      Navigator.of(ctx).pop();
                    },
                  ),
                ),
                16.sbw,
                Expanded(
                  child: CustomButton(
                    text: 'Update Now',
                    textStyle: kSize14DarkW400Text.copyWith(
                      fontSize: 18.sp,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1.w, 1.h),
                          blurRadius: 1.r,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    height: 56.h,
                    width: double.infinity,
                    borderRadius: 20.r,
                    onPressed: () {
                      _upgrader.sendUserToAppStore();
                      Navigator.of(ctx).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).then((_) {
      _bottomSheetShownThisSession = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
