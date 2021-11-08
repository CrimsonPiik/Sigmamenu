import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/widgets/LoginForm.dart';
import 'package:sigmamenu/screens/widgets/signUpForm.dart';
import 'package:sigmamenu/screens/widgets/vSpace.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Style.dart';

class SigningPopUp extends StatefulWidget {
  const SigningPopUp({Key? key}) : super(key: key);

  @override
  _SigningPopUpState createState() => _SigningPopUpState();
}

bool isLogin = true;

class _SigningPopUpState extends State<SigningPopUp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 90 : 0),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.withOpacity(0.2)
            : Color(0xff404040),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text(
                    //   isLogin ? "Login" : "Sign up",
                    //   // style: FontStyle.title(
                    //   //     context: context,
                    //   //     color: Style.darkBrown,
                    //   //     fontWeight: FontWeight.bold),
                    // ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                // VSpace(),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: CommonUI.text(
                //     context: context,
                //     text: isLogin
                //         ? "Login to subscribe to products, track orders, share your favorite recipes with our community and review products!"
                //         : "Sign up to subscribe to products, track orders, share your favorite recipes with our community and review products!",
                //     // style: FontStyle.subTitle(
                //     //     context: context,
                //     //     color: Style.beigeBrown,
                //     //     fontWeight: FontWeight.bold)
                //   ),
                // ),
                VSpace(),
                SizedBox(
                  width: Responsive.isDesktop(context)
                      ? Responsive.width(context) * 0.4
                      : null,
                  child: Column(
                    children: [
                      /// Social media button section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            child: Image.asset(
                              'assets/images/sigma.jpeg',
                              // fit: BoxFit.fitWidth
                            ),
                          ),
                          // SocialMediaRectangularButton(
                          //   onPressed: () async {
                          //     await ProjectFirebaseAuth()
                          //         .signInWithGoogle()
                          //         .catchError((onError) => showErrorPopUp(
                          //             context,
                          //             onError,
                          //             'Sign in with google error#1'));
                          //   },
                          //   svgIcon: SvgAssets.googleIcon,
                          // ),
                          // SocialMediaRectangularButton(
                          //   onPressed: () async {
                          //     await ProjectFirebaseAuth()
                          //         .signInWithFacebook()
                          //         .catchError((onError) => showErrorPopUp(
                          //             context,
                          //             onError,
                          //             'Sign in with google error#1'));
                          //   },
                          //   svgIcon: SvgAssets.facebookIcon,
                          // ),
                          // SocialMediaRectangularButton(
                          //   onPressed: () {},
                          //   svgIcon: SvgAssets.apple,
                          // ),
                        ],
                      ),
                      const VSpace(),

                      /// Divider Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Responsive.width(context) * 0.06,
                            child: Divider(
                                // color: Style.beige,
                                ),
                          ),
                          SizedBox(width: Responsive.width(context) * 0.01),
                          CommonUI.text(
                              context: context,
                              text: isLogin
                                  ? "Or Sign in with Email"
                                  : "Or Sign Up with Email",
                              style: FontStyle.subTitle(
                                  context: context,
                                  // color: Style.darkBrown,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: Responsive.width(context) * 0.01),
                          SizedBox(
                            width: Responsive.width(context) * 0.06,
                            height: 10,
                            child: Divider(
                                // color: Style.beige,
                                ),
                          ),
                        ],
                      ),

                      /// Signing Section
                      const VSpace(),
                      isLogin
                          ? LoginForm(
                              click: () => setState(() {
                                    isLogin = false;
                                  }))
                          : SignUpForm(
                              click: () => setState(() {
                                    isLogin = true;
                                  }))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
