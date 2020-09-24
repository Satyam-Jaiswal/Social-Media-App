import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserResult extends StatelessWidget {
  final eachUser;
  UserResult(this.eachUser);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
       
        // color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.black,
                      backgroundImage: CachedNetworkImageProvider(eachUser.url),
                    ),
                  ),
                  Text(
                    eachUser.profileName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    iconSize: 50,
                      icon: Icon(
                        Icons.check_circle_outline,
                        color: Colors.blue,
                      ),
                      onPressed: null),
                ],
              )
            ],
          ),
        ),
         decoration:BoxDecoration(
    borderRadius: BorderRadius.circular(30.0),
    color: Colors.grey,
  ),
      ),
    );
  }
}
