import 'dart:async';
import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username ;

  submitUserName(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();

      SnackBar snackBar = SnackBar(content: Text("Welcome " + username));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 2),(){
        Navigator.pop(context,username);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Background(
        child:Column(
        children: <Widget>[
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.only(top: 26.0),
            child: Center(
              child: Text(
                "Set up a Username",
                style: TextStyle(
                  fontSize: 26.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(17.0),
            child: Container(
              child: Form(
                key: _formKey,
                autovalidate: true,
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  validator: (val){
                    if(val.trim().length<5 || val.isEmpty){
                      return "user name is very short";
                    }
                    else if(val.trim().length>15){
                      return "user name is very short";
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (val) => username=val,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(),
                    labelText: "username",
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                    ),
                    hintText: "must be atleast 5 characters",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
         RoundedButton(
                text: "Proceed",
                color: Colors.blue,
                textColor: Colors.white,
                press: () {
                 //Todo
                  submitUserName();
                },
              ),
        ],
      ),
      ),
    );
      
    
  }
}