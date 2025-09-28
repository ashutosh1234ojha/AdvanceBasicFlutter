import 'package:expense_trakcer/screens/categories.dart';
import 'package:expense_trakcer/screens/meals.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = "Categories";
    Widget activePage = CategoriesScreen();

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(meals: []);
      activePageTitle = "Your Favroties";
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
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
