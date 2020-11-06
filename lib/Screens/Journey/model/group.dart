import 'package:cloud_firestore/cloud_firestore.dart';

class Group{
  final String grpid;
  final String owner_id;
  final String grpName;
  final String url;
 
  Group({
    this.grpid,
    this.grpName,
    this.url,
    this.owner_id,
   
 });

  factory Group.fromDocument(DocumentSnapshot doc){
    return Group(
      grpid: doc.documentID,
      url: doc['url'],
      grpName: doc['grpName'],
      owner_id: doc['owner_id'],
    );
  }
}