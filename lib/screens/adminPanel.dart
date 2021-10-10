import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/sidebar.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/home/components/categorries.dart';
import 'package:shop_app/screens/home/components/itemCardDataAdmin.dart';
import 'package:shop_app/style/CommonUI.dart';

class AdminPanel extends StatefulWidget {
  final bool showDesktop;
  const AdminPanel([this.showDesktop = false]);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  TextEditingController newCollectionNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            // color: primaryLight.withAlpha(100),
            // padding: EdgeInsets.symmetric(horizontal: ),
            child: Column(
              children: [
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      this.widget.showDesktop
                          ? SizedBox.shrink()
                          : IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Admin Dashboard',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                              onPressed: () {
                                _showAddCollectionDialog(context);
                              },
                              child: Text("Add Category"))
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Categories(),
                SizedBox(height: 15),
                ItemCardDataAdmin(streamController.stream),
              ],
            ),
          ),
        ],
      ),
    );
    // });
  }

  _showAddCollectionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add'),
            content: Text('Category name'),
            actions: [
              Container(
                height: 50,
                width: 200,
                child: CommonUI.textField(
                  context: context,
                  name: "Category Name",
                  controller: newCollectionNameController,
                  //hint: widget.data.descriptionEn
                ),
              ),
              TextButton(
                onPressed: () {
                  // categories.add(newCollectionNameController.text);
                  FirebaseFirestore.instance
                      .collection('categories')
                      .doc(newCollectionNameController.text)
                      .set({});
                  FirebaseFirestore.instance
                      .collection(newCollectionNameController.text)
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
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        });
  }
}
