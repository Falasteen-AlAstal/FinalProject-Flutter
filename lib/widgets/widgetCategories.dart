import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/models/categories.dart';
import 'package:flutter_final_project/models/mod-meals.dart';
import 'package:flutter_final_project/views/screen/meals.dart';
import 'package:provider/provider.dart';

import '../controllers/meals_proovider.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/models/categories.dart';
import 'package:flutter_final_project/models/mod-meals.dart';
import 'package:flutter_final_project/views/screen/meals.dart';
import 'package:provider/provider.dart';

class CategoriesTile extends StatelessWidget {
  final Categories categories;
  const CategoriesTile(this.categories);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: ListTile(
        title: Text(categories.name!),
        leading: CachedNetworkImage(
          imageUrl: categories.image!,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        trailing: Text(categories.quantity!),
        onTap: () {
          Provider.of<MealsProvider>(context, listen: false)
              .getMealsByCategory(categories.id!);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return Consumer<MealsProvider>(
                builder: (context, mealsProvider, _) {
                  if (mealsProvider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (mealsProvider.meals == null) {
                    return Center(
                      child: Text('Failed to load meals.'),
                    );
                  } else {
                    return MealsPage(
                      name: categories.name!,
                      meals: mealsProvider.meals!,
                    );
                  }
                },
              );
            }),
          );
        },
      ),
    );
  }
}
