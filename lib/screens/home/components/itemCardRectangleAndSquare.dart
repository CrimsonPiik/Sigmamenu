import 'package:flutter/material.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/screens/home/components/ItemCardRectangle.dart';
import 'package:sigmamenu/screens/home/components/ItemCardSquares.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import 'package:sigmamenu/style/Session.dart';

class ItemCardRectangleAndSquare extends StatefulWidget {
  final List<Product> productList;
  final ScrollController? controller;

  const ItemCardRectangleAndSquare({
    Key? key,
    required this.productList,
    this.controller,
  }) : super(key: key);

  @override
  _ItemCardRectangleAndSquareState createState() =>
      _ItemCardRectangleAndSquareState();
}

class _ItemCardRectangleAndSquareState
    extends State<ItemCardRectangleAndSquare> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = widget.productList;
    return Session.isList
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),            
              child: GridView.builder(
                itemCount: products.length,
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
                  product: products[index],
                ),
              ),
            ),
          )
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          
              child: GridView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 3.5)
                        : MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 4.5)),
                itemBuilder: (context, index) => ItemCardRectangle(
                  product: products[index],
                ),
              ),
            ),
          );
  }
}
