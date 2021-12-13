// import 'package:flutter/material.dart';
// import 'package:sigmamenu/screens/widgets/LoginForm.dart';
// import 'package:sigmamenu/style/ScreenUtil.dart';

// class SigningPopUp extends StatefulWidget {
//   const SigningPopUp({Key? key}) : super(key: key);

//   @override
//   _SigningPopUpState createState() => _SigningPopUpState();
// }

// class _SigningPopUpState extends State<SigningPopUp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               width: Responsive.isDesktop(context)
//                   ? Responsive.width(context) * 0.4
//                   : Responsive.width(context) - 40,
//               child: Center(
//                 child: SingleChildScrollView(child: LoginForm()),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //  Padding(
//           // padding: EdgeInsets.symmetric(
//           //     horizontal: Responsive.isDesktop(context) ? 90 : 0),
//           // child:
//           // Dialog(
//           // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           // elevation: 0,
//           // backgroundColor:
//           //  Theme.of(context).brightness == Brightness.light
//           // ?
//           // Colors.grey.withOpacity(0.1),
//           // : Color(0xff404040),
//           // child:
//           // SingleChildScrollView(
//           // child:
//           // Padding(
//           // padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
//           // child:
//           // Padding(
//           // padding: EdgeInsets.symmetric(vertical: Responsive.isDesktop(context) ? 60 : 0),
//           // child:

//             // SizedBox(height: 100),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.end,
//             //   children: [
//             //     // Text(
//             //     //   isLogin ? "Login" : "Sign up",
//             //     //   // style: FontStyle.title(
//             //     //   //     context: context,
//             //     //   //     color: Style.darkBrown,
//             //     //   //     fontWeight: FontWeight.bold),
//             //     // ),
//             //     IconButton(
//             //         onPressed: () {
//             //           Navigator.pop(context);
//             //         },
//             //         icon: Icon(Icons.close))
//             //   ],
//             // ),
//             // VSpace(),
//             // Align(
//             //   alignment: Alignment.topLeft,
//             //   child: CommonUI.text(
//             //     context: context,
//             //     text: isLogin
//             //         ? "Login to subscribe to products, track orders, share your favorite recipes with our community and review products!"
//             //         : "Sign up to subscribe to products, track orders, share your favorite recipes with our community and review products!",
//             //     // style: FontStyle.subTitle(
//             //     //     context: context,
//             //     //     color: Style.beigeBrown,
//             //     //     fontWeight: FontWeight.bold)
//             //   ),
//             // ),
//             // VSpace(),
//             // SizedBox(height: 30),
//                 //Column(
//                 // children: [
//                 /// Social media button section
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //   children: [
//                 // Container(
//                 //   width: 150,
//                 //   height: 150,
//                 //   child: Image.asset(
//                 //     'assets/images/yellowburger.png',
//                 //     // fit: BoxFit.fitWidth
//                 //   ),
//                 // ),
//                 // SocialMediaRectangularButton(
//                 //   onPressed: () async {
//                 //     await ProjectFirebaseAuth()
//                 //         .signInWithGoogle()
//                 //         .catchError((onError) => showErrorPopUp(
//                 //             context,
//                 //             onError,
//                 //             'Sign in with google error#1'));
//                 //   },
//                 //   svgIcon: SvgAssets.googleIcon,
//                 // ),
//                 // SocialMediaRectangularButton(
//                 //   onPressed: () async {
//                 //     await ProjectFirebaseAuth()
//                 //         .signInWithFacebook()
//                 //         .catchError((onError) => showErrorPopUp(
//                 //             context,
//                 //             onError,
//                 //             'Sign in with google error#1'));
//                 //   },
//                 //   svgIcon: SvgAssets.facebookIcon,
//                 // ),
//                 // SocialMediaRectangularButton(
//                 //   onPressed: () {},
//                 //   svgIcon: SvgAssets.apple,
//                 // ),
//                 // ],
//                 // ),
//                 // SizedBox(height: 7),

//                 /// Divider Section
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     SizedBox(
//                 //       width: Responsive.width(context) * 0.06,
//                 //       child: Divider(
//                 //           // color: Style.beige,
//                 //           ),
//                 //     ),
//                 //     // SizedBox(width: Responsive.width(context) * 0.01),
//                 //     // CommonUI.text(3ontWeight.bold)),
//                 //     SizedBox(width: Responsive.width(context) * 0.01),
//                 //     SizedBox(
//                 //       width: Responsive.width(context) * 0.06,
//                 //       height: 10,
//                 //       child: Divider(
//                 //           // color: Style.beige,
//                 //           ),
//                 //     ),
//                 //   ],
//                 // ),

//                 /// Signing Section
//                 // SizedBox(height: 7),
//                 // isLogin
//                 //     ?
//                 // click: () => setState(() {
//                 //       isLogin = false;
//                 //     })
//                 // ),
//                 // : SignUpForm(
//                 //     click: () => setState(() {
//                 //           isLogin = true;
//                 //         }))
//                 // ],
//                 // ),
        