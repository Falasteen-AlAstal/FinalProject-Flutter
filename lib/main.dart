import 'package:flutter/material.dart';
import 'package:flutter_final_project/views/screen/account.dart';
import 'package:flutter_final_project/views/screen/details.dart';
import 'package:flutter_final_project/views/screen/profile.dart';
import 'package:flutter_final_project/views/screen/registration.dart';
import 'package:flutter_final_project/views/screen/signIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationPage(),
    );
  }
}
