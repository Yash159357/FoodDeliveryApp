import 'package:food_app_project/model/restaurant.dart';
import 'package:intl/intl.dart'; // Import the intl package

class OrderHistoryItem {
  OrderHistoryItem({
    required this.id,
    required this.date,
    required this.name,
    required this.image,
    required this.price,
    required this.ingredients,
    required this.discription,
    required this.restaurant,
  });

  final String id;
  final String name;
  final DateTime date;
  final String image;
  final double price;
  final String ingredients;
  final String discription;
  final Restaurant restaurant;

  // Method to format the date for display
  String getFormattedDate() {
    return DateFormat('yyyy-MM-dd').format(date); // Change the format as needed
  }
}
