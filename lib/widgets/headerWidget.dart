import 'package:flutter/material.dart';

AppBar header(context,
    {bool isAppTitle=false, String strTitle, disappearedBackButton = false}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    automaticallyImplyLeading: disappearedBackButton ? false : true,
    title: Text(
      isAppTitle ? "Walnut" : strTitle,
      style: TextStyle(color: Colors.white,
      fontSize: 22.0),
      overflow: TextOverflow.ellipsis,

    ),
    centerTitle: true,
    // backgroundColor:Colors.grey[300],
  );
}
