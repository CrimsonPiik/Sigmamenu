import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/models/category.dart';
import 'package:sigmamenu/screens/customerScreen.dart';
import 'package:sigmamenu/screens/widgets/adminDrawer.dart';
import 'package:sigmamenu/style/CommonUI.dart';

class AdminPanelCategories extends StatefulWidget {
  @override
  State<AdminPanelCategories> createState() => _AdminPanelCategoriesState();
}

class _AdminPanelCategoriesState extends State<AdminPanelCategories> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('SuperCategories')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);

          List<DocumentSnapshot> shots = snapshot.data!.docs;

          for (var item in shots) {
            superCat.add(item.id.toString());
          }
          for (var item in shots) {
            superCatAR.add(
                CategoryModel.fromMap(item.data() as Map<String, dynamic>));
          }
          print("SuperCategories : " + superCat.toString());

          return Scaffold(
            body: AdminPanel(),
          );
        });
  }
}
