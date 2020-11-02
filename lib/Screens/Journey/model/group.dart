import 'package:cloud_firestore/cloud_firestore.dart';

class Group{
  final String id;
  final String owner_id;
  final String grpName;
  final String url;
 
  Group({
    this.id,
    this.grpName,
    this.url,
    this.owner_id,
   
 });

  factory Group.fromDocument(DocumentSnapshot doc){
    return Group(
      id: doc.documentID,
      url: doc['url'],
      grpName: doc['grpName'],
      owner_id: doc['owner_id'],
    );
  }
}