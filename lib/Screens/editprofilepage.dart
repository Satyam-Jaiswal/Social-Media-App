// import 'dart:html';

// import 'dart:html';

import 'package:Walnut/Components/backgroung.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String currentOnlineUserId;

  EditProfilePage({this.currentOnlineUserId});

  // String currentUserId;

  // EditProfilePage(this.currentUserId);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Background(child: Text("Edit your Profile ")),
    );
  }
}
