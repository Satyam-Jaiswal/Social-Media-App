import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/widgets/headerWidget.dart';
import 'package:Walnut/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'DisplayGrp.dart';
import 'creategrp.dart';

class Journey extends StatefulWidget {
  @override
  _JourneyState createState() => _JourneyState();
}

class _JourneyState extends State<Journey> {


  displayGrp(){
     Navigator.push(context, MaterialPageRoute(builder: (context) => Grp()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, strTitle: "Journey"),
      body: Background(
          child: Column(
            children: [
              Expanded(
                          child: Column(
        children: [
                GestureDetector(
                  
                  onTap: () => displayGrp(),
                  child: Container(
                    color: Colors.amber,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        Text(
                          'Group Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
        ],
      ),
              ),RoundedButton(
          text: "CREATE GROUP",
          color: Colors.blue[200],
          textColor: Colors.black,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CreateGrp(                   
                  );
                },
              ),
            );
          },
        ),
            ],
          ),
          ),
    );
  }
}
