import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/controllers/meals_proovider.dart';
import 'package:flutter_final_project/models/categories.dart';
import 'package:flutter_final_project/models/mod-meals.dart';
import 'package:flutter_final_project/views/screen/home.dart';
import 'package:flutter_final_project/views/screen/home_page.dart';
import 'package:flutter_final_project/views/screen/signIn.dart';
import 'package:provider/provider.dart';

class FbHelper {
  FbHelper._();
  static FbHelper fbHelper = FbHelper._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// fun  createNewAccount

  void createNewAccount(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: Provider.of<MealsProvider>(context, listen: false)
            .emailController
            .text,
        password: Provider.of<MealsProvider>(context, listen: false)
            .passwordController
            .text,
      );

      User? user = userCredential.user;
      if (user != null) {
        await addUserToDB(
          user.uid,
          Provider.of<MealsProvider>(context, listen: false)
              .nameController
              .text,
          Provider.of<MealsProvider>(context, listen: false)
              .emailController
              .text,
          Provider.of<MealsProvider>(context, listen: false)
              .phoneController
              .text,
          Provider.of<MealsProvider>(context, listen: false)
              .passwordController
              .text,
          Provider.of<MealsProvider>(context, listen: false)
              .addressController
              .text,
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => signInPage()),
        );
      }
    } catch (e) {
      print('Error creating account: $e');
      // Handle error
    }
  }

// fun addUserToDB
  Future<void> addUserToDB(String id, String name, String email, String phone,
      String password, String address) async {
    try {
      await _firestore.collection('users').add({
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'address': address,
        'birth_date': "",
        'country': ""
      });

      print('User added to Firestore');
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }

  // fun signIn

  void signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: Provider.of<MealsProvider>(context, listen: false)
            .emailController
            .text,
        password: Provider.of<MealsProvider>(context, listen: false)
            .passwordController
            .text,
      );

      User? user = userCredential.user;
      if (user != null) {
        final snackBar = SnackBar(
          content: Text('Logged in successfully'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePages()),
        );
      }
    } catch (e) {
      print('Error signing in: $e');
    }
  }

// fun  getCategories

  Future<List<Categories>> getCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('categories').get();
      List<Categories> categoriesList = [];
      snapshot.docs.forEach((doc) {
        Map<dynamic, dynamic> data = doc.data() as Map<dynamic, dynamic>;
        Categories category = Categories.fromMap(data);
        categoriesList.add(category);
      });
      return categoriesList;
    } catch (e) {
      print('Error getting categories: $e');
      return [];
    }
  }

  Future<List<Meals>> getMealsByCategory(String categoryId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('meals')
          .where('categories_id', isEqualTo: categoryId)
          .get();
      List<Meals> mealsList = [];
      snapshot.docs.forEach((doc) {
        Map<dynamic, dynamic> data = doc.data() as Map<dynamic, dynamic>;
        // doc.get('name');
        Meals meals = Meals.fromMap(data);
        mealsList.add(meals);
      });
      return mealsList;
    } catch (e) {
      print('Error getting meals: $e');
      return [];
    }
  }

  //add meal to cart

  Future<void> addToCart(Meals meal) async {
    try {
      final collectionRef = _firestore.collection('cart');
      await collectionRef.add({
        'name': meal.name,
        'image': meal.image,
        'price': meal.price,
      });
    } catch (e) {
      print('Error adding meal to cart: $e');
    }
  }

// get meals

  Future<List<Meals>> getCartItems() async {
    try {
      final collectionRef = _firestore.collection('cart');
      final querySnapshot = await collectionRef.get();

      List<Meals> cartItems = [];
      querySnapshot.docs.forEach((doc) {
        Meals meal = Meals(
          name: doc.data()['name'],
          image: doc.data()['image'],
          price: doc.data()['price'],
        );
        cartItems.add(meal);
      });

      return cartItems;
    } catch (e) {
      print('Error getting cart items: $e');
      return [];
    }
  }

  // Delete item from cart
  Future<void> deleteCartItem(Meals meal) async {
    try {
      final collectionRef = _firestore.collection('cart');
      final querySnapshot = await collectionRef
          .where('name', isEqualTo: meal.name)
          .where('image', isEqualTo: meal.image)
          .where('price', isEqualTo: meal.price)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        await collectionRef.doc(docId).delete();
        print('Item deleted from cart');
      }
    } catch (e) {
      print('Error deleting item from cart: $e');
    }
  }

// signOut
  void signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => signInPage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

//isUserLoggedIn()
  bool isUserLoggedIn() {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    User? currentUser = _auth.currentUser;

    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('id', isEqualTo: currentUser!.uid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs[0].data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  Future<void> updateUserData(String name, String email, String address,
      String phone, String birthDate, String country) async {
    User? currentUser = _auth.currentUser;

    Map<String, dynamic> updatedData = {
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'birth_date': birthDate,
      'country': country,
    };

    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('id', isEqualTo: currentUser!.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs[0].id;
      await _firestore.collection('users').doc(docId).update(updatedData);
    } else {
      print('The document does not exist');
    }
  }
}
