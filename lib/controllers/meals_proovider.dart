import 'package:flutter/material.dart';
import 'package:flutter_final_project/models/mod-meals.dart';
import 'package:flutter_final_project/models/categories.dart';

import '../models/fb_helper.dart';

class MealsProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  // TextEditingController  Profile
  TextEditingController nameProfileController = TextEditingController();
  TextEditingController emailProfileController = TextEditingController();
  TextEditingController passwordProfileController = TextEditingController();
  TextEditingController addressProfileController = TextEditingController();
  TextEditingController phoneProfileController = TextEditingController();
  TextEditingController birthDateProfileDateController =
      TextEditingController();
  TextEditingController countryProfileController = TextEditingController();

  List<Meals>? meals;
  List<Categories>? categories;
  List<Meals>? cartItems = null;
  bool isLoading = false;
  bool isLoggedIn = false;
  bool isDataLoaded = false;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? birthDate;
  String? country;
  MealsProvider() {
    getCategories();
    getUserData();
  }
  // Instance of FbHelper
  FbHelper fbHelper = FbHelper.fbHelper;

  // Function to get categories from FbHelper
  void getCategories() async {
    categories = await fbHelper.getCategories();
    notifyListeners();
  }

  Future<void> getMealsByCategory(String categoryId) async {
    isLoading = true;
    notifyListeners();

    try {
      meals = await FbHelper.fbHelper.getMealsByCategory(categoryId);
    } catch (error) {
      print(error);
    }

    isLoading = false;
    notifyListeners();
  }

  // Function to add meal to cart
  void addToCart(Meals meal) async {
    await fbHelper.addToCart(meal);
    notifyListeners();
  }

  // Function to get cart items
  void getCartItems() async {
    try {
      cartItems = await fbHelper.getCartItems();
    } catch (error) {
      print(error);
    }
    if (cartItems == null) {
      cartItems = [];
    }
    notifyListeners();
  }

  // Function to delete item
  void deleteCartItem(Meals meal) async {
    await fbHelper.deleteCartItem(meal);
    cartItems!.remove(meal);
    notifyListeners();
  }

  // Function to create a new account
  /* void createNewAccount(BuildContext context) async {
    await fbHelper.createNewAccount(context);
  }*/

  // Function to add user
  void addUserToDB(String id, String name, String email, String phone,
      String password, String address) async {
    await fbHelper.addUserToDB(id, name, email, phone, password, address);
  }

  // Function to sign in
  /*void signInWithEmailAndPassword(BuildContext context) async {
    await fbHelper.signInWithEmailAndPassword(context);
  }*/

  void signOut(BuildContext context) {
    FbHelper.fbHelper.signOut(context);
    isLoggedIn = false;
  }

  void isUserLoggedIn() {
    isLoggedIn = FbHelper.fbHelper.isUserLoggedIn();
  }

  void getUserData() async {
    Map<String, dynamic> userData = await FbHelper.fbHelper.fetchUserData();

    name = userData['name'];
    email = userData['email'];
    address = userData['address'];
    phone = userData['phone'];
    birthDate = userData['birth_date'];
    country = userData['country'];

    nameProfileController.text = name ?? '';
    emailProfileController.text = email ?? '';
    addressProfileController.text = address ?? '';
    phoneProfileController.text = phone ?? '';
    birthDateProfileDateController.text = birthDate ?? '';
    countryProfileController.text = country ?? '';
    notifyListeners();
  }

  Future<void> updateUserData(String name, String email, String address,
      String phone, String birthDate, String country) async {
    await fbHelper.updateUserData(
        name, email, address, phone, birthDate, country);

    this.name = name;
    this.email = email;
    this.address = address;
    this.phone = phone;
    this.birthDate = birthDate;
    this.country = country;

    notifyListeners();
  }
}
