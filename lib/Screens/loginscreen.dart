// // import 'dart:html';

// import 'package:Walnut/Components/backgroung.dart';
// import 'package:Walnut/Components/or_divider.dart';
// import 'package:Walnut/Components/social_icon.dart';
// import 'package:Walnut/widgets/rounded_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_sign_in/google_sign_in.dart';


// import '../constants.dart';
// import 'generalTimeline.dart';

// final GoogleSignIn gSignIn = GoogleSignIn();

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> { 

//   logInUser() {
//     gSignIn.signIn();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // This size provide us total height and width of our screen
//     return Scaffold(
//           body: Background(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 "WELCOME TO WALNUT",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: size.height * 0.05),
//               SvgPicture.asset(
//                 "assets/icons/doctor.svg",
//                 height: size.height * 0.40,
//               ),
//               SizedBox(height: size.height * 0.05),

//                Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SocalIcon(
//                     iconSrc: "assets/icons/facebook.svg",
//                     press: () {},
//                   ),
//                     SocalIcon(
//                     iconSrc: "assets/icons/google-plus.svg",
//                     press: () {
//                       logInUser();
//                     },
//                   ),
//                   SocalIcon(
//                     iconSrc: "assets/icons/twitter.svg",
//                     press: () {},
//                   ),
                
//                 ],
//               ),
             
//                OrDivider(),


//               RoundedButton(
//                 text: "SKIP",
//                 color: kPrimaryLightColor,
//                 textColor: Colors.black,
//                 press: () {                 
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return GeneralTimeline();
//                       },
//                     ),
//                   );
//                 },
//               ),
             
             
//             ],
//           ),
//         ),
//       ),
//     );
// }
// }



// // class LoginScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     Size size = MediaQuery.of(context).size;
// //     // This size provide us total height and width of our screen
// //     return Scaffold(
// //           body: Background(
// //         child: SingleChildScrollView(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               Text(
// //                 "WELCOME TO WALNUT",
// //                 style: TextStyle(fontWeight: FontWeight.bold),
// //               ),
// //               SizedBox(height: size.height * 0.05),
// //               SvgPicture.asset(
// //                 "assets/icons/doctor.svg",
// //                 height: size.height * 0.40,
// //               ),
// //               SizedBox(height: size.height * 0.05),

// //                Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: <Widget>[
// //                   SocalIcon(
// //                     iconSrc: "assets/icons/facebook.svg",
// //                     press: () {},
// //                   ),
// //                     SocalIcon(
// //                     iconSrc: "assets/icons/google-plus.svg",
// //                     press: () {
// //                       logInUser();
// //                     },
// //                   ),
// //                   SocalIcon(
// //                     iconSrc: "assets/icons/twitter.svg",
// //                     press: () {},
// //                   ),
                
// //                 ],
// //               ),
             
// //                OrDivider(),


// //               RoundedButton(
// //                 text: "SKIP",
// //                 color: kPrimaryLightColor,
// //                 textColor: Colors.black,
// //                 press: () {                 
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (context) {
// //                         return GeneralTimeline();
// //                       },
// //                     ),
// //                   );
// //                 },
// //               ),
             
             
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // } 