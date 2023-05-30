import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/data/data-meals.dart';
import 'package:provider/provider.dart';

import '../controllers/meals_proovider.dart';
import '../models/fb_helper.dart';
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
        title: Text(meals.name!),
        leading: CachedNetworkImage(
          imageUrl: meals.image!,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        subtitle: Text(meals.price!),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // DataMeals.cartItems.remove(meals);
            // FbHelper.fbHelper.deleteCartItem(meals);
            Provider.of<MealsProvider>(context, listen: false)
                .deleteCartItem(meals);
          },
        ),
      ),
    );
  }
}
