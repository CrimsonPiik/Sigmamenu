import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/adminPanel.dart';
import 'package:shop_app/screens/widgets/productsItemAdmin.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/style/ScreenUtil.dart';

class ItemCardDataAdmin extends StatefulWidget {
  final Stream<int> stream;
  ItemCardDataAdmin(this.stream);

  @override
  _ItemCardDataAdminState createState() => _ItemCardDataAdminState();
}

class _ItemCardDataAdminState extends State<ItemCardDataAdmin> {
  String category = categoriesList.elementAt(0);

  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      mySetState(index);
    });
  }

  void mySetState(int index) {
    if (!mounted) return;

    setState(() {
      category = categoriesList.elementAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(category)
            // .where('category', isEqualTo: category)
            .orderBy('weight', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);
          List<Product> products = [];
          // List<Product> sortedProductsByWeight = [];
          // List<int> productsWeight = [];
          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            products.add(Product.fromMap(item.data() as Map<String, dynamic>));
          }

          // for (int i = 0; i < products.length; i++) {
          //   productsWeight.add(products[i].weight);
          // }
          // productsWeight.sort();

          // for (int i = 0; i < products.length; i++) {
          //   for (int k = 0; k < products.length; k++) {
          //     if (products[i].weight == productsWeight[k]) {
          //       sortedProductsByWeight.add(products[i]);
          //       // sortedProductsByWeight.sort();
          //     }
          //   }
          // }
          // print("SORTEDPRODUCTSBYWEIGHT" + sortedProductsByWeight.toString());
          print("Admin Side : " + products.toString());
          // DateTime.now().millisecondsSinceEpoch.toString());
          return Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 3.5)
                          : MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 2.7)
                      //       //               // ScreenUtil.isDesktop(context)
                      //       //               // ? 7
                      //       //               // : ScreenUtil.isTablet(context)
                      //       //               // ? 4
                      //       //               //  : 2,
                      //       //               // mainAxisSpacing: kDefaultPaddin,
                      //       //               // crossAxisSpacing: kDefaultPaddin,
                      // childAspectRatio: 130.0,
                      ),
                  itemBuilder: (context, index) =>
                      //  TextButton.icon(
                      //                   onPressed: () {}, icon: Icon(Icons.add), label: Text('Add')),
                      ProductsItemAdmin(products[index]),
                )),
            // ),
            // ],
          );
        });
  }
}
