import 'package:food_app_project/model/dish_model.dart';

class Restaurant {
  Restaurant({
    required this.name,
    required this.image,
    required this.deliveryTime,
    required this.description,
    required this.dishes,
    required this.rating,
  });

  final String name;
  final String image;
  final double deliveryTime;
  final String description;
  final List<Dish> dishes;
  final double rating;
}
