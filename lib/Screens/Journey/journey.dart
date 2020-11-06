import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/Screens/Journey/model/group.dart';
import 'package:Walnut/Screens/checkLogin.dart';
import 'package:Walnut/widgets/headerWidget.dart';
import 'package:Walnut/widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DisplayGrp.dart';
import 'creategrp.dart';
import 'grp_search/searchGroup.dart';

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

  displayGrp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Grp()));
  }

  alreadyjoinedGroup(){
    return Container(child: Text('shivaay'),);
  }
  diaplaySearchResult(){
    return FutureBuilder(
      future: futureSearchResults,
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<GroupResult> searchGroupsResult = [];
        dataSnapshot.data.documents.forEach((document) {
          Group eachGroup = Group.fromDocument(document);
          GroupResult groupResult = GroupResult(eachGroup);
          searchGroupsResult.add(groupResult);
        });

        return ListView(
          children: searchGroupsResult,
        );
      },
    );
  }

  midsec() {
    return Container(
        child: futureSearchResults == null
            ? alreadyjoinedGroup()
            : diaplaySearchResult());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchPageHeader(),
      body: Background(
        child: Column(
          children: [
            Expanded(child:  midsec(),),
           
            RoundedButton(
              text: "CREATE GROUP",
              color: Colors.blue[200],
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CreateGrp(currentOnlineUserId: currentUser.id);
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
