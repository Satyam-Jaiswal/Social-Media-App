import 'package:Walnut/Components/backgroung.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Background(child: Text('comments will be shown here'),),
      
    );
  }
}