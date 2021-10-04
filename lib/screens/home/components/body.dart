import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/style/ScreenUtil.dart';

import 'categorries.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('drinks')
            .where('isPublished', isEqualTo: true)
            // .where('category',.....)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(context, snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading();
          List<Product> productsList = [];

          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            productsList
                .add(Product.fromMap(item.data() as Map<String, dynamic>));
          }

          print("PPP " + productsList.toString());
          // product =
          // Product.fromMap(snapshot.data!.data() as Map<String, dynamic>);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: Center(
                  child: Text(
                    "Coffee Shop",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Categories(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: GridView.builder(
                      itemCount: productsList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ScreenUtil.isDesktop(context)
                            ? 7
                            : ScreenUtil.isTablet(context)
                                ? 4
                                : 2,
                        mainAxisSpacing: kDefaultPaddin,
                        crossAxisSpacing: kDefaultPaddin,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) => ItemCard(
                            product: productsList[index],
                            isBordered: true,
                            // product: products[index], isBordered: true,
                            // product: , isBordered: true,

                            // press: () => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => DetailsScreen(
                            //         product: products[index],
                            //       ),
                            //     )),
                          )),
                ),
              ),
            ],
          );
        });
  }

  // Widget ItemCard(Product product,bool isBordered) {

  // }
}
