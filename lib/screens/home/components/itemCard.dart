import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/style/AssetsManager.dart';
import 'package:shop_app/style/CommonUI.dart';
import '../../../style/Style.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final bool isBordered;
  final bool isWithFavorite;
  final bool isFavoriteScreen;
  final Color? color;
  const ItemCard({
    Key? key,
    required this.product,
    required this.isBordered,
    this.color,
    this.isWithFavorite = false,
    this.isFavoriteScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double cardHeight = 200; //300
    final double cardWidth = 130;
    return Container(
      decoration: BoxDecoration(
        // border: isBordered ? Border.all(color: Style.beigeBrown) : null,
        // borderRadius: BorderRadius.all(Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            spreadRadius: isBordered ? 2 : 1,
            blurRadius: isBordered ? 9 : 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    product: product,
                  ),
                ),
              ),
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isBordered
                      ? ClipRRect(
                          // borderRadius:
                          //     BorderRadius.vertical(top: Radius.circular(28)),
                          child: Container(
                            height: cardHeight * 0.7,
                            width: double.maxFinite,
                            child: CommonUI.cachedImage(
                                product.image, ImageAssets.placeholder,
                                fit: BoxFit.cover),
                          ),
                        )
                      : Expanded(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth: cardWidth,
                                  maxHeight: cardHeight * 0.5),
                              // child: ClipRRect(
                              //   borderRadius: const BorderRadius.vertical(
                              //       top: Radius.circular(28)),
                              child: CommonUI.cachedImage(
                                  product.image, ImageAssets.placeholder,
                                  fit: BoxFit.cover)),
                        ),
                  Expanded(
                    child: Container(
                      // height: isBordered ? cardHeight * 1.2 : null,
                      // width: isWithFavorite ? ScreenUtil.width(context) * 0.7 : null,
                      // decoration: BoxDecoration(
                      color:
                          color ?? Theme.of(context).cardColor, //Style.cream,
                      //   borderRadius: BorderRadius.vertical(
                      //     bottom: Radius.circular(28),
                      //   ),
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: isBordered ? double.maxFinite : cardWidth,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: SizedBox(
                                // height: 10,
                                child: CommonUI.text(
                                    context: context,
                                    text: product.nameEn,
                                    // RhinoLanguage.isLTR()
                                    //     ? product.nameEn
                                    //     : product.nameAr,
                                    textAlign: TextAlign.center,
                                    style: FontStyle.normal(
                                        context: context,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isBordered ? double.maxFinite : cardWidth,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: SizedBox(
                                // height: 10,
                                child: CommonUI.text(
                                    context: context,
                                    text: product.descriptionEn,
                                    textAlign: TextAlign.center,
                                    style: FontStyle.normal(
                                      context: context,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isBordered ? double.maxFinite : cardWidth,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: SizedBox(
                                // height: 10,
                                child: CommonUI.text(
                                    context: context,
                                    text: product.price.toString() + ' \$',
                                    // RhinoLanguage.isLTR()
                                    //     ? product.nameEn
                                    //     : product.nameAr,
                                    textAlign: TextAlign.center,
                                    style: FontStyle.normal(
                                      context: context,
                                    )),
                              ),
                            ),
                          ),
                          // SelectableText("JOD 5",
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         // color: product.isOnSale ? Colors.red : null,
                          //         // decoration: product.isOnSale
                          //         //     ? TextDecoration.lineThrough
                          //         //     : null,
                          //         )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
