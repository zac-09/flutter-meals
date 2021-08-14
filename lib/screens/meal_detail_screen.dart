import 'package:flutter/material.dart';
import 'package:flutter_meals/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static String routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavorite, this.isFavorite);
  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ));
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        height: 200,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('awesome meal'),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl as String,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "ingredients"),
            buildContainer(
              ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Card(
                        color: Theme.of(context).accentColor,
                        child: Text(selectedMeal.ingredients?[index] as String),
                      ),
                    );
                  },
                  itemCount: selectedMeal.ingredients?.length),
            ),
            buildSectionTitle(context, "steps"),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${index + 1}'),
                    ),
                    title: Text(selectedMeal.steps?[index] as String),
                  ),
                  Divider()
                ],
              ),
              itemCount: selectedMeal.steps?.length,
            ))
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
        onPressed: () {
          toggleFavorite(mealId);
        },
      ),
    );
  }
}
