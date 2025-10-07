import 'package:expense_trakcer/data/dummy_data.dart';
import 'package:expense_trakcer/models/meal.dart';
import 'package:expense_trakcer/providers/favorites_provider.dart';
import 'package:expense_trakcer/providers/meals_provider.dart';
import 'package:expense_trakcer/screens/categories.dart';
import 'package:expense_trakcer/screens/filters.dart';
import 'package:expense_trakcer/screens/meals.dart';
import 'package:expense_trakcer/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.veg: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<Filter, bool> _selectedFilter = kInitialFilters;

  void _showInfoMsg(String msg) {}

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
    final meals = ref.watch(mealsProvider);
    final availableMeals =
        meals.where((meal) {
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
    Widget activePage = CategoriesScreen(availableMeals: availableMeals);

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(meals: favoriteMeals);
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
