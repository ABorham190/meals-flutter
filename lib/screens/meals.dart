import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.text,
    required this.meals,
  });

  final String? text;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) =>
          MealItem(meal: meals[index], onSelectMeal: selectMeal),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            "Uh Oh ..... No Existing meals",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Try selecting other category",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ]),
      );
    }
    if (text == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(text!),
      ),
      body: content,
    );
  }
}
