import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/home/components/item_card.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/style/ScreenUtil.dart';

class ItemCardData extends StatefulWidget {
  final Stream<int> stream;
  ItemCardData(this.stream);

  @override
  _ItemCardDataState createState() => _ItemCardDataState();
}

class _ItemCardDataState extends State<ItemCardData> {
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

          print(productsList.toString());
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
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
          );
        });
  }
}
