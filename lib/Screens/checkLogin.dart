
import 'package:Walnut/Components/backgroung.dart';
import 'package:Walnut/Components/or_divider.dart';
import 'package:Walnut/Components/social_icon.dart';

import 'package:Walnut/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants.dart';
import 'generalTimeline.dart';

final GoogleSignIn gSignIn = GoogleSignIn();



class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {


   bool isSignedIn = false; 

   void initState() {
    super.initState();
    // pageController = PageController();

    gSignIn.onCurrentUserChanged.listen((gSignInAccount) {
      controlSignIn(gSignInAccount);
    }, onError: (gError) {
      print("Error Message: " + gError);
    });

    gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount) {
      controlSignIn(gSignInAccount);
    }).catchError((gError) {
      print("Error Message: " + gError);
    });
  }

   controlSignIn(GoogleSignInAccount signInAccount) async {
    if (signInAccount != null) {
    
      setState(() {
        isSignedIn = true;
      });
    
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

   logInUser() {
    gSignIn.signIn();
  }

   Scaffold loginScreen(){
      Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
          body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "WELCOME TO WALNUT",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/doctor.svg",
                height: size.height * 0.40,
              ),
              SizedBox(height: size.height * 0.05),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                    SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {
                      logInUser();
                    },
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                
                ],
              ),
             
               OrDivider(),


              RoundedButton(
                text: "SKIP",
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {                 
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GeneralTimeline();
                      },
                    ),
                  );
                },
              ),
             
             
            ],
          ),
        ),
      ),
    );
   }


   Scaffold userTimeline(){
      return Scaffold(
      appBar: AppBar(leading:( Icon(Icons.ac_unit)),title: Text("Walnut") ,),
      body: Background(child: Text("Satyam Jaiswal") ),
      
      
    );

   }

   

  @override
  Widget build(BuildContext context) {
    if(isSignedIn){
      return userTimeline();
    }
    else{    
     return loginScreen()  ;   
    }    
    
    
  }
  }
