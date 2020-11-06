import 'dart:io';

import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/widgets/progresswiget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../checkLogin.dart';

class CreateGrp extends StatefulWidget {
  final String currentOnlineUserId;
  CreateGrp({this.currentOnlineUserId});

  @override
  _CreateGrpState createState() => _CreateGrpState();
}

class _CreateGrpState extends State<CreateGrp> {
  File photo;
  bool uploading = false;
  bool uploaded = false;
  String grpId = Uuid().v4();
  TextEditingController nameTextEditingController = TextEditingController();

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        photo = image;
      });
    });
  }

  Future<String> uploadPhoto(mImageFile) async {
    StorageUploadTask mStorageTask =
        storageReference.child("Group_Icons/grp_$grpId.jpg").putFile(mImageFile);
    String downloadUrl =
        await (await mStorageTask.onComplete).ref.getDownloadURL();
    return downloadUrl;
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
        url: downloadUrl, name: nameTextEditingController.text);

    nameTextEditingController.clear();

    setState(() {
      photo = null;
      uploading = false;
      grpId = Uuid().v4();
      uploaded = true;
    });
  }

  savePostInfoToFireStore({String url, String name}) {
    gropuReference
        .document(currentUser.id)
        .collection("Groupdata")
        .document(grpId)
        .setData({
      "grpid": grpId,
      "grpName": name,
      "ownerId": currentUser.id,
      "url": url,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          
            title: Text(
              "Create Group",
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
                      CachedNetworkImageProvider(currentUser.url),
                ),
                title: Container(
                  width: 250.0,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: nameTextEditingController,
                    decoration: InputDecoration(
                      hintText: "Name",
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
