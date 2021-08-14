import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;
  FavoritesScreen(this.favouriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text("You have no favorites add some!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          final item = favouriteMeals[index];
          return MealItem(
              id: item.id,
              title: item.title,
              imageUrl: item.imageUrl,
              affordability: item.affordability,
              duration: item.duration,
              complexity: item.complexity);
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
