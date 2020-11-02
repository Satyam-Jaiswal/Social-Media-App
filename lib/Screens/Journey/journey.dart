import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/Screens/checkLogin.dart';
import 'package:Walnut/widgets/headerWidget.dart';
import 'package:Walnut/widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DisplayGrp.dart';
import 'creategrp.dart';

class Journey extends StatefulWidget {
  @override
  _JourneyState createState() => _JourneyState();
}

class _JourneyState extends State<Journey> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> followingsList = [];
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;

  emptyTheTextFormField() {
    searchTextEditingController.clear();
  }

   void changestate() {
    setState(() {
      futureSearchResults = null;
      // displayGrouplist();
      emptyTheTextFormField();
    });
  }

  AppBar searchPageHeader() {
    return AppBar(
      // backgroundColor: Colors.black,
      // leading: Padding(
      //     padding: EdgeInsets.all(2),
      //     child: Image.asset('assets/icons/logo.png')),
      title: TextFormField(
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        controller: searchTextEditingController,
        decoration: InputDecoration(
          hintText: "Search here....",
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: true,
          prefixIcon: Icon(
            Icons.person_pin,
            color: Colors.white,
            size: 30.0,
          ),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: changestate),
        ),
        onFieldSubmitted: controlSearching,
      ),
    );
  }


controlSearching(String str) {
    Future<QuerySnapshot> allgrp = gropuReference
        .where("grpName", isGreaterThanOrEqualTo: str)
        .getDocuments();
    futureSearchResults = allgrp;
  }


  displayGrp(){
     Navigator.push(context, MaterialPageRoute(builder: (context) => Grp()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchPageHeader(),
      body: Background(
          child: Column(
            children: [
              Expanded(
                          child: Column(
        children: [
                GestureDetector(
                  
                  onTap: () => displayGrp(),
                  child: Container(
                    color: Colors.amber,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        Text(
                          'Group Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
        ],
      ),
              ),RoundedButton(
          text: "CREATE GROUP",
          color: Colors.blue[200],
          textColor: Colors.black,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CreateGrp(currentOnlineUserId:currentUser.id                   
                  );
                },
              ),
            );
          },
        ),
            ],
          ),
          ),
    );
  }
}
