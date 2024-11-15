import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_project/consts/consts.dart';
import 'package:food_app_project/services/firebase_setup.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pswdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    void signUp() async {
      if (((_usernameController.text.trim().isEmpty ||
                  _usernameController.text.trim().length < 4) &&
              !_isLogin) ||
          (!_emailController.text.contains("@gmail.com")) ||
          (_pswdController.text.trim().length < 6)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Invalid Input. Please check your details.",
              style: TextStyle(
                color: textCol1,
                fontSize: 16,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(255, 77, 77, 77),
            duration: const Duration(seconds: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(8),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      } else {
        try {
          if (_isLogin) {
            final userCredential =
                await firebaseAuth.signInWithEmailAndPassword(
              email: _emailController.text,
              password: _pswdController.text,
            );
          } else {
            final userCredential =
                await firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _pswdController.text,
            );
            await firebaseFirestore
                .collection('users')
                .doc(userCredential.user!.uid)
                .set({
              'username': _usernameController.text,
              'email': _emailController.text,
              'pswd': _pswdController.text,
            });
          }
          Get.offAllNamed("/intro");
        } on FirebaseAuthException catch (e) {
          print(e.message);
        }
      }
    }

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
                  height: screenHeight * (_isLogin ? 0.34 : 0.44),
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
                      if (!_isLogin) ...[
                        Text(
                          "Username",
                          style: TextStyle(
                            color: textCol1,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.white.withOpacity(0.8),
                            filled: true,
                            hintText: "abc",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
                        controller: _emailController,
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
                        controller: _pswdController,
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
                            signUp();
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
