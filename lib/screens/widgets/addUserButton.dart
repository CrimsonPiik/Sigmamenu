import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/Authentication/ProjectFirebaseAuth.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/screens/home/components/SigningButton.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Style.dart';

class AddUserButton extends StatefulWidget {
  const AddUserButton({Key? key}) : super(key: key);

  @override
  State<AddUserButton> createState() => _AddUserButtonState();
}

class _AddUserButtonState extends State<AddUserButton> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  bool hidePassword = true;

  void submit() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      print(_formKey.currentState!.value);
      await ProjectFirebaseAuth()
          .registerWithEmail(
        email.text,
        password.text,
      )
          .then(
        (value) async {
          if (value is UserCredential) {
            await ProjectFirebaseAuth()
                .createFirebaseUser(
                    value, fullName.text, 'user', phoneNumber.text)
                .whenComplete(() {
              Navigator.pop(context);
            });
          } else {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: Text(value.toString()),
                );
              },
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 12),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 40,
                child: TextButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FormBuilder(
                              key: _formKey,
                              child: AlertDialog(
                                scrollable: true,
                                title: Text('Create a new User',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                content: Column(
                                  children: [
                                    /// email TextField
                                    CommonUI.textField(
                                      context: context,
                                      // borderColor: Colors.brown,
                                      name: "email",
                                      controller: email,
                                      // prefixIcon: Icon(Icons.email, color: Colors.brown),
                                      hint: translate(context, "email"),
                                      validate: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.email(context),
                                      ]),
                                    ),

                                    /// Full name TextField
                                    CommonUI.textField(
                                      context: context,
                                      // borderColor: Colors.brown,
                                      name: "fullName",
                                      controller: fullName,
                                      // prefixIcon: Icon(Icons.person, color: Colors.brown),
                                      hint: translate(context, "Name"),
                                      validate: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                      ]),
                                    ),

                                    /// Phone TextField
                                    CommonUI.textField(
                                      context: context,
                                      // borderColor: Colors.brown,
                                      name: "phoneNumber",
                                      controller: phoneNumber,
                                      // prefixIcon: Icon(Icons.phone, color: Colors.brown),
                                      hint: translate(context, "phoneNumber"),
                                      validate: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.numeric(context),
                                      ]),
                                    ),

                                    /// password TextField
                                    TextFormField(
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
                                              color: Colors.orange,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            // borderSide: BorderSide(
                                            // color: Colors.brown,
                                            // ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            // borderSide: BorderSide(color: Colors.brown),
                                          ),
                                          hintText:
                                              translate(context, "password"),
                                          prefixIcon: Icon(Icons.lock,
                                              color: Colors.orange),
                                          hintStyle: FontStylee.normal(
                                            context: context,
                                            // color:
                                            //  Style.beigeCoffee
                                          )),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.minLength(
                                            context, 6),
                                      ]),
                                    ),
                                    SizedBox(height: 16),
                                    SigningButton(
                                        text: translate(context, "signup"),
                                        onPressed: () async {
                                          _formKey.currentState!.save();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            FocusScope.of(context).unfocus();
                                            print(_formKey.currentState!.value);
                                            await ProjectFirebaseAuth()
                                                .registerWithEmail(
                                              email.text,
                                              password.text,
                                            )
                                                .then(
                                              (value) async {
                                                if (value is UserCredential) {
                                                  Navigator.pop(context);
                                                  await ProjectFirebaseAuth()
                                                      .createFirebaseUser(
                                                          value,
                                                          fullName.text,
                                                          'user',
                                                          phoneNumber.text)
                                                      .whenComplete(() {
                                                    // Navigator.pop(context);
                                                  });
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        content: Text(
                                                            value.toString()),
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                            );
                                          }
                                        },
                                        textStyle: Responsive.isDesktop(context)
                                            ? FontStylee.small(
                                                context: context,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)
                                            : null,
                                        color: Colors.orange,
                                        textColor: Colors.white),
                                  ],
                                ),
                                // actions: [

                                // ],
                              ),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Add User  ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
