import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/models/user.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Style.dart';

class MyUser extends StatefulWidget {
  final AppUser user;
  const MyUser({Key? key, required this.user}) : super(key: key);

  @override
  State<MyUser> createState() => _MyUserState();
}

class _MyUserState extends State<MyUser> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool editmode = false;
  late TextEditingController _nameController =
      TextEditingController(text: _name);

  late TextEditingController _phoneController =
      TextEditingController(text: _number);

  late String _name;
  late String _number;
  @override
  void initState() {
    _name = widget.user.name;
    _number = widget.user.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future editUserProfile() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.user.id)
          .update({
        "name": _nameController.text,
        "phone": _phoneController.text,
      }).catchError((onError) => print("Error with editing User"));
      setState(() {
        editmode = false;
      });
    }

    return Center(
      child: Container(
        width: Responsive.isDesktop(context) ? size.width / 3 : size.width - 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                  radius: Responsive.isDesktop(context) ? 90 : 60,
                  backgroundImage: NetworkImage(widget.user.image)),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context) ? 32 : 16),
              child: editmode == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        CommonUI.textField(
                          icon: Icon(Icons.person, color: Colors.black),
                          context: context,
                          name: "Name",
                          isEdit: true,
                          controller: _nameController,
                          validate: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        SizedBox(height: 16),
                        CommonUI.textField(
                          icon: Icon(Icons.phone, color: Colors.black),
                          context: context,
                          name: "phone number",
                          isEdit: true,
                          controller: _phoneController,
                          validate: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    editmode = false;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  _formKey.currentState!.save();
                                  if (_formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    await editUserProfile().whenComplete(() {
                                      CommonUI.successDialog(context,
                                          message: "Saved successfully");
                                    }).onError((error, stackTrace) =>
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              content: Text(error.toString()),
                                            );
                                          },
                                        ));
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueAccent),
                                ),
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        CommonUI.textField(
                          enable: false,
                          icon: Icon(Icons.person, color: Colors.black),
                          context: context,
                          name: "Name",
                          isEdit: false,
                          controller: _nameController,
                          validate: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        SizedBox(height: 16),
                        CommonUI.textField(
                          enable: false,
                          icon: Icon(Icons.phone, color: Colors.black),
                          context: context,
                          name: "phone number",
                          isEdit: false,
                          controller: _phoneController,
                          validate: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                editmode = true;
                              });
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                await editUserProfile().whenComplete(() {
                                  CommonUI.successDialog(context,
                                      message: "Saved successfully");
                                }).onError((error, stackTrace) => showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: Text(error.toString()),
                                        );
                                      },
                                    ));
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent),
                            ),
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context, String title) {
    return CommonUI.text(
        text: title,
        style: FontStyle.normal(
            context: context, color: Colors.brown, fontWeight: FontWeight.bold),
        context: context);
  }
}
