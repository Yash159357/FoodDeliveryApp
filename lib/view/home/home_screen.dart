import 'package:flutter/material.dart';
import 'package:food_app_project/consts/consts.dart';
import 'package:food_app_project/controller/order_history_controller.dart';
import 'package:food_app_project/controller/profile_controller.dart';
import 'package:food_app_project/services/firebase_setup.dart';
import 'package:food_app_project/view/home/home_screen_page.dart';
import 'package:food_app_project/view/home/order_history/order_history_screen.dart';
import 'package:food_app_project/view/home/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track the selected tab index
  bool _themeIsBright = true;
  // List of screens for each tab
  final List<Widget> _screens = const [
    HomeScreenPage(), // Home screen content
    OrderHistoryScreen(), // Placeholder for Order History
    ProfileScreen(), // Placeholder for Profile
  ];
  final List<String> _titles = const [
    "QuickEats",
    "Order History",
    "Profile",
  ];
  
  @override
  void initState() {
    super.initState();
    // Correctly put the OrderHistoryController here
    Get.put(OrderHistoryController());
    Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    final List<IconButton> icons = [
    IconButton(
      onPressed: () {
        firebaseAuth.signOut();
        Get.offAllNamed('/splash');
      },
      icon: const Icon(
        Icons.logout_rounded,
        color: Colors.white,
        size: 30,
        weight: 50,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.more_vert_rounded,
        color: Colors.white,
        size: 30,
        weight: 50,
      ),
    ),
    IconButton(
      onPressed: () {
        setState(() {
          _themeIsBright = !_themeIsBright;
        });
      },
      icon: Icon(
        _themeIsBright? Icons.wb_sunny_rounded: Icons.nightlight_round,
        color: Colors.white,
        size: 30,
        weight: 50,
      ),
    ),
  ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: _selectedIndex == 1 ? 5 : 0,
        shadowColor: Colors.grey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2),
          ),
        ),
        actions: [
          Row(children: [icons[_selectedIndex], const SizedBox(width: 4)]),
        ],
        toolbarHeight: 70,
        backgroundColor: appbarCol1,
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Order History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: appbarCol1,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}
