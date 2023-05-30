import 'package:flutter/material.dart';
import 'package:flutter_final_project/models/fb_helper.dart';
import 'package:flutter_final_project/views/screen/account.dart';
import 'package:flutter_final_project/views/screen/details.dart';
import 'package:flutter_final_project/views/screen/home_page.dart';
import 'package:flutter_final_project/views/screen/profile.dart';
import 'package:flutter_final_project/views/screen/registration.dart';
import 'package:flutter_final_project/views/screen/signIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'controllers/meals_proovider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MealsProvider mealsProvider = MealsProvider();
  mealsProvider.isUserLoggedIn();

  runApp(ChangeNotifierProvider<MealsProvider>(
    create: (context) {
      return MealsProvider();
    },
    child: MaterialApp(
      home: mealsProvider.isLoggedIn ? HomePages() : signInPage(),
    ),
  ));
}
