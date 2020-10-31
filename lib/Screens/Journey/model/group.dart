import 'package:cloud_firestore/cloud_firestore.dart';

class Group{
  final String id;
  final String grpName;
  final String username;
  final String url;
 
  Group({
    this.id,
    this.grpName,
    this.username,
    this.url,
   
 });

  factory Group.fromDocument(DocumentSnapshot doc){
    return Group(
      id: doc.documentID,
      username: doc['username'],
      url: doc['url'],
      grpName: doc['profileName'],
    );
  }
}