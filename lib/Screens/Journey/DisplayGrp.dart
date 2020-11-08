import 'package:Walnut/Components/backgroung.dart';
import 'package:flutter/material.dart';

import 'Chat/chatroom.dart';

class Grp extends StatefulWidget {
  @override
  _GrpState createState() => _GrpState();
}

class _GrpState extends State<Grp> {
  dosomething() {
    print('shivaay');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChatRoom()));
  }

  showActivity() {
    print('This will show in app posts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Group Name')),
      body: Background(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.all_inbox),
                  onPressed: () => showActivity(),
                ),
                IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () => dosomething(),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
