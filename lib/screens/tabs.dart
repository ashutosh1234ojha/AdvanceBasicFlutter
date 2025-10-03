import 'package:expense_trakcer/data/dummy_data.dart';
import 'package:expense_trakcer/models/meal.dart';
import 'package:expense_trakcer/screens/categories.dart';
import 'package:expense_trakcer/screens/filters.dart';
import 'package:expense_trakcer/screens/meals.dart';
import 'package:expense_trakcer/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.veg: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> favoriteMeals = [];
  Map<Filter, bool> _selectedFilter = kInitialFilters;

  void _showInfoMsg(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = favoriteMeals.contains(meal);

    if (isExisting) {
      _showInfoMsg("Meal is no longer favorite");

      setState(() {
        favoriteMeals.remove(meal);
      });
    } else {
      _showInfoMsg("Meal is added as favorite");

      setState(() {
        favoriteMeals.add(meal);
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String id) async {
    Navigator.of(context).pop();

    if (id == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilter),
        ),
      );

      setState(() {
        _selectedFilter = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals =
        dummyMeals.where((meal) {
          if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (_selectedFilter[Filter.veg]! && !meal.isVegetarian) {
            return false;
          }
          if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();

    var activePageTitle = "Categories";
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = "Your Favroties";
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rate),
            label: "Favroties",
          ),
        ],
      ),
    );
  }
}
