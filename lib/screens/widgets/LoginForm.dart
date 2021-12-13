import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/Authentication/ProjectFirebaseAuth.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/screens/home/components/SigningButton.dart';
import 'package:sigmamenu/screens/widgets/ForgotPassword.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Style.dart';

class LoginForm extends StatefulWidget {
  // final VoidCallback click;
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 170.0, end: 50.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller!.forward();
      } else {
        _controller!.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    void submit() async {
      _formKey.currentState!.save();
      // FocusScope.of(context).unfocus();
      if (_formKey.currentState!.validate()) {
        await ProjectFirebaseAuth()
            .login(email.text, password.text)
            .then((value) {
          if (value is UserCredential) {
            Navigator.pop(context);
          } else {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    content: Text(value.toString()),
                  );
                });
          }
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(height: _animation!.value),
          Container(
            width: 150,
            height: 150,
            child: Image.asset(
              'assets/images/yellowburger.png',
              fit: BoxFit.cover
            ),
          ),
          SizedBox(height: 15),

          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                /// email TextField
                TextFormField(
                  // focusNode: _focusNode,
                  controller: email,
                  onFieldSubmitted: (value) => submit(),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: translate(
                        context,
                        "email",
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                      hintStyle: FontStyle.normal(
                          context: context, color: Colors.black)),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.email(context),
                  ]),
                ),
                SizedBox(height: 16),

                /// password TextField
                TextFormField(
                  focusNode: _focusNode,
                  controller: password,
                  obscureText: hidePassword,
                  onFieldSubmitted: (valr) => submit(),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: translate(context, "password"),
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      hintStyle: FontStyle.normal(
                          context: context, color: Colors.black)),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 6),
                  ]),
                ),

                FortgotPasswordButton(ctx: context),
              ],
            ),
          ),
          SizedBox(height: 16),
          SigningButton(
              text: translate(context, "login"),
              onPressed: () => submit(),
              textStyle: Responsive.isDesktop(context)
                  ? FontStyle.small(
                      context: context,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  : null,
              color: Colors.black,
              textColor: Colors.white),
          const SizedBox(height: 16),
          // GuestLogin(),
          // const VSpace(),
          // Wrap(
          //   spacing: 2,
          //   children: [
          //     Text(
          //       translate(
          //         context,
          //         "noAccount",
          //       ),
          //       style: FontStyle.normal(
          //           context: context,
          //           color: Colors.black[300],
          //           fontWeight: FontWeight.bold),
          //     ),
          //     SizedBox(width: 8),
          //     // InkWell(
          //     //     // onTap: widget.click,
          //     //     child: Text(
          //     //       translate(context, "signup"),
          //     //       style: FontStyle.normal(
          //     //           context: context,
          //     //           fontWeight: FontWeight.bold,
          //     //           color: Colors.black),
          //     //     ))
          //   ],
          // )
        ],
      ),
    );
  }
}
