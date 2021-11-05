import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/adminPanel.dart';
import 'package:shop_app/screens/home/components/itemCard.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/style/ScreenUtil.dart';

// StreamController<List<DocumentSnapshot>> _controller =
//     StreamController<List<DocumentSnapshot>>.broadcast();

class ItemCardData extends StatefulWidget {
  final Stream<int> stream;
  ItemCardData(this.stream);

  @override
  _ItemCardDataState createState() => _ItemCardDataState();
}

class _ItemCardDataState extends State<ItemCardData> {
  String category = categoriesList.elementAt(0);
  @override
  void initState() {
    widget.stream.listen((index) {
      // mySetState(index);
      if (!mounted) return;
      setState(() {
        category = categoriesList.elementAt(index);
      });
    });
    super.initState();
  }
  // List<DocumentSnapshot> products = [];
  // bool isLoading = false;
  // bool hasMore = true;
  // int documentLimit = 6;
  // ScrollController _scrollController = ScrollController();
  // DocumentSnapshot? lastDocument;

  // Stream<List<DocumentSnapshot>> get _streamController => _controller.stream;

  // getProducts() async {
  //   // category = categoriesList.elementAt(index);
  //   if (!hasMore) {
  //     print('No More Products');
  //     return;
  //   }
  //   if (isLoading) {
  //     return;
  //   }
  //   setState(() {
  //     isLoading = true;
  //   });
  //   QuerySnapshot querySnapshot;

  //   if (lastDocument == null) {
  //     querySnapshot = await FirebaseFirestore.instance
  //         .collection(category)
  //         .where('weight', isGreaterThan: 0)
  //         .orderBy('weight', descending: true)
  //         .limit(documentLimit)
  //         .get();
  //   } else {
  //     querySnapshot = await FirebaseFirestore.instance
  //         .collection(category)
  //         .where('weight', isGreaterThan: 0)
  //         .orderBy('weight', descending: true)
  //         .startAfterDocument(lastDocument!)
  //         .limit(documentLimit)
  //         .get();
  //     print(1);
  //   }
  //   if (querySnapshot.docs.length < documentLimit) {
  //     hasMore = false;
  //   }

  //   lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

  //   products.addAll(querySnapshot.docs);
  //   _controller.sink.add(products);

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // });
  //   _scrollController.addListener(() {
  //     double maxScroll = _scrollController.position.maxScrollExtent;
  //     double currentScroll = _scrollController.position.pixels;
  //     double delta = MediaQuery.of(context).size.height * 0.20;
  //     if (maxScroll - currentScroll <= delta) {
  //       getProducts();
  //     }
  //   });
  //   getProducts();

  //   super.initState();
  // }

  // void mySetState(int index) {}

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<List<DocumentSnapshot>>(
    return StreamBuilder<QuerySnapshot>(
        stream:
            // _streamController,

            FirebaseFirestore.instance
                .collection(category)
                .where('weight', isGreaterThan: 0)
                // .where('isPublished', isEqualTo: 1)
                .orderBy('weight', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);

          List<Product> productsList = [];
          // if (snapshot.hasData && snapshot.data!.length > 0) {
          // List<DocumentSnapshot> shots = snapshot.data!;
          List<DocumentSnapshot> shots = snapshot.data!.docs;

          for (var item in shots) {
            productsList
                .add(Product.fromMap(item.data() as Map<String, dynamic>));
          }

          print("Client Side : " + productsList.toString());

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                  // controller: _scrollController,
                  // itemCount: snapshot.data!.length,
                  itemCount: productsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isDesktop(context)
                        ? 7
                        : Responsive.isTablet(context)
                            ? 4
                            : 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                        product: productsList[index],
                        isBordered: true,
                      )),
            ),
            // ),
            // isLoading
            //     ? Container(
            //         width: MediaQuery.of(context).size.width,
            //         padding: EdgeInsets.all(5),
            //         color: Colors.yellowAccent,
            //         child: Text(
            //           'Loading',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       )
            //     : Container()
            // ],
          );
          // } else {
          // return CircularProgressIndicator();
        });
  }
}
/// 1 create a dart file containing the whole arrays into 1 array getting categoryies from Firebase
  /// 2 make it staful
  /// 3 inculde the file everywhere we need(the 3 files)
  /// 4 add Streambuilder once for bothe admin adnd user
  /// 5 conect my + category to add and delete categories
  ///
  // List categoryMenu = [
  //   'drinks',
  //   'maincourses',
  //   'appetizers',
  //   'desserts',
  //   'salads',
  //   'brunch'
  // ];
