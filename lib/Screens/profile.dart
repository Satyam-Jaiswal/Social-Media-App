import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/models/user.dart';
import 'package:Walnut/widgets/headerWidget.dart';
import 'package:Walnut/widgets/rounded_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'checkLogin.dart';
import 'editprofilepage.dart';

class ProfilePage extends StatefulWidget {
  String userProfileId;
  bool isacontributor;

  ProfilePage({this.userProfileId, this.isacontributor});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String currentUserId = currentUser.id;

  creteProfileTopView() {
    return FutureBuilder(
      future: usersReference.document(widget.userProfileId).get(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        User user = User.fromDocument(dataSnapshot.data);
        return Padding(
          padding: EdgeInsets.all(17.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 45.0,
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(user.url),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    user.username,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Friends"),
                            Text("Posts"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  user.profileName,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 3.0),
                child: Text(
                  user.bio,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
               RoundedButton(
                text: "Edit Profile",
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditProfilePage()
                        ;
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // editUserProfile() {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               EditProfilePage(currentUserId: currentUserId)));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, strTitle: "Profile"),
      body: Background(
        child: ListView(
          children: <Widget>[
            creteProfileTopView(),
            Divider(),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
