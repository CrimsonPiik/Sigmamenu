
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/staggeredGridView.dart';
import 'package:sigmamenu/screens/widgets/adminDrawer.dart';
import 'package:sigmamenu/style/CommonUI.dart';

class AdminPanelCategories extends StatefulWidget {
  @override
  State<AdminPanelCategories> createState() => _AdminPanelCategoriesState();
}

class _AdminPanelCategoriesState extends State<AdminPanelCategories> {
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

          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            categoriesList.add(item.id.toString());
          }
          print("Categories : " + categoriesList.toString());
          // DateTime.now().millisecondsSinceEpoch.toString());

          return Scaffold(
            body:
                AdminPanel(),
                 //AdminPanelDrawer(streamControllerSideBar.stream),
          );
        });
  }
}
