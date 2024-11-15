import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app_project/firebase_options.dart';
import 'package:food_app_project/services/firebase_setup.dart';
import 'package:food_app_project/view/auth/auth.dart';
import 'package:food_app_project/view/home/home_screen.dart';
import 'package:food_app_project/view/home/order_failure_screen.dart';
import 'package:food_app_project/view/home/order_success_screen.dart';
import 'package:food_app_project/view/home/restaurant_screen.dart';
import 'package:food_app_project/view/intro_screen/intro_screen.dart';
import 'package:food_app_project/view/splash_screen.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(
    name: "/splash",
    page: () => SplashScreen(
      msg: Get.arguments ?? 1,
    ),
  ),
  GetPage(name: "/intro", page: () => const IntroScreen()),
  GetPage(name: "/auth", page: () => const AuthScreen()),
  GetPage(name: "/home", page: () => const HomeScreen()),
  GetPage(
    name: "/restaurant",
    page: () => RestaurantScreen(
      restaurant: Get.arguments,
    ),
  ),
  GetPage(name: "/success", page: () => const OrderSuccessScreen()),
  GetPage(name: "/failure", page: () => const OrderFailureScreen()),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: "/splash",
      getPages: routes,
      home: StreamBuilder(
        stream: firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen(msg: 3);
          }
          if (snapshot.hasData) {
            return const SplashScreen(msg: 2);
          } else {
            return const SplashScreen(msg: 1);
          }
        },
      ),
    );
  }
}
