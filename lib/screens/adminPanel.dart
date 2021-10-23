import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/sidebar.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/home/components/categorries.dart';
import 'package:shop_app/screens/home/components/itemCardDataAdmin.dart';
import 'package:shop_app/screens/widgets/addCategoryButton.dart';
import 'package:shop_app/screens/widgets/addProductButton.dart';
import 'package:shop_app/screens/widgets/deleteCategoryButton.dart';
import 'package:shop_app/style/CommonUI.dart';

class AdminPanel extends StatefulWidget {
  final bool showDesktop;
  const AdminPanel([this.showDesktop = false]);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

Set<String> categoriesList = {};

class _AdminPanelState extends State<AdminPanel> {
  TextEditingController newCollectionNameController = TextEditingController();

  @override
  void initState() {
    // getCategories();
    // getCategoriesFromFirebase();
    super.initState();
  }

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

          return Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //   leading: CircleAvatar(),
            //   // leading: IconButton(
            //   //   icon: SvgPicture.asset('assets/icons/back.svg', color: kTextColor),
            //   //   onPressed: () => Navigator.pop(context),
            //   // ),
            //   // actions: <Widget>[
            //   //   IconButton(
            //   //     icon: SvgPicture.asset("assets/icons/search.svg"),
            //   //     onPressed: () {},
            //   //   ),
            //   //   IconButton(
            //   //     icon: SvgPicture.asset("assets/icons/cart.svg"),
            //   //     onPressed: () {},
            //   //   ),
            //   //   SizedBox(width: kDefaultPaddin / 2)
            //   // ],
            // ),
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
                            SizedBox(
                              height: 10,
                              width: 30,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'WELCOME BACK MOE !',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),

                                  CircleAvatar(
                                    backgroundColor: Colors.brown,
                                  ),

                                  // TextButton(
                                  //     onPressed: () {
                                  //       _showAddCollectionDialog(context);
                                  //     },
                                  //     child: Text("Add "))
                                ],
                              ),
                            ),
                            SizedBox(width: 25),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Categories(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AddProductButton(streamController.stream),
                          DeleteCategoryButton(streamController.stream),
                          AddCategoryButton(),
                        ],
                      ),
                      SizedBox(height: 12),
                      ItemCardDataAdmin(streamController.stream),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
