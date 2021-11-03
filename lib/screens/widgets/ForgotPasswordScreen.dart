import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shop_app/Authentication/ProjectFirebaseAuth.dart';
import 'package:shop_app/style/CommonUI.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: 500,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Text('Forgot Password?', style: TextStyle(fontSize: 15)

                      // textAlign: TextAlign.start,

                      // style: FontStyle.title(
                      //     context: context,
                      //     color: Theme.of(context).primaryColor),
                      ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Enter your email below to receive your password reset instructions.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13)
                      // style: FontStyle.normal(context: context)
                      ),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                      width: 300,
                      child: CommonUI.textField(
                          context: context,
                          name: "email",
                          controller: emailcontroller,
                          isEdit: false,
                          validate: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.email(context),
                          ]),
                          hint: "Email",
                          icon: Icon(
                            Icons.email_outlined,
                            color: Colors.brown,
                          ))),
                  SizedBox(
                    height: 8,
                  ),
                  CommonUI.textButton(
                      text: "Send",
                      click: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                         ProjectFirebaseAuth()
                              .resetEmailPassword(emailcontroller.text);
                          Navigator.pop(context);
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      'Please check your email for password reset instructions.'),
                                );
                              });
                        }
                      },
                      boarder: 10,
                      color: Colors.brown,
                      textColor: Colors.white),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
