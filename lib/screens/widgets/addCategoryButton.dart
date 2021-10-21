import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/GeneralFunction/Strings.dart';
import 'package:shop_app/style/CommonUI.dart';

class AddCategoryButton extends StatefulWidget {
  @override
  State<AddCategoryButton> createState() => _AddCategoryButtonState();
}

class _AddCategoryButtonState extends State<AddCategoryButton> {
  TextEditingController newCollectionNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: TextButton.icon(
              onPressed: () {
                _showAddCollectionDialog();
              },
              icon: Icon(Icons.add),
              label: Text('Category')),
        ),
        SizedBox(width: 21),
      ],
    );
  }

  void _showAddCollectionDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Category'),
            actions: [
              Column(
                children: [
                  Container(
                    height: 50,
                    width: 200,
                    child: CommonUI.textField(
                      context: context,
                      name: "Category Name",
                      hint: 'Category Name',
                      controller: newCollectionNameController,
                      //hint: widget.data.descriptionEn
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                         
                          FirebaseFirestore.instance
                              .collection('Categories')
                              .doc(newCollectionNameController.text
                                  .toTitleCase())
                              .set({});
                          FirebaseFirestore.instance
                              .collection(newCollectionNameController.text
                                  .toTitleCase()
                                  .substring(0)
                                  .toUpperCase())
                              .add({});
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // getCategories();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }
}
