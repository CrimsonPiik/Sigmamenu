import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/widgets/productsItem.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/style/ScreenUtil.dart';

class ItemCardDataAdmin extends StatefulWidget {
  final Stream<int> stream;
  ItemCardDataAdmin(this.stream);

  @override
  _ItemCardDataState createState() => _ItemCardDataState();
}

class _ItemCardDataState extends State<ItemCardDataAdmin> {
  String category = 'drinks';

  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      mySetState(index);
    });
  }

  void mySetState(int index) {
    List categoryMenu = [
      'drinks',
      'maincourses',
      'appetizers',
      'desserts',
      'salads',
      'brunch'
    ];
    setState(() {
      category = categoryMenu[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(category)
            // .where('isPublished', isEqualTo: true)
            // .where('category',.....)
            .snapshots(),
        // .asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);
          List<Product> products = [];

          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            products.add(Product.fromMap(item.data() as Map<String, dynamic>));
          }

          print("Admin Side : " + products.toString());
          return Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 4)
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
                      ProductsItem(products[index]),
                )),
            // ),
            // ],
          );
        });
  }
}
