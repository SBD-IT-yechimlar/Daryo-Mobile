import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SplashDemo extends StatefulWidget {
  const SplashDemo({super.key});

  @override
  State<SplashDemo> createState() => _SplashDemoState();
}

class _SplashDemoState extends State<SplashDemo> {
  late Timer _timer;
  int _timerTime = 2;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFF0089DA),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (_timerTime > 0) {
        setState(() {
          _timerTime--;
        });
      } else {
        _stopTimer();
        _navigateNext();
      }
    });
  }

  void _stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  void _navigateNext() {
    // Burada language repository bilan tekshiring
    // final isLanguageSelected = languageRepository.isLanguageSelected();

    // Vaqtincha test uchun:
    final isLanguageSelected = false;

    if (isLanguageSelected) {
      context.replaceRoute(const DashboardRoute());
    } else {
      context.replaceRoute(const SetLanguageRoute());
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0089DA),
      body: Stack(
        children: [
          Assets.images.pngImages.welcoemSplash.image(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.iconD.svg(),
                SizedBox(height: 15.h),
                Assets.images.pngImages.daryo.image(height: 24.h),
                SizedBox(height: 150.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}