import 'dart:io';

import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/Screens/checkLogin.dart';
import 'package:Walnut/Screens/timeline.dart';
import 'package:Walnut/models/user.dart';
import 'package:Walnut/widgets/progresswiget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';

import 'checkLogin.dart';

class CreatePost extends StatefulWidget {
  final User currentUser;
  CreatePost({this.currentUser});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File photo;
  bool uploading = false;
  bool uploaded = false;
  String postId = Uuid().v4();
  TextEditingController descriptionTextEditingController =
      TextEditingController();

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        photo = image;
      });
    });
  }

  void clearPostInfo() {
    print('this will clear the post form');
    setState(() {
      photo = null;
    });
  }

  controlUploadingAndSave() async {
    String downloadUrl;
    setState(() {
      uploading = true;
    });
    if (photo != null) {
      downloadUrl = await uploadPhoto(photo);
    } else {
      downloadUrl = null;
    }

    savePostInfoToFireStore(
        url: downloadUrl, description: descriptionTextEditingController.text);

    descriptionTextEditingController.clear();

    setState(() {
      photo = null;
      uploading = false;
      postId = Uuid().v4();
      uploaded = true;
    });

    return Timeline();
  }

  savePostInfoToFireStore({String url, String location, String description}) {
    postsReference
        .document(widget.currentUser.id)
        .collection("userPosts")
        .document(postId)
        .setData({
      "postId": postId,
      "ownerId": widget.currentUser.id,
      "timestamp": DateTime.now(),
      "likes": {},
      "username": widget.currentUser.username,
      "description": description,
      "location": null,
      "url": url,
    });
  }

  Future<String> uploadPhoto(mImageFile) async {
    StorageUploadTask mStorageTask =
        storageReference.child("post_$postId.jpg").putFile(mImageFile);
    String downloadUrl =
        await (await mStorageTask.onComplete).ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    if (uploaded)
      return Timeline();
    else
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: clearPostInfo,
            ),
            title: Text(
              "New Post",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: uploading ? null : () => controlUploadingAndSave(),
                child: Text(
                  "Share",
                  style: TextStyle(
                      color: Colors.lightGreenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              ),
            ],
          ),
          body: Background(
              child: ListView(children: <Widget>[
            uploading ? linearProgress() : Text(""),
            Container(
                child: Column(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    chooseFile();
                  },
                  child: photo != null
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(
                              photo,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          width: MediaQuery.of(context).size.width,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.black45,
                          ),
                        )),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(widget.currentUser.url),
                ),
                title: Container(
                  width: 250.0,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: descriptionTextEditingController,
                    decoration: InputDecoration(
                      hintText: "Write here.....",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Divider(),
            ])),
          ])));
  }
}
