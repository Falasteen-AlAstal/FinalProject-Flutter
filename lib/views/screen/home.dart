import 'package:flutter/material.dart';
import 'package:flutter_final_project/bottom_nav_bar.dart';
import 'package:flutter_final_project/data/data-categories.dart';
import 'package:flutter_final_project/widgets/widgetCategories.dart';
import 'package:provider/provider.dart';

import '../../controllers/meals_proovider.dart';
import '../../models/categories.dart';
import '../../models/fb_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title: Text('Home',
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
            child: Text("Hello, Everyone !"),
          ),
          const SizedBox(
            height: 6,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Let's order special food for you!!",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Categories",
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
            child: Consumer<MealsProvider>(
              builder: (context, mealsProvider, _) {
                if (mealsProvider.categories == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (mealsProvider.categories!.isEmpty) {
                  return Center(
                    child: Text('No categories available.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: mealsProvider.categories!.length,
                    itemBuilder: (context, index) {
                      return CategoriesTile(mealsProvider.categories![index]);
                    },
                  );
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
