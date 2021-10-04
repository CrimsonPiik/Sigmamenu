import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/details/components/body.dart';
import 'package:shop_app/style/CommonUI.dart';

import '../../../constants.dart';
import 'item_card.dart';

// We need satefull widget for our categories

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["Drinks", "Food", "Appetizers", "Deserts"];
  // By default our first item will be selected
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('salads')
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
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
  
              // ItemCard(product: productsList[selectedIndex], isBordered: true);
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    categories[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          selectedIndex == index ? kTextColor : kTextLightColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: kDefaultPaddin / 4), //top padding 5
                    height: 2,
                    width: 40,
                    // width: categories[selectedIndex].length * 6.6,
                    color: selectedIndex == index
                        ? Colors.black
                        : Colors.transparent,
                  )
                ],
              ),
            ),
          );
        });
  }
}
