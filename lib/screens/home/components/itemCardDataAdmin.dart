import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/widgets/productsItemAdmin.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

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

          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            products.add(Product.fromMap(item.data() as Map<String, dynamic>));
          }

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
                              ? 8.2
                              : Responsive.isMobile(context)
                                  ? 2.30
                                  : 1.75),
                  itemBuilder: (context, index) => Container(
                      // padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ProductsItemAdmin(products[index])),
                )),
          );
        });
  }
}
