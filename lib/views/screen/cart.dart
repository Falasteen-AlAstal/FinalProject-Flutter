import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/meals_proovider.dart';
import '../../widgets/widgetCart.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<MealsProvider>(context, listen: false).getCartItems();
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
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            fontFamily: 'Varela',
            fontSize: 20.0,
            color: Color(0xFF545D68),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Your Cart",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<MealsProvider>(
                builder: (context, provider, _) {
                  if (provider.cartItems == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (provider.cartItems!.isEmpty) {
                    return SizedBox(); // عدم عرض أي عنصر
                  } else {
                    return ListView.builder(
                      itemCount: provider.cartItems!.length,
                      itemBuilder: (context, index) {
                        return cartTile(provider.cartItems![index]);
                      },
                    );
                  }
                },
              ), /*Consumer<MealsProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (provider.cartItems != null &&
                      provider.cartItems!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: provider.cartItems!.length,
                      itemBuilder: (context, index) {
                        return cartTile(provider.cartItems![index]);
                      },
                    );
                  } else {
                    return Center(
                      child: Text("Your cart is empty"),
                    );
                  }
                },
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}
