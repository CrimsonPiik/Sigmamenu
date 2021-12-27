import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/GeneralFunction/constaints.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/screens/home/components/dropDown.dart';
import 'package:sigmamenu/style/AssetsManager.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';
import '../../../style/Style.dart';

class ItemCardSquares extends StatefulWidget {
  final Product product;
  ItemCardSquares({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ItemCardSquares> createState() => _ItemCardSquaresState();
}

class _ItemCardSquaresState extends State<ItemCardSquares> {
  bool _menu = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 9,
            offset: Offset(1, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () => {_animationDialog(context)},
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    child: Container(
                      height: Responsive.isDesktop(context)
                          ? 155
                          : Responsive.isMobile(context)
                              ? 145
                              : Responsive.isMiniMobile(context)
                                  ? 130
                                  : 140,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: CommonUI.cachedImage(
                          widget.product.image, ImageAssets.foodplaceholder,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(14),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                              height: Responsive.isDesktop(context) ? 10 : 6),
                          SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: CommonUI.text(
                                context: context,
                                text: ProjectLanguage.isLTR()
                                    ? widget.product.nameEn
                                    : widget.product.nameAr,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: FontStyle.normal(
                                    context: context,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: Responsive.isDesktop(context) ? 10 : 6),
                          SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonUI.text(
                                      context: context,
                                      text: 'JOD ',
                                      textAlign: TextAlign.center,
                                      style: FontStyle.normal(
                                          context: context,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  CommonUI.text(
                                      context: context,
                                      text: widget.product.price.toString(),
                                      textAlign: TextAlign.center,
                                      style: FontStyle.normal(
                                          context: context,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red)),
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
            ),
          ),
        ],
      ),
    );
  }

  bool _fromTop = false;
  _animationDialog(context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Product Animation",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Dismissible(
          direction: DismissDirection.down,
          onDismissed: (_) {
            _menu = false;
            Navigator.pop(context);
          },
          key: Key("key"),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            // builder: builder)
            // child:
            return SafeArea(
              child: SizedBox.expand(
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  width: Responsive.isDesktop(context)
                                      ? Responsive.width(context) / 2
                                      : Responsive.width(context),
                                  padding: EdgeInsets.only(
                                    left: kDefaultPaddin * 1.1,
                                    right: kDefaultPaddin * 1.1,
                                    bottom: kDefaultPaddin * 1.1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 140,
                                              height: 170,
                                              padding: EdgeInsets.only(
                                                top: kDefaultPaddin * 1.3,
                                              ),
                                              child: CommonUI.cachedImage(
                                                  widget.product.image,
                                                  ImageAssets.foodplaceholder,
                                                  fit: BoxFit.cover)),
                                          SizedBox(width: 20),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: kDefaultPaddin * 1.8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:
                                                      Responsive.isMiniMobile(
                                                              context)
                                                          ? 100
                                                          : 140,
                                                  child: Text(
                                                    ProjectLanguage.isLTR()
                                                        ? widget.product.nameEn
                                                        : widget.product.nameAr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: Responsive
                                                                  .isMiniMobile(
                                                                      context)
                                                              ? 16
                                                              : 19,
                                                        ),
                                                    maxLines: 3,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                //       CommonUI.text(
                                                //           context: context,
                                                //           text: ProjectLanguage
                                                //                   .isLTR()
                                                //               ? widget
                                                //                   .product.nameEn
                                                //               : widget
                                                //                   .product.nameAr,
                                                //           textAlign:
                                                //               TextAlign.start,
                                                //           style: FontStyle.subTitle(
                                                //               context: context,
                                                //               fontWeight:
                                                //                   FontWeight.w600,
                                                //               color:
                                                //                   Colors.black)),
                                                // ),
                                                SizedBox(height: 6),
                                                Container(
                                                  width: 155,
                                                  child: CommonUI.text(
                                                      context: context,
                                                      text: ProjectLanguage
                                                              .isLTR()
                                                          ? widget.product
                                                              .descriptionEn
                                                          : widget.product
                                                              .descriptionAr,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: FontStyle.smaller(
                                                          context: context,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(height: 25),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Center(
                                          child: CommonUI.text(
                                              context: context,
                                              text:
                                                  "${widget.product.price} JOD",
                                              textAlign: TextAlign.center,
                                              style: FontStyle.title(
                                                  context: context,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0),
                                              child: Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                  height: 1,
                                                  width: 250,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CommonUI.text(
                                                      context: context,
                                                      text: 'Size',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FontStyle.normal(
                                                          context: context,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _menu = !_menu;
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 5),
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .orange[300],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          height: 25,
                                                          // width: 140,
                                                          child: CommonUI.text(
                                                              context: context,
                                                              text:
                                                                  'Grande 16 fl oz',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FontStyle.normal(
                                                                  context:
                                                                      context,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                        Container(
                                                          height: 25,
                                                          child: Icon(Icons
                                                              .arrow_forward_ios_outlined),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            _menu
                                                ? Column(
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                            height: 1,
                                                            width: 250),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            CommonUI.text(
                                                                context:
                                                                    context,
                                                                text:
                                                                    'Venti® 20 fl. oz',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FontStyle.small(
                                                                    context:
                                                                        context,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8))),
                                                            CommonUI.text(
                                                                context:
                                                                    context,
                                                                text:
                                                                    '5.24 JOD',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FontStyle.small(
                                                                    context:
                                                                        context,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8))),
                                                          ],
                                                        ),
                                                      ),
                                                      ////////////////////////////////////
                                                      Center(
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                            height: 1,
                                                            width: 250),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            CommonUI.text(
                                                                context:
                                                                    context,
                                                                text:
                                                                    'Grande 16 fl. oz',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FontStyle.small(
                                                                    context:
                                                                        context,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8))),
                                                            CommonUI.text(
                                                                context:
                                                                    context,
                                                                text:
                                                                    '3.89 JOD',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FontStyle.small(
                                                                    context:
                                                                        context,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8))),
                                                          ],
                                                        ),
                                                      ),
                                                      /////////////////////////////////////
                                                      Center(
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                            height: 1,
                                                            width: 250),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            CommonUI.text(
                                                                context:
                                                                    context,
                                                                text:
                                                                    'Tall 12 fl. oz',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FontStyle.small(
                                                                    context:
                                                                        context,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8))),
                                                            CommonUI.text(
                                                                context:
                                                                    context,
                                                                text:
                                                                    '2.99 JOD',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FontStyle.small(
                                                                    context:
                                                                        context,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8))),
                                                          ],
                                                        ),
                                                      ),
                                                      ///////////////////////////////////
                                                      Center(
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                            height: 1,
                                                            width: 250),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            CommonUI.text(
                                                                context:
                                                                    context,
                                                                text:
                                                                    'Short 8 fl. oz',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FontStyle.small(
                                                                    context:
                                                                        context,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8))),
                                                            CommonUI.text(
                                                                context:
                                                                    context,
                                                                text:
                                                                    '1.90 JOD',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FontStyle.small(
                                                                    context:
                                                                        context,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8))),
                                                          ],
                                                        ),
                                                      ),
                                                      ///////////////////////////////
                                                    ],
                                                  )
                                                : Container(),
                                            Center(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                  height: 1,
                                                  width:
                                                      double.maxFinite - 20.0),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CommonUI.text(
                                                      context: context,
                                                      text: 'Add-ins',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FontStyle.normal(
                                                          context: context,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  CommonUI.text(
                                                      context: context,
                                                      text: 'Regular Water',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FontStyle.normal(
                                                          context: context,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                  height: 1,
                                                  width:
                                                      double.maxFinite - 20.0),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CommonUI.text(
                                                      context: context,
                                                      text: 'Flavors',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FontStyle.normal(
                                                          context: context,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  CommonUI.text(
                                                      context: context,
                                                      text: 'Vanilla',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FontStyle.normal(
                                                          context: context,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                  height: 1,
                                                  width:
                                                      double.maxFinite - 20.0),
                                            ),
                                            SizedBox(height: 50),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          height: 4,
                          width: 50.0,
                        ),
                      ),
                      // Positioned(
                      //     top: -30,
                      //     child: Center(
                      //       child: CircleAvatar(
                      //         backgroundColor: Colors.grey,
                      //         radius: 30,
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             Navigator.of(context).pop();
                      //           },
                      //           child: Icon(
                      //             Icons.keyboard_arrow_down_sharp,
                      //             color: Colors.white,
                      //             size: 35,
                      //           ),
                      //         ),
                      //       ),
                      //     )),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0.25))
                  .animate(anim1),
          child: child,
        );
      },
    );
  }
}
