import 'package:flutter/material.dart';
import 'package:flutter_final_project/views/screen/home.dart';
import 'package:flutter_final_project/views/screen/home_page.dart';
import 'package:flutter_final_project/views/screen/registration.dart';
import 'package:provider/provider.dart';

import '../../controllers/meals_proovider.dart';
import '../../models/fb_helper.dart';

class signInPage extends StatelessWidget {
  const signInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.fastfood,
              size: 100,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Hello Again",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Welcome back, Login to your account!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),

            //email text field

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller:
                          Provider.of<MealsProvider>(context, listen: false)
                              .emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Email")),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //password text field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller:
                          Provider.of<MealsProvider>(context, listen: false)
                              .passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "password")),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            //sign in button

            Center(
                child: ElevatedButton(
              onPressed: () {
                FbHelper.fbHelper.signInWithEmailAndPassword(context);
              },
              child: Text(
                "sign in",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )),

            SizedBox(
              height: 25,
            ),

            // Don't have your account? Sign up

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have your account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return RegistrationPage();
                      }));
                    },
                    child: Text(
                      " Sign up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
