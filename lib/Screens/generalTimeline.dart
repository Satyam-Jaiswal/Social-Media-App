import 'package:Walnut/Components/backgroung.dart';
import 'package:flutter/material.dart';

class GeneralTimeline extends StatefulWidget {
  @override
  _GeneralTimelineState createState() => _GeneralTimelineState();
}

class _GeneralTimelineState extends State<GeneralTimeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(child: Text("Generaltimeline pages"),),
      
    );
  }
}