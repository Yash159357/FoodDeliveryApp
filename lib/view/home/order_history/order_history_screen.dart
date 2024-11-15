import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app_project/consts/consts.dart';
import 'package:food_app_project/controller/order_history_controller.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool _isAnimated = false; // Animation state variable

  @override
  void initState() {
    super.initState();
    // Trigger the animation after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var orderHistoryController = Get.find<OrderHistoryController>();
    var orderHistory = orderHistoryController.orderHistory;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(top: _isAnimated ? 0 : screenHeight * 0.25), // Adjust padding based on animation state
        child: Column(
          children: [
            const SizedBox(height: 15),
            Expanded(
              child: orderHistory.isEmpty
                  ? Center(child: Text("No orders found.")) // Handle empty order history
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: orderHistory.length,
                      itemBuilder: (context, index) {
                        var order = orderHistory[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed("/restaurant", arguments: order.restaurant);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.5),
                                style: BorderStyle.solid,
                              ),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  blurStyle: BlurStyle.normal,
                                )
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 8),
                                  width: screenWidth * 0.4,
                                  height: screenHeight * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(15)),
                                    image: DecorationImage(
                                        image: AssetImage(order.image),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month_rounded,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${order.date.day} / ${order.date.month} / ${order.date.year}",
                                          style: const TextStyle(
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
                                          Icons.monetization_on_rounded,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "₹ ${order.price}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
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
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.monetization_on_sharp,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Affordability: ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Medium",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    RatingBarIndicator(
                                      rating: 4.5,
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
            ),
          ],
        ),
      ),
    );
  }
}
