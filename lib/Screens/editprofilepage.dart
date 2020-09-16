// import 'dart:html';

// import 'dart:html';

import 'package:Walnut/Components/backgroung.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {

  // String currentUserId;

  // EditProfilePage(this.currentUserId);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(child: Text("Edit your Profile ")),
    );
  }
}
