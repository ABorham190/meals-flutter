import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  final List<Meal> _favoriteMeals = [];
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    var isMealExist = _favoriteMeals.contains(meal);
    if (isMealExist) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage("Meal removed from favorites");
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage("Meal added to favorites");
      });
    }
  }

  int _selectedIndex = 0;

  void selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String identifier) {
    if (identifier == 'meals') {
      Navigator.pop(context);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoryScreen(
      toggleFavoriteMeal: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedIndex == 1) {
      activePageTitle = 'Favorites';
      activeScreen = MealsScreen(
          meals: _favoriteMeals,
          toggleFavoriteStatus: _toggleMealFavoriteStatus);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favorites'),
        ],
        onTap: selectPage,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
