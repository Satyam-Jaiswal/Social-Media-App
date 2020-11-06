import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../DisplayGrp.dart';

class GroupResult extends StatelessWidget {
  final eachGroup;
  GroupResult(this.eachGroup);

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
              GestureDetector(
                onTap: () => Grp(),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.black,
                        backgroundImage:
                            CachedNetworkImageProvider(eachGroup.url),
                      ),
                    ),
                    Text(
                      eachGroup.grpname,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.grey,
        ),
      ),
    );
    ;
  }
}
