import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sigmamenu/GeneralFunction/Strings.dart';
import 'package:sigmamenu/style/CommonUI.dart';

class AddCategoryButton extends StatefulWidget {
  @override
  State<AddCategoryButton> createState() => _AddCategoryButtonState();
}

class _AddCategoryButtonState extends State<AddCategoryButton> {
  TextEditingController newCollectionNameController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        height: 37,
        padding: EdgeInsets.all(8),
        child: InkWell(
            onTap: () {
              _showAddCollectionDialog();
            },
            child: Icon(Icons.add)),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  void _showAddCollectionDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormBuilder(
            key: _formKey,
            child: AlertDialog(
              title: Text(
                'Add Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: CommonUI.textField(
                        context: context,
                        name: "Name",
                        hint: 'Name',
                        maxlines: 1,
                        controller: newCollectionNameController,
                        validate: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          child: TextButton(
                            onPressed: () async {
                              _formKey.currentState!.save();

                              if (_formKey.currentState!.validate()) {
                                await FirebaseFirestore.instance
                                    .collection(newCollectionNameController.text
                                        .toLowerCase()
                                        .toTitleCase())
                                    .add({});
                                FocusScope.of(context).unfocus();
                                await FirebaseFirestore.instance
                                    .collection('Categories')
                                    .doc(newCollectionNameController.text
                                        .toLowerCase()
                                        .toTitleCase())
                                    .set({}).whenComplete(() {
                                  Navigator.of(context).pop();
                                  newCollectionNameController.clear();

                                  CommonUI.successDialog(context,
                                      message: "Saved successfully");
                                }).onError(
                                  (error, stackTrrace) => showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        content: Text(error.toString()),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: TextButton(
                            onPressed: () {
                              newCollectionNameController.clear();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
