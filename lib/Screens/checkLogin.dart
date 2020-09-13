// import 'dart:html';

import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/Components/or_divider.dart';
import 'package:Walnut/Components/social_icon.dart';
import 'package:Walnut/Screens/search.dart';
import 'package:Walnut/Screens/timeline.dart';
import 'package:Walnut/Screens/notification.dart';
import 'package:Walnut/Screens/profile.dart';
import 'package:Walnut/models/user.dart';

import 'package:Walnut/widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants.dart';
import 'createAccountPage.dart';
import 'generalTimeline.dart';


final GoogleSignIn gSignIn = GoogleSignIn();

final usersReference = Firestore.instance.collection("users");

final DateTime timestamp = DateTime.now();
User currentUser;

class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  bool isSignedIn = false;
  PageController pageController;
  int getPageIndex = 0;

  void initState() {
    super.initState();
    pageController = PageController();

    gSignIn.onCurrentUserChanged.listen((gSignInAccount) {
      controlSignIn(gSignInAccount);
    }, onError: (gError) {
      print("Error Message: " + gError);
    });

    gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount) {
      controlSignIn(gSignInAccount);
    }).catchError((gError) {
      print("Error Message: " + gError);
    });
  }

  controlSignIn(GoogleSignInAccount signInAccount) async {
    if (signInAccount != null) {
      await saveDatatoFirebase();
      setState(() {
        isSignedIn = true;
      });
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  logInUser() {
    gSignIn.signIn();
  }

   logOutUser() {
    gSignIn.signOut();
  }

  whenPageChanges(int pageIndex) {
    setState(() {
    this.getPageIndex = pageIndex;
      
    });
  }

  saveDatatoFirebase() async {
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot = await usersReference.document(gCurrentUser.id).get();

    if (!documentSnapshot.exists) {
      final username = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => CreateAccountPage()));

      usersReference.document(gCurrentUser.id).setData({
        "id": gCurrentUser.id,
        "profileName": gCurrentUser.displayName,
        "username": username,
        "url": gCurrentUser.photoUrl,
        "email": gCurrentUser.email,
        "bio": "",
        "timeStamp": timestamp,
      });

      documentSnapshot = await usersReference.document(gCurrentUser.id).get();

    }

    
     currentUser = User.fromDocument(documentSnapshot);

  }


  changePage(int pageIndex){
    pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 400), curve: Curves.bounceInOut,);
  }

  Scaffold loginScreen() {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "WELCOME TO WALNUT",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/doctor.svg",
                height: size.height * 0.40,
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {
                      logInUser();
                    },
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                ],
              ),
              OrDivider(),
              RoundedButton(
                text: "SKIP",
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GeneralTimeline();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold userTimeline() {
    return Scaffold(
      body: Background(
          child: PageView(
            children: <Widget>[
              Timeline(),
              Search(),
              NotificationPage(),
              ProfilePage(userProfileId: currentUser?.id),
              // IconButton(icon: Icon(Icons.clear, color: Colors.white,), onPressed: logOutUser()),),
            ],
            controller: pageController,
            onPageChanged: whenPageChanges,
            physics: NeverScrollableScrollPhysics(),
          ),
      
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: getPageIndex,
        onTap: changePage,
        backgroundColor: Colors.grey[300],
        activeColor: Colors.green[600],
        inactiveColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
          // BottomNavigationBarItem(icon: Icon(Icons.logout)),
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return userTimeline();
    } else {
      return loginScreen();
    }
  }
}
