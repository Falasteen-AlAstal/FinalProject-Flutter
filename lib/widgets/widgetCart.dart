import 'package:flutter/material.dart';
import 'package:flutter_final_project/data/data-meals.dart';

import '../models/mod-meals.dart';

class cartTile extends StatelessWidget {
  final Meals meals;
  const cartTile(this.meals);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        title: Text(meals.name),
        leading: Image.asset(meals.image),
        subtitle: Text(meals.price),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            DataMeals.cartItems.remove(meals);
          },
        ),
      ),
    );
  }
}
