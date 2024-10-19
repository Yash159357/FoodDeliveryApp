import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app_project/consts/consts.dart';
import 'package:food_app_project/data/restaurant_data.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var resList = [chiRes, frnchRes, indRes, itaRes, jpRes, mexRes];
    var viewList = ["23K", "20K", "18K", "18K", "16K", "11K"];
    var ratingList = [4.1, 3.9, 4.7, 4.0, 4.2, 4.5];
    var affordabilityList = ["medium", "low", "high", "low", "high", "medium"];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QuickEats",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.offAllNamed('/splash');
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
              size: 30,
              weight: 50,
            ),
          ),
        ],
        toolbarHeight: 70,
        backgroundColor: appbarCol1,
      ),
      body: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(top: _isAnimated ? 0 : screenHeight * 0.25),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                height: screenHeight * 0.2,
                width: screenWidth * 0.9,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          image: DecorationImage(
                            image: AssetImage(imgHome1),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: screenHeight * 0.2,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                            // color: Colors.white.withOpacity(0.2),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.6),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.12,
                        left: screenWidth * 0.40,
                        child: Text(
                          "Hi, Yash",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: textCol3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(
                indent: 15,
                endIndent: 15,
              ),
              const SizedBox(height: 5),
              // *******************************************************************
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: const Row(
                  children: [
                    Text(
                      "Most Searched Restaurants",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 28,
                      color: Colors.black,
                      weight: 100,
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.26,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed("/restaurant", arguments: resList[index]);
                      },
                      child: Container(
                        height: screenHeight * 0.26,
                        width: screenWidth * 0.4,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Material(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 5),
                              CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    AssetImage(resList[index].image),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                resList[index].name,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    viewList[index],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // ******************************************************************
              const SizedBox(height: 5),
              const Divider(
                indent: 15,
                endIndent: 15,
              ),
              const SizedBox(
                height: 5,
              ),
              // ******************************************************************
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: const Row(
                  children: [
                    Text(
                      "Restaurants near You",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 28,
                      color: Colors.black,
                      weight: 100,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed("/restaurant", arguments: resList[index]);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.2,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                    image: AssetImage(resList[index].image),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resList[index].name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    viewList[index],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "Views",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.delivery_dining,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    resList[index].deliveryTime.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "minutes",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.menu_book_outlined,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Menu: 4 dishes",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.monetization_on_sharp,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "Affordability: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    affordabilityList[index],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              RatingBarIndicator(
                                rating: ratingList[index],
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 24.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
