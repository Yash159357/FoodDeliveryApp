import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app_project/model/restaurant.dart';
import 'package:food_app_project/services/firebase_setup.dart';
import 'package:get/get.dart';
import 'dart:math';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, required this.restaurant});
  final Restaurant restaurant;
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final PageController _pageController = PageController();
  final Random _random = Random();

  double _generateRandomRating() {
    return 3.5 + _random.nextDouble() * 1.5;
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  var _selectedDish = 4;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: screenWidth * 0.95,
        height: screenHeight * 0.7,
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            // First page: Menu content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text(
                        "Menu",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black),
                  Expanded(
                    child: ListView.separated(
                      itemCount: widget.restaurant.dishes.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final dish = widget.restaurant.dishes[index];
                        final rating = _generateRandomRating();

                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedDish = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: screenHeight * 0.2,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _selectedDish == index
                                  ? Colors.yellow
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: screenWidth * 0.3,
                                  height: screenHeight * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(dish.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dish.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          "Description:",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          dish.discription,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          "Ingredients:",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          dish.ingredients,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Text(
                                              "Rating:",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            RatingBarIndicator(
                                              rating: rating,
                                              itemBuilder: (context, index) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 16.0,
                                              direction: Axis.horizontal,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Price: ₹${dish.price.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _selectedDish == 4 ? () {} : _goToNextPage,
                      icon:
                          const Icon(Icons.shopping_cart, color: Colors.white),
                      label: const Text(
                        "Order Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _selectedDish == 4 ? Colors.grey : Colors.yellow,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Second page: Order page
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text(
                        "Ordering",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.black),
                  const SizedBox(height: 5),
                  // Order details based on _selectedDish
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const TextField(
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const TextField(
                            decoration: InputDecoration(
                              labelText: "Address",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const TextField(
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 10),
                          const TextField(
                            decoration: InputDecoration(
                              labelText: "Card Number",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: "Expiry Date",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: "CVV",
                                    border: OutlineInputBorder(),
                                  ),
                                  obscureText: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (_selectedDish != 4) ...[
                            const Text(
                              "Order Details",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("Restaurant: ${widget.restaurant.name}"),
                            Text(
                                "Dish: ${widget.restaurant.dishes[_selectedDish].name}"),
                            Text(
                                "Price: ₹${widget.restaurant.dishes[_selectedDish].price.toStringAsFixed(2)}"),
                            const SizedBox(height: 20),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.black),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedDish = 4;
                            });
                            _goToPreviousPage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text(
                            "Previous",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final user = firebaseAuth.currentUser;
                              await firebaseFirestore
                                  .collection('users')
                                  .doc(user!.uid)
                                  .collection('orders')
                                  .add({
                                    "order_id" : widget.restaurant.dishes[_selectedDish].id,
                                    "order_time" : DateTime.now(),
                                  });
                              Get.offAllNamed("/success");
                            } catch (e) {
                              print("Error : $e");
                              Get.offAllNamed("/failure");
                            }
                            
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text(
                            "Buy",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
