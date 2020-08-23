import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/widgets/headerWidget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, strTitle : "Profile"),
      body: Background(child: Text("profile Page goes here")),
      
    );
  }
}