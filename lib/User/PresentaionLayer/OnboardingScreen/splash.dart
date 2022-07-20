import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osol/shared/constants.dart';

import 'onBoardingView.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => OnboardingScreen()));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.OnBoardingScreen,
      body: Center(
        child: Container(
          height: sizeFromHeight(4),
          child: Center(
            child: Image(
              image: AssetImage("assets/images/estatehomee.png"),
            ),
          ),
        ),
      ),
    );
  }
}
