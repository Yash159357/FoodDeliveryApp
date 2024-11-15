import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_app_project/consts/consts.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.msg});
  final int msg;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (widget.msg == 1) {
        Get.offNamed("/auth");
      }
      if (widget.msg == 2) {
        Get.offNamed("/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Image.asset(
              imgSplash,
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Welcome to,",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "QuickEats",
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  "the world's fastest food delivery app.",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 220),
                CircularProgressIndicator(color: Colors.red.shade500),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
