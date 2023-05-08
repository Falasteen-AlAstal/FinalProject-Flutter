import 'package:flutter/material.dart';

import 'account.dart';

class ProfilePage extends StatelessWidget {
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
        title: Text('Profile',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('images/mahrez.jpg'),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListTile(
              title: Text("My Account"),
              leading: Icon(Icons.person),
              trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return myAccountPage();
                  }));
                },
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListTile(
              title: Text("Log out"),
              leading: Icon(Icons.logout),
              trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () {},
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
