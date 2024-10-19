import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_app_project/consts/consts.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Image.asset(imgSplash, fit: BoxFit.cover),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(
                  // color: Colors.white.withOpacity(0.2),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.05),
                      Colors.white.withOpacity(0.6),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.34,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: textCol1.withOpacity(0.7),
                      width: 5,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "E-mail",
                        style: TextStyle(
                          color: textCol1,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          fillColor: Colors.white.withOpacity(0.8),
                          filled: true,
                          hintText: "abc@gmail.com",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: textCol1,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          fillColor: Colors.white.withOpacity(0.8),
                          filled: true,
                          hintText: "abc123",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 14),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed("/intro");
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(textCol1),
                          ),
                          child: Text(
                            _isLogin ? "Login" : "Sign In",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            _isLogin
                                ? "Aren't registered yet?"
                                : "Already Registered?",
                            style: TextStyle(
                              color: textCol1,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
