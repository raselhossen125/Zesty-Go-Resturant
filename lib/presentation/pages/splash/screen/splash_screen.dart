import 'dart:async';
import 'package:flutter/material.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 Second por Login Screen-e niye jabe
    Timer(const Duration(seconds: 3), () {
      // Navigator use kore pushReplacement kora bhalo jate user back button chepe abar splash-e na ashte pare
      Navigator.pushReplacementNamed(context, RouteName.LOGIN_SCREEN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstColor.primaryColor,
      body: Stack(
        children: [
          // Top-right decoration (Image onujayi)
          Positioned(
            top: -50,
            right: -50,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.fastfood, size: 250, color: Colors.white),
            ),
          ),

          // Main Logo (Center)
          Center(
            child: Container(
              padding: const EdgeInsets.all(
                Dimensions.PADDING_SIZE_EXTRA_LARGE,
              ),
              child: Image.asset(
                'assets/images/logo_white.png',
                width: 160,
                color: Colors.white,
              ),
            ),
          ),

          // Bottom-left decoration (Image onujayi)
          Positioned(
            bottom: -60,
            left: -40,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.fastfood, size: 220, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
