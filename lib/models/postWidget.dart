import 'dart:async';
import 'package:Walnut/Screens/checkLogin.dart';
import 'package:Walnut/Screens/profile.dart';
import 'package:Walnut/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final String postId;
  final String ownerId;
  final dynamic likes;
  final String username;
  final String description;
  final String location;
  final String url;

  PostWidget({
    this.postId,
    this.ownerId,
    this.likes,
    this.username,
    this.description,
    this.location,
    this.url,
  });

  factory PostWidget.fromDocument(DocumentSnapshot documentSnapshot) {
    return PostWidget(
      postId: documentSnapshot["postId"],
      ownerId: documentSnapshot["ownerId"],
      likes: documentSnapshot["likes"],
      username: documentSnapshot["username"],
      description: documentSnapshot["description"],
      location: documentSnapshot["location"],
      url: documentSnapshot["url"],
    );
  }

  int getTotalNumberOfLikes(likes) {
    if (likes == null) {
      return 0;
    }
    int counter = 0;
    likes.values.forEach((eachValue) {
      if (eachValue == true) {
        counter = counter + 1;
      }
    });
    return counter;
  }

  @override
  _PostWidgetState createState() => _PostWidgetState(
        postId: this.postId,
        ownerId: this.ownerId,
        likes: this.likes,
        username: this.username,
        description: this.description,
        location: this.location,
        url: this.url,
        likeCount: getTotalNumberOfLikes(this.likes),
      );
}

class _PostWidgetState extends State<PostWidget> {
  final String postId;
  final String ownerId;
  Map likes;
  final String username;
  final String description;
  final String location;
  final String url;
  int likeCount;
  bool isLiked;
  bool showHeart = false;
  final String currentOnlineUserId = currentUser.id;

  _PostWidgetState({
    this.postId,
    this.ownerId,
    this.likes,
    this.username,
    this.description,
    this.location,
    this.url,
    this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentOnlineUserId] == true);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: <Widget>[
          createPostHead(),
         
          createPostPicture(),
          
          createPostFooter()
        ],
      ),
    );
  }

  createPostHead() {
    return FutureBuilder(
      future: usersReference.document(ownerId).get(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Center(child: CircularProgressIndicator(), );
        }
        User user = User.fromDocument(dataSnapshot.data);
        bool isPostOwner = currentOnlineUserId == ownerId;
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.url),
            backgroundColor: Colors.grey,
          ),
          title: GestureDetector(
            onTap: () => displayUserProfile(context, userProfileId: user.id),
            child: Text(
              user.profileName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // subtitle: Text(
          //   'titel',
          //   style: TextStyle(color: Colors.black),
          // ),
          trailing: isPostOwner
              ? IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: () {
                  print("deleted");
                  //TODO
                    
                  } 
                )
              : Text(""),
        );
      },
    );
  }

  displayUserProfile(BuildContext context, {String userProfileId}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  userProfileId: userProfileId,
                )));
  }

  removeLike() {
    bool isNotPostOwner = currentOnlineUserId != ownerId;
    if (isNotPostOwner) {
      activityFeedReference
          .document(ownerId)
          .collection("feedItems")
          .document(postId)
          .get()
          .then((document) {
        if (document.exists) {
          document.reference.delete();
        }
      });
    }
  }

  addLike() {
    bool isNotPostOwner = currentOnlineUserId != ownerId;
    if (isNotPostOwner) {
      activityFeedReference
          .document(ownerId)
          .collection("feedItems")
          .document(postId)
          .setData({
        "type": "like",
        "username": currentUser.username,
        "userId": currentUser.id,
        "timestamp": DateTime.now(),
        "url": url,
        "postId": postId,
        "userProfileImg": url,
      });
    }
  }

  controlUserLikePost() {
    bool _liked = likes[currentOnlineUserId] == true;

    if (_liked) {
      postsReference
          .document(ownerId)
          .collection("userPosts")
          .document(postId)
          .updateData({"likes.$currentOnlineUserId": false});
      removeLike();
      setState(() {
        likeCount = likeCount - 1;
        isLiked = false;
        likes[currentOnlineUserId] = false;
      });
    } else if (!_liked) {
      postsReference
          .document(ownerId)
          .collection("userPosts")
          .document(postId)
          .updateData({"likes.$currentOnlineUserId": true});
      addLike();

      setState(() {
        likeCount = likeCount + 1;
        isLiked = true;
        likes[currentOnlineUserId] = true;
        showHeart = true;
      });
      Timer(Duration(milliseconds: 800), () {
        setState(() {
          showHeart = false;
        });
      });
    }
  }

  createPostPicture() {
    return GestureDetector(
      onDoubleTap: () => controlUserLikePost(),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Text('descriptionkdsuthiutilulod'),
          Image.network(url),
          showHeart
              ? Icon(
                  Icons.thumb_up,
                  size: 140.0,
                  color: Colors.blue,
                )
              : Text(""),
        ],
      ),
    );
  }

  createPostFooter() {
    return Column(
      children: <Widget>[
         Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Container(
            //   margin: EdgeInsets.only(left: 20.0),
            //   child: 
            //   // Text(
            //   //   "$username",
            //   //   style: TextStyle(
            //   //     color: Colors.black,
            //   //     fontWeight: FontWeight.bold,
            //   //   ),
            //   // ),
            // ),
            Container(
              // padding: EdgeInsets.all(10)
              child: Expanded(
                
                child: Text(
                  // "shivaay",
                  description,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20.0),
            ),
            GestureDetector(
              onTap: () => controlUserLikePost(),
              child: Icon(
                isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                size: 28.0,
                color: Colors.blue,
              ),
              
            ),

            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                "$likeCount likes",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
            ),
            GestureDetector(
              // onTap: () => displayComments(context,
                  // postId: postId, ownerId: ownerId, url: url),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 28.0,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        // Row(
        //   children: <Widget>[
        //     Container(
        //       margin: EdgeInsets.only(left: 20.0),
        //       child: Text(
        //         "$likeCount likes",
        //         style: TextStyle(
        //           color: Colors.black,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Container(
        //       margin: EdgeInsets.only(left: 20.0),
        //       child: Text(
        //         "$username",
        //         style: TextStyle(
        //           color: Colors.black,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       child: Text(
        //         description,
        //         style: TextStyle(color: Colors.black),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  displayComments(BuildContext context,
      {String postId, String ownerId, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Container();
    }));
  }
}

