import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/GeneralFunction/constaints.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/screens/customerScreen.dart';
import 'package:sigmamenu/screens/widgets/ItemCardRectangle.dart';
import 'package:sigmamenu/screens/widgets/shimmerForCustomerScreen.dart';
import 'package:sigmamenu/screens/widgets/shimmerForPaginatedProducts.dart';
import 'package:sigmamenu/screens/widgets/supercategories.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class ItemCardData extends StatefulWidget {
  final Stream<int> stream;
  ItemCardData(this.stream);
  @override
  _ItemCardDataState createState() => _ItemCardDataState();
}

class _ItemCardDataState extends State<ItemCardData> {
  String category = categoriesList.elementAt(0);

  StreamController<List<DocumentSnapshot>> _streamController =
      StreamController<List<DocumentSnapshot>>();
  List<DocumentSnapshot> _products = [];
  List<Product> _productsList = [];
  bool isLoading = false;
  bool _isRequesting = false;
  bool _isFinish = false;

  void onChangeData(List<DocumentChange> docChanges) {
    var isChange = false;
    docChanges.forEach((productChange) {
      if (productChange.type == DocumentChangeType.removed) {
        _products.removeWhere((product) {
          return productChange.doc.id == product.id;
        });
        isChange = true;
      } else {
        if (productChange.type == DocumentChangeType.modified) {
          int indexWhere = _products.indexWhere((product) {
            return productChange.doc.id == product.id;
          });

          if (indexWhere >= 0) {
            _products[indexWhere] = productChange.doc;
          }
          isChange = true;
        }
      }
    });

    if (isChange) {
      _streamController.add(_products);
    }
  }

  void requestNextPage(String category) async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    if (!_isRequesting && !_isFinish) {
      QuerySnapshot querySnapshot;
      _isRequesting = true;
      if (_products.isEmpty) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('products')
            .where('isPublished', isEqualTo: true)
            .where('category', isEqualTo: category)
            .where('weight', isGreaterThan: 0)
            .orderBy('weight', descending: true)
            .limit(3)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('products')
            .where('isPublished', isEqualTo: true)
            .where('category', isEqualTo: category)
            .where('weight', isGreaterThan: 0)
            .orderBy('weight', descending: true)
            .startAfterDocument(_products[_products.length - 1])
            .limit(3)
            .get();
      }

      if (querySnapshot.docs.isNotEmpty) {
        int oldSize = _products.length;
        _products.addAll(querySnapshot.docs);
        int newSize = _products.length;
        if (oldSize != newSize) {
          _streamController.add(_products);
          setState(() {
            isLoading = false;
          });
        } else {
          _isFinish = true;
        }
      }
      _isRequesting = false;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    print('# category :  ' + category);
    widget.stream.listen((index) {
      if (!mounted) return;
      setState(() {
        category = categoriesList.elementAt(index);
        print('# category :  ' + category);
        print('# Super Selected index :  ' + selectedIndexsuper.toString());
        print('# Selected index :  ' + selectedIndex.toString());
        _products = [];
        // _productsList = [];
        requestNextPage(category);
      });
    });

    /// This listening to Firebase
    FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .listen((data) => onChangeData(data.docChanges));

    requestNextPage(category);

    /// a listener to the index for categorries
    /// so it update it with a new list of products

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
            requestNextPage(category);
          }
          return true;
        },
        child: StreamBuilder<List<DocumentSnapshot>>(
          stream: _streamController.stream,
          builder: (BuildContext context,
              AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
            if (snapshot.hasError) {
              return CommonUI.error(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting)
              return ShimmerForCustomerScreen();

            List<DocumentSnapshot> shots = snapshot.data!;
            _productsList = [];
            
            for (var item in shots) {
              _productsList
                  .add(Product.fromMap(item.data() as Map<String, dynamic>));
            }
            return Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: _products.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: Responsive.isDesktop(
                                            context)
                                        ? 8.2
                                        : Responsive.isMobile(context)
                                            ? 2.30
                                            : Responsive.isMiniMobile(context)
                                                ? 2.0
                                                : 4.0),
                            itemBuilder: (context, index) => ItemCardRectangle(
                              product: _productsList[index],
                            ),
                          )
                        : Container()),
                isLoading ? ShimmerForPaginatedProducts() : Container(),
                // Container(
                //     width: MediaQuery.of(context).size.width,
                //     padding: EdgeInsets.all(5),
                //     color: Colors.yellowAccent,
                //     child: Text(
                //       'Loading',
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   )
              ],
            );
          },
        ));
  }
}

// WORKS WITHOUT PAGINATION

// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sigmamenu/GeneralFunction/constaints.dart';
// import 'package:sigmamenu/models/product.dart';
// import 'package:sigmamenu/screens/customerScreen.dart';
// import 'package:sigmamenu/screens/widgets/ItemCardRectangle.dart';
// import 'package:sigmamenu/screens/widgets/shimmerForCustomerScreen.dart';
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
//   @override
//   void initState() {
//     widget.stream.listen((index) {
//       if (!mounted) return;
//       setState(() {
//         category = categoriesList.elementAt(index);
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('products') //TODO
//             .where('category', isEqualTo: category)
//             .where('isPublished', isEqualTo: true)
//             .where('weight', isGreaterThan: 0)
//             .orderBy('weight', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return CommonUI.error(snapshot.error.toString());
//           }
//           if (snapshot.connectionState == ConnectionState.waiting)
//             return ShimmerForCustomerScreen();

//           List<Product> productsList = [];
//           List<DocumentSnapshot> shots = snapshot.data!.docs;

//           for (var item in shots) {
//             productsList
//                 .add(Product.fromMap(item.data() as Map<String, dynamic>));
//           }

//           print("Client Side : " + productsList.toString());

//           return Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
//             child: GridView.builder(
//               physics: ClampingScrollPhysics(),
//               primary: false,
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               itemCount: productsList.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   childAspectRatio: Responsive.isDesktop(context)
//                       ? 8.2
//                       : Responsive.isMobile(context)
//                           ? 2.30
//                           : Responsive.isMiniMobile(context)
//                               ? 2.0
//                               : 4.0),
//               itemBuilder: (context, index) => ItemCardRectangle(
//                 product: productsList[index],
//               ),
//             ),
//           );
//         });
//   }
// }
