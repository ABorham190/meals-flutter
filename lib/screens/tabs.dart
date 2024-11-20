import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabsScreen();
  }
}

const kIntialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class _TabsScreen extends ConsumerState<TabsScreen> {
  Map<Filter, bool> _selectedFilters = kIntialFilter;

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   var isMealExist = _favoriteMeals.contains(meal);
  //   if (isMealExist) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       _showInfoMessage("Meal removed from favorites");
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage("Meal added to favorites");
  //     });
  //   }
  // }

  int _selectedIndex = 0;

  void selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'meals') {
    } else {
      final result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
            currentFilter: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kIntialFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activeScreen = CategoryScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePageTitle = 'Favorites';
      activeScreen = MealsScreen(
        meals: favoriteMeals,
      );
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
