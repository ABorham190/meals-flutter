import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.toggleFavoriteMeal,
    required this.availableMeals,
  });

  final void Function(Meal meal) toggleFavoriteMeal;
  final List<Meal> availableMeals;
  void _selectCategory(BuildContext context, Category category) {
    var filterdMealsList = availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          text: category.title,
          meals: filterdMealsList,
          toggleFavoriteStatus: toggleFavoriteMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final item in availableCategories)
          CategoryGridItem(
            category: item,
            onSelectCategory: () {
              _selectCategory(context, item);
            },
          )
      ],
    );
  }
}
