import 'package:flutter/material.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/models/product.dart';

class ProductDescription extends StatelessWidget {
  final Product product;

  const ProductDescription({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Text(product.nameEn),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: "Price\n"),
                                      TextSpan(
                                        text: "\$${product.price}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                // Row(
                                //   children: <Widget>[
                                //     ColorDot(
                                //       color: Color(0xFF356C95),
                                //       isSelected: true,
                                //     ),
                                //     ColorDot(color: Color(0xFFF8C078)),
                                //     ColorDot(color: Color(0xFFA29B9B)),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(color: kTextColor),
                                children: [
                                  TextSpan(text: "Description\n"),
                                  TextSpan(
                                    text: "${product.descriptionEn}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPaddin / 2),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.descriptionEn,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(height: kDefaultPaddin),
                      Row(
                        children: <Widget>[
                          //   RichText(
                          //     text: TextSpan(
                          //       children: [
                          //         TextSpan(text: "Price\n"),
                          //         TextSpan(
                          //           text: "\$${product.price}",
                          //           style: Theme.of(context).textTheme.headline4!.copyWith(
                          //               color: Colors.black, fontWeight: FontWeight.bold),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          SizedBox(width: kDefaultPaddin),

                          Expanded(
                            child: Hero(
                              tag: "${product.id}",
                              child: Image.network(
                                product.image,
                                width: 300,
                                height: 200,
                                // fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
