import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String categoryId;
  // final String categoryTitle;
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  // CategoryMealsScreen(this.categoryId, this.categoryTitle);
  static const routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  var init_data = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (init_data == false) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs["title"] as String;
      final categoryId = routeArgs["id"];
      displayedMeals = widget.availableMeals.where((meals) {
        return meals.categories?.contains(categoryId) as bool;
      }).toList();
      init_data = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals?.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle as String),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final item = displayedMeals![index];
          return MealItem(
              id: item.id,
              title: item.title,
              imageUrl: item.imageUrl,
              affordability: item.affordability,
              duration: item.duration,
              complexity: item.complexity);
        },
        itemCount: displayedMeals?.length,
      ),
    );
  }
}
