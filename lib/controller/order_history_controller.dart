import 'package:food_app_project/data/dishes_data.dart';
import 'package:food_app_project/data/restaurant_data.dart';
import 'package:food_app_project/model/order_history_model.dart';
import 'package:food_app_project/model/restaurant.dart';
import 'package:food_app_project/services/firebase_setup.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, Restaurant> idRestMap = {
  'D01': chiRes,
  'D02': chiRes,
  'D03': chiRes,
  'D04': chiRes,
  'D05': frnchRes,
  'D06': frnchRes,
  'D07': frnchRes,
  'D08': frnchRes,
  'D09': indRes,
  'D10': indRes,
  'D11': indRes,
  'D12': indRes,
  'D13': itaRes,
  'D14': itaRes,
  'D15': itaRes,
  'D16': itaRes,
  'D17': jpRes,
  'D18': jpRes,
  'D19': jpRes,
  'D20': jpRes,
  'D21': mexRes,
  'D22': mexRes,
  'D23': mexRes,
  'D24': mexRes,
};

class OrderHistoryController extends GetxController {
  var orderHistory = <OrderHistoryItem>[].obs;
  // var filteredOrderHistory = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  void fetchOrderHistory() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        final ordersSnapshot = await firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .collection('orders')
            .get();

        orderHistory.value = ordersSnapshot.docs.map((doc) {
          var dish = idDishmap[doc['order_id']]!;
          DateTime orderDate = (doc['order_time'] as Timestamp).toDate();
          return OrderHistoryItem(
            id: dish.id,
            date: orderDate,
            name: dish.name,
            image: dish.image,
            price: dish.price,
            ingredients: dish.ingredients,
            discription: dish.discription,
            restaurant: idRestMap[dish.id]!,
          );
        }).toList();
      }
    } catch (e) {
      print("Error fetching order history: $e");
    }
  }

  List<OrderHistoryItem> filterOrderHistory(
      {DateTime? date, Restaurant? restaurant}) {
    var filteredOrderHistory = orderHistory.where((order) {
      final bool matchesDate = date == order.date || date == '';
      final matchesRestaurant = restaurant == order.restaurant || restaurant == '';

      return matchesDate && matchesRestaurant;
    }).toList();
    return filteredOrderHistory;
  }
}
