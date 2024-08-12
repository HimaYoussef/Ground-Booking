import 'package:flutter/material.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/features/on_boarding/On_Boarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        pushToWithReplacement(context, const OnBoardingView());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/Logo.png',
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
