import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/layout/sidebar.dart';
import 'package:sigmamenu/screens/widgets/adminPanelProducts.dart';
import 'package:sigmamenu/style/CommonUI.dart';

StreamController<int> streamControllerSideBar =
    StreamController<int>.broadcast();

class AdminPanel extends StatefulWidget {
  final bool showDesktop;
  AdminPanel([this.showDesktop = false]);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

Set<String> categoriesList = {};

class _AdminPanelState extends State<AdminPanel> {
  TextEditingController newCollectionNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);
          // if (snapshot.connectionState == ConnectionState.active) {
          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            categoriesList.add(item.id.toString());
            // }
          }
          print("Categories : " + categoriesList.toString());
          // DateTime.now().millisecondsSinceEpoch.toString());

          return Scaffold(
            body: Row(
              children: [
                SideBar(),
                AdminPanelProducts(streamControllerSideBar.stream),
              ],
            ),
          );
        });
  }
}
