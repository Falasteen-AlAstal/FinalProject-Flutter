import 'package:flutter/material.dart';
import 'package:flutter_final_project/data/data-meals.dart';
import 'package:flutter_final_project/widgets/widgetMeals.dart';
import 'package:provider/provider.dart';

import '../../controllers/meals_proovider.dart';
import '../../models/categories.dart';
import '../../models/mod-meals.dart';

class MealsPage extends StatelessWidget {
  final String name;
  final List<Meals> meals;
  const MealsPage({Key? key, required this.name, required this.meals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Categories categories = Categories(name: name, image: '', quantity: '');
    // String message = "how would you like your ${name}";
    // final foods = getFoodsByCategory(categories);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Meal list',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Choose the meal you want",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    return mealsTile(meals[index]);
                  }))
        ],
      )),
    );
  }
}
