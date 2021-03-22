import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vagan': false,
    'vegeterian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

  void _setFilters(Map<String, bool> _filterData) {
    setState(() {
      _filters = _filterData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vagan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegeterian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeal.any((meal) => meal.id == id);
  }

  void _toggelFav(String mealID) {
    final existingIndex = _favoriteMeal.indexWhere((meal) => meal.id == mealID);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealID));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.greenAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.grey[700],
              ),
              bodyText2: TextStyle(
                color: Colors.blueGrey[900],
              ),
              headline1: TextStyle(
                fontSize: 20,
                fontFamily: 'Raleway',
                color: Colors.grey[850],
                fontWeight: FontWeight.w600,
              ),
            ),
      ),
      //home: MyHomePage(),

      routes: {
        '/': (context) => TabsScreen(_favoriteMeal),
        CategoryMealsScreen.routName: (context) =>
            CategoryMealsScreen(_availableMeal),
        MealDetailScreen.routName: (context) =>
            MealDetailScreen(_toggelFav, _isMealFavorite),
        FilterScreen.routName: (context) => FilterScreen(_filters, _setFilters),
      },
    );
  }
}
