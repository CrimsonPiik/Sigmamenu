// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sigmamenu/constaints.dart';
// import 'package:sigmamenu/models/product.dart';
// import 'package:sigmamenu/screens/adminPanel.dart';
// import 'package:sigmamenu/screens/home/components/itemCard.dart';
// import 'package:sigmamenu/style/CommonUI.dart';
// import 'package:sigmamenu/style/ScreenUtil.dart';

// class ItemCardData extends StatefulWidget {
//   final Stream<int> stream;
//   ItemCardData(this.stream);
//   @override
//   _ItemCardDataState createState() => _ItemCardDataState();
// }

// class _ItemCardDataState extends State<ItemCardData> {
//   String category = categoriesList.elementAt(0);

//   StreamController<List<DocumentSnapshot>> _streamController =
//       StreamController<List<DocumentSnapshot>>();
//   List<DocumentSnapshot> _products = [];

//   bool _isRequesting = false;
//   bool _isFinish = false;

//   void onChangeData(List<DocumentChange> docChanges) {
//     var isChange = false;
//     docChanges.forEach((productChange) {
//       if (productChange.type == DocumentChangeType.removed) {
//         _products.removeWhere((product) {
//           return productChange.doc.id == product.id;
//         });
//         isChange = true;
//       } else {
//         if (productChange.type == DocumentChangeType.modified) {
//           int indexWhere = _products.indexWhere((product) {
//             return productChange.doc.id == product.id;
//           });

//           if (indexWhere >= 0) {
//             _products[indexWhere] = productChange.doc;
//           }
//           isChange = true;
//         }
//       }
//     });

//     if (isChange) {
//       _streamController.add(_products);
//     }
//   }

//   void requestNextPage() async {
//     if (!_isRequesting && !_isFinish) {
//       QuerySnapshot querySnapshot;
//       _isRequesting = true;
//       if (_products.isEmpty) {
//         querySnapshot = await FirebaseFirestore.instance
//             .collection(category)
//             .where('weight', isGreaterThan: 0)
//             .orderBy('weight', descending: true)
//             .limit(4)
//             .get();
//       } else {
//         querySnapshot = await FirebaseFirestore.instance
//             .collection(category)
//             .where('weight', isGreaterThan: 0)
//             .orderBy('weight', descending: true)
//             .startAfterDocument(_products[_products.length - 1])
//             .limit(4)
//             .get();
//       }

//       if (querySnapshot != null) {
//         int oldSize = _products.length;
//         _products.addAll(querySnapshot.docs);
//         int newSize = _products.length;
//         if (oldSize != newSize) {
//           _streamController.add(_products);
//         } else {
//           _isFinish = true;
//         }
//       }
//       _isRequesting = false;
//     }
//   }

//   @override
//   void initState() {
//     widget.stream.listen((index) {
//       if (!mounted) return;
//       setState(() {
//         category = categoriesList.elementAt(index);
//         print(category);
//       });
//     });

//     /// This listening to Firebase
//     FirebaseFirestore.instance
//         .collection(category)
// //      .where('weight', isGreaterThan: 0)
// //      .orderBy('weight', descending: true)
//         .snapshots()
//         .listen((data) => onChangeData(data.docChanges));

//     requestNextPage();

//     /// a listener to the index for categorries
//     /// so it update it with a new list of products

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _streamController.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener<ScrollNotification>(
//         onNotification: (ScrollNotification scrollInfo) {
//           if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
//             requestNextPage();
//           }
//           return true;
//         },
//         child: StreamBuilder<List<DocumentSnapshot>>(
//           stream: _streamController.stream,
//           builder: (BuildContext context,
//               AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
//             if (snapshot.hasError) {
//               return CommonUI.error(snapshot.error.toString());
//             }
//             if (snapshot.connectionState == ConnectionState.waiting)
//               return CommonUI.loading(context);
//             List<Product> _productsList = [];

//             List<DocumentSnapshot> shots = snapshot.data!;

//             for (var item in shots) {
//               _productsList
//                   .add(Product.fromMap(item.data() as Map<String, dynamic>));
//             }

//             return Expanded(
//                 child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//                     child: GridView.builder(
//                       itemCount: snapshot.data!.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: Responsive.isDesktop(context)
//                             ? 7
//                             : Responsive.isTablet(context)
//                                 ? 4
//                                 : 2,
//                         mainAxisSpacing: kDefaultPaddin,
//                         crossAxisSpacing: kDefaultPaddin,
//                         childAspectRatio: 0.75,
//                       ),
//                       itemBuilder: (context, index) => ItemCard(
//                         product: _productsList[index],
//                         isBordered: true,
//                       ),
//                     )));
//           },
//         ));
//   }
// }

// WORKS WITHOUT CATEGORIES

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/home/components/ItemCardRectangle.dart';
import 'package:sigmamenu/screens/home/components/ItemCardSquares.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Session.dart';

class ItemCardData extends StatefulWidget {
  final Stream<int> stream;
  ItemCardData(this.stream);

  @override
  _ItemCardDataState createState() => _ItemCardDataState();
}

class _ItemCardDataState extends State<ItemCardData> {
  String category = categoriesList.elementAt(0);
  bool _enabled = true;

  @override
  void initState() {
    widget.stream.listen((index) {
      if (!mounted) return;
      setState(() {
        category = categoriesList.elementAt(index);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(category)
            .where('weight', isGreaterThan: 0)
            .orderBy('weight', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            _enabled = true;
          }
          // return
          // LoadingListPage();
          // CommonUI.loading(context);

          List<Product> productsList = [];
          List<DocumentSnapshot> shots = snapshot.data!.docs;

          for (var item in shots) {
            productsList
                .add(Product.fromMap(item.data() as Map<String, dynamic>));
          }

          print("Client Side : " + productsList.toString());

          // return
          return Session.isList
              ? Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    // child: Shimmer.fromColors(
                    //   baseColor: Colors.grey.withOpacity(0.7),
                    //   highlightColor: Colors.grey.withOpacity(0.3),
                    //   enabled: _enabled,
                      child: GridView.builder(
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
                        itemBuilder: (context, index) => ItemCardSquares(
                          product: productsList[index],
                          isBordered: true,
                        ),
                      ),
                    ),
                  // ),
                )
              : Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    // child: Shimmer.fromColors(
                    //   baseColor: Colors.grey.withOpacity(0.7),
                    //   highlightColor: Colors.grey.withOpacity(0.3),
                    //   enabled: _enabled,
                      child: GridView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: productsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: Responsive.isDesktop(context)
                                ? MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 3.5)
                                : MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 4.5)
                            //       //               // ScreenUtil.isDesktop(context)
                            //       //               // ? 7
                            //       //               // : ScreenUtil.isTablet(context)
                            //       //               // ? 4
                            //       //               //  : 2,
                            //       //               // mainAxisSpacing: kDefaultPaddin,
                            //       //               // crossAxisSpacing: kDefaultPaddin,
                            // childAspectRatio: 130.0,
                            ),
                        itemBuilder: (context, index) => ItemCardRectangle(
                          product: productsList[index],
                          isBordered: true,
                        ),
                      ),
                    ),
                  // ),
                );
        });
  }
}
