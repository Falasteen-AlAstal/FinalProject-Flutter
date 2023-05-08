import 'package:flutter/material.dart';
import 'package:flutter_final_project/models/categories.dart';
import 'package:flutter_final_project/views/screen/meals.dart';

class CategoriesTile extends StatelessWidget {
  final Categories categories;
  const CategoriesTile(this.categories);

  @override
  Widget build(BuildContext context) {
    // String name = categories.name;
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: ListTile(
        title: Text(categories.name),
        leading: Image.asset(categories.image),
        trailing: Text(categories.quantity),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return MealsPage(name: categories.name);
          }));
        },
      ),
    );
  }
}
