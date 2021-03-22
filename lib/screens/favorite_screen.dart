import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favMeal;
  FavoritesScreen(this._favMeal);
  @override
  Widget build(BuildContext context) {
    if (_favMeal.isEmpty) {
      return Center(
        child: Text('You have no favorites yet'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _favMeal[index].id,
            imageUrl: _favMeal[index].imageUrl,
            affordability: _favMeal[index].affordability,
            complexity: _favMeal[index].complexity,
            duration: _favMeal[index].duration,
            title: _favMeal[index].title,
          );
          // _favMeal[index].title
        },
        itemCount: _favMeal.length,
      );
    }
  }
}
