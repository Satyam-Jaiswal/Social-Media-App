import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/models/postWidget.dart';
import 'package:Walnut/models/user.dart';
import 'package:Walnut/widgets/rounded_button.dart';
import 'package:Walnut/widgets/searchuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'checkLogin.dart';
import 'createPost.dart';

class Timeline extends StatefulWidget {
  final User gCurrentUser;
  Timeline({this.gCurrentUser});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<PostWidget> posts;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> followingsList = [];

  retriveTimeLine() async {
    QuerySnapshot querySnapshot = await timelineReference
        .document(widget.gCurrentUser.id)
        .collection("timelinePosts")
        .orderBy("timestamp", descending: true)
        .getDocuments();

    List<PostWidget> allPosts = querySnapshot.documents
        .map((document) => PostWidget.fromDocument(document))
        .toList();

    setState(() {
      this.posts = allPosts;
    });
  }

  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;

  controlSearching(String str) {
    Future<QuerySnapshot> allUsers = usersReference
        .where("profileName", isGreaterThanOrEqualTo: str)
        .getDocuments();
    futureSearchResults = allUsers;
  }

  emptyTheTextFormField() {
    searchTextEditingController.clear();
  }

  AppBar searchPageHeader() {
    return AppBar(
      backgroundColor: Colors.black,
      leading: Padding(
          padding: EdgeInsets.all(2),
          child: Image.asset('assets/icons/logo.png')),
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

  displaytimeline() {
    // retriveTimeLine();
    if (posts == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView(children: posts);
    }
  }

  contributertimeline() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            // color: Colors.green,
            child: displaytimeline(),
          ),
        ),
        RoundedButton(
          text: "CREATE POST",
          color: Colors.blue[200],
          textColor: Colors.black,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  // return UploadTest();
                  return CreatePost(
                    currentUser: currentUser,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void dosomething() {
    print("tapped");
  }

  void changestate() {
    setState(() {
      futureSearchResults = null;
      displaytimeline();
      emptyTheTextFormField();
    });
  }

  displayUsersFound() {
    return FutureBuilder(
      future: futureSearchResults,
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<UserResult> searchUsersResult = [];
        dataSnapshot.data.documents.forEach((document) {
          User eachUser = User.fromDocument(document);
          UserResult userResult = UserResult(eachUser);
          searchUsersResult.add(userResult);
        });

        return ListView(
          children: searchUsersResult,
        );
      },
    );
  }

  retrieveFollowings() async {
    QuerySnapshot querySnapshot = await timelineReference
        .document(widget.gCurrentUser.id)
        .collection("userFollowing")
        .getDocuments();

    setState(() {
      followingsList = querySnapshot.documents
          .map((document) => document.documentID)
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    retriveTimeLine();
    retrieveFollowings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: searchPageHeader(),
        body: Background(
          child: futureSearchResults == null
              ? RefreshIndicator(
                  child: currentUser.isacontributor
                      ? contributertimeline()
                      : displaytimeline(),
                  onRefresh: () => retriveTimeLine())
              : displayUsersFound(),
        ));
  }
}
