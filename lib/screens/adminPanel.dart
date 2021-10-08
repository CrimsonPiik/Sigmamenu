import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/sidebar.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/widgets/productsItem.dart';
import 'package:shop_app/style/CommonUI.dart';

class AdminPanel extends StatelessWidget {
  final bool showDesktop;
  const AdminPanel([this.showDesktop = false]);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('drinks')
            .where('isPublished', isEqualTo: true)
            // .where('category',.....)
            .snapshots(),
            // .asBroadcastStream(onCancel: (sub) => sub.cancel()),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(context, snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading();
          List<Product> products = [];

          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            products.add(Product.fromMap(item.data() as Map<String, dynamic>));
          }
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
                        // height: topBarHeight,
                        child: Row(
                          children: [
                            this.showDesktop
                                ? SizedBox.shrink()
                                : IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                            Expanded(
                                child: Center(
                              child: Text(
                                'Admin Dashboard',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children:
                                products.map((e) => ProductsItem(e)).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
