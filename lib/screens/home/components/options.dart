import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/models/product.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import '../../../style/Style.dart';

class Options extends StatefulWidget {
  final Product product;

  const Options({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  String _selectedItem = 'Grande 16 fl oz';

  bool _menu = false;
  @override
  Widget build(BuildContext context) {
    String _selectedPrice = "${widget.product.price} JOD";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey.withOpacity(0.5),
              ),
              height: 1,
              width: 250,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _menu = !_menu;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonUI.text(
                    context: context,
                    text: widget.product.options.keys.first.toString(),
                    textAlign: TextAlign.center,
                    style: FontStyle.normal(
                        context: context,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Row(
                  children: [
                    CommonUI.text(
                        context: context,
                        text: _selectedItem,
                        textAlign: TextAlign.center,
                        style: FontStyle.normal(
                            context: context,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[300])),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                      color: Colors.orange[300],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        _menu
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedItem = 'Venti® 20 fl. oz';
                          _selectedPrice = '5.24 JOD';
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonUI.text(
                              context: context,
                              text: 'Venti® 20 fl. oz',
                              textAlign: TextAlign.center,
                              style: FontStyle.small(
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8))),
                          CommonUI.text(
                              context: context,
                              text: '5.24 JOD',
                              textAlign: TextAlign.center,
                              style: FontStyle.small(
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8))),
                        ],
                      ),
                    ),
                  ),
                  ////////////////////////////////////
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        height: 1,
                        width: 250),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedItem = 'Grande 16 fl. oz';
                          _selectedPrice = '3.89 JOD';
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonUI.text(
                              context: context,
                              text: 'Grande 16 fl. oz',
                              textAlign: TextAlign.center,
                              style: FontStyle.small(
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8))),
                          CommonUI.text(
                              context: context,
                              text: '3.89 JOD',
                              textAlign: TextAlign.center,
                              style: FontStyle.small(
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8))),
                        ],
                      ),
                    ),
                  ),
                  /////////////////////////////////////
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        height: 1,
                        width: 250),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedItem = 'Tall 12 fl. oz';
                          _selectedPrice = ' 2.99 JOD';
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonUI.text(
                              context: context,
                              text: 'Tall 12 fl. oz',
                              textAlign: TextAlign.center,
                              style: FontStyle.small(
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8))),
                          CommonUI.text(
                              context: context,
                              text: '2.99 JOD',
                              textAlign: TextAlign.center,
                              style: FontStyle.small(
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8))),
                        ],
                      ),
                    ),
                  ),
                  ///////////////////////////////////
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        height: 1,
                        width: 250),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedItem = 'Short 8 fl. oz';
                          _selectedPrice = '1.90 JOD';
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonUI.text(
                              context: context,
                              text: 'Short 8 fl. oz',
                              textAlign: TextAlign.center,
                              style: FontStyle.small(
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8))),
                          CommonUI.text(
                              context: context,
                              text: '1.90 JOD',
                              textAlign: TextAlign.center,
                              style: FontStyle.small(
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8))),
                        ],
                      ),
                    ),
                  ),
                  ///////////////////////////////
                ],
              )
            : Container(),
        // Center(
        //   child: Container(
        //       decoration:
        //           BoxDecoration(
        //         borderRadius:
        //             BorderRadius
        //                 .circular(
        //                     24),
        //         color: Colors
        //             .grey
        //             .withOpacity(
        //                 0.5),
        //       ),
        //       height: 1,
        //       width: double
        //               .maxFinite -
        //           20.0),
        // ),
        // Padding(
        //   padding:
        //       const EdgeInsets
        //           .all(8.0),
        //   child:
        //       GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         _menu1 =
        //             !_menu1;
        //       });
        //     },
        //     child: Row(
        //       mainAxisAlignment:
        //           MainAxisAlignment
        //               .spaceBetween,
        //       children: [
        //         CommonUI.text(
        //             context:
        //                 context,
        //             text:
        //                 'Add-ins',
        //             textAlign:
        //                 TextAlign
        //                     .center,
        //             style: FontStyle.normal(
        //                 context:
        //                     context,
        //                 fontWeight:
        //                     FontWeight
        //                         .bold,
        //                 color: Colors
        //                     .black)),
        //         Row(
        //           children: [
        //             CommonUI.text(
        //                 context:
        //                     context,
        //                 text:
        //                     _selectedItem1,
        //                 textAlign:
        //                     TextAlign
        //                         .center,
        //                 style: FontStyle.normal(
        //                     context:
        //                         context,
        //                     fontWeight:
        //                         FontWeight.bold,
        //                     color: Colors.orange[300])),
        //             SizedBox(
        //                 width:
        //                     5),
        //             Icon(
        //               Icons
        //                   .arrow_forward_ios_outlined,
        //               size: 15,
        //               color: Colors
        //                       .orange[
        //                   300],
        //             )
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // _menu1
        //     ? Column(
        //         children: [
        //           Padding(
        //             padding:
        //                 const EdgeInsets.all(
        //                     8.0),
        //             child:
        //                 GestureDetector(
        //               onTap:
        //                   () {
        //                 setState(
        //                     () {
        //                   _selectedItem1 =
        //                       'Soda';
        //                 });
        //               },
        //               child:
        //                   Row(
        //                 mainAxisAlignment:
        //                     MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   CommonUI.text(
        //                       context: context,
        //                       text: 'Soda',
        //                       textAlign: TextAlign.center,
        //                       style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                   CommonUI.text(
        //                       context: context,
        //                       text: '1.24 JOD',
        //                       textAlign: TextAlign.center,
        //                       style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                 ],
        //               ),
        //             ),
        //           ),
        //           ////////////////////////////////////
        //           Center(
        //             child: Container(
        //                 decoration: BoxDecoration(
        //                   borderRadius:
        //                       BorderRadius.circular(24),
        //                   color: Colors
        //                       .grey
        //                       .withOpacity(0.5),
        //                 ),
        //                 height: 1,
        //                 width: 250),
        //           ),
        //           Padding(
        //             padding:
        //                 const EdgeInsets.all(
        //                     8.0),
        //             child:
        //                 GestureDetector(
        //               onTap:
        //                   () {
        //                 setState(
        //                     () {
        //                   _selectedItem1 =
        //                       'Fries';
        //                 });
        //               },
        //               child:
        //                   Row(
        //                 mainAxisAlignment:
        //                     MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   CommonUI.text(
        //                       context: context,
        //                       text: 'Fries',
        //                       textAlign: TextAlign.center,
        //                       style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                   CommonUI.text(
        //                       context: context,
        //                       text: '1.50 JOD',
        //                       textAlign: TextAlign.center,
        //                       style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                 ],
        //               ),
        //             ),
        //           ),
        //           Center(
        //             child: Container(
        //                 decoration: BoxDecoration(
        //                   borderRadius:
        //                       BorderRadius.circular(24),
        //                   color: Colors
        //                       .grey
        //                       .withOpacity(0.5),
        //                 ),
        //                 height: 1,
        //                 width: 250),
        //           ),
        //           Padding(
        //             padding:
        //                 const EdgeInsets.all(
        //                     8.0),
        //             child:
        //                 GestureDetector(
        //               onTap:
        //                   () {
        //                 setState(
        //                     () {
        //                   _selectedItem1 =
        //                       'Regular Water';
        //                 });
        //               },
        //               child:
        //                   Row(
        //                 mainAxisAlignment:
        //                     MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   CommonUI.text(
        //                       context: context,
        //                       text: 'Regular Water',
        //                       textAlign: TextAlign.center,
        //                       style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                   CommonUI.text(
        //                       context: context,
        //                       text: '0.50 JOD',
        //                       textAlign: TextAlign.center,
        //                       style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                 ],
        //               ),
        //             ),
        //           )
        //         ],
        //       )
        //     : Container(),
        // Center(
        //   child: Container(
        //       decoration:
        //           BoxDecoration(
        //         borderRadius:
        //             BorderRadius
        //                 .circular(
        //                     24),
        //         color: Colors
        //             .grey
        //             .withOpacity(
        //                 0.5),
        //       ),
        //       height: 1,
        //       width: double
        //               .maxFinite -
        //           20.0),
        // ),
        // Padding(
        //   padding:
        //       const EdgeInsets
        //           .all(8.0),
        //   child:
        //       GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         _menu2 =
        //             !_menu2;
        //         // _scroll = !_scroll;
        //       });
        //     },
        //     child: Row(
        //       mainAxisAlignment:
        //           MainAxisAlignment
        //               .spaceBetween,
        //       children: [
        //         CommonUI.text(
        //             context:
        //                 context,
        //             text:
        //                 'Flavors',
        //             textAlign:
        //                 TextAlign
        //                     .center,
        //             style: FontStyle.normal(
        //                 context:
        //                     context,
        //                 fontWeight:
        //                     FontWeight
        //                         .bold,
        //                 color: Colors
        //                     .black)),
        //         Row(
        //           children: [
        //             CommonUI.text(
        //                 context:
        //                     context,
        //                 text:
        //                     _selectedItem2,
        //                 textAlign:
        //                     TextAlign
        //                         .center,
        //                 style: FontStyle.normal(
        //                     context:
        //                         context,
        //                     fontWeight:
        //                         FontWeight.bold,
        //                     color: Colors.orange[300])),
        //             SizedBox(
        //                 width:
        //                     5),
        //             Icon(
        //               Icons
        //                   .arrow_forward_ios_outlined,
        //               size: 15,
        //               color: Colors
        //                       .orange[
        //                   300],
        //             )
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // // Center(
        // //   child: Container(
        // //       decoration: BoxDecoration(
        // //         borderRadius:
        // //             BorderRadius.circular(
        // //                 24),
        // //         color: Colors.grey
        // //             .withOpacity(0.5),
        // //       ),
        // //       height: 1,
        // //       width: double.maxFinite -
        // //           20.0),
        // // ),
        // _menu2
        //     ? Padding(
        //         padding:
        //             const EdgeInsets
        //                     .only(
        //                 bottom:
        //                     42.0),
        //         child: Column(
        //           children: [
        //             Padding(
        //               padding:
        //                   const EdgeInsets.all(
        //                       8.0),
        //               child:
        //                   GestureDetector(
        //                 onTap:
        //                     () {
        //                   setState(
        //                       () {
        //                     _selectedItem2 =
        //                         'Vanilla';
        //                   });
        //                 },
        //                 child:
        //                     Row(
        //                   mainAxisAlignment:
        //                       MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     CommonUI.text(
        //                         context: context,
        //                         text: 'Vanilla',
        //                         textAlign: TextAlign.center,
        //                         style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                     CommonUI.text(
        //                         context: context,
        //                         text: '0.50 JOD',
        //                         textAlign: TextAlign.center,
        //                         style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             ////////////////////////////////////
        //             Center(
        //               child: Container(
        //                   decoration: BoxDecoration(
        //                     borderRadius:
        //                         BorderRadius.circular(24),
        //                     color:
        //                         Colors.grey.withOpacity(0.5),
        //                   ),
        //                   height: 1,
        //                   width: 250),
        //             ),
        //             Padding(
        //               padding:
        //                   const EdgeInsets.all(
        //                       8.0),
        //               child:
        //                   GestureDetector(
        //                 onTap:
        //                     () {
        //                   setState(
        //                       () {
        //                     _selectedItem2 =
        //                         'Strawberry';
        //                   });
        //                 },
        //                 child:
        //                     Row(
        //                   mainAxisAlignment:
        //                       MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     CommonUI.text(
        //                         context: context,
        //                         text: 'Strawberry',
        //                         textAlign: TextAlign.center,
        //                         style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                     CommonUI.text(
        //                         context: context,
        //                         text: '0.50 JOD',
        //                         textAlign: TextAlign.center,
        //                         style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             Center(
        //               child: Container(
        //                   decoration: BoxDecoration(
        //                     borderRadius:
        //                         BorderRadius.circular(24),
        //                     color:
        //                         Colors.grey.withOpacity(0.5),
        //                   ),
        //                   height: 1,
        //                   width: 250),
        //             ),
        //             Padding(
        //               padding:
        //                   const EdgeInsets.all(
        //                       8.0),
        //               child:
        //                   GestureDetector(
        //                 onTap:
        //                     () {
        //                   setState(
        //                       () {
        //                     _selectedItem2 =
        //                         'Chocolate';
        //                   });
        //                 },
        //                 child:
        //                     Row(
        //                   mainAxisAlignment:
        //                       MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     CommonUI.text(
        //                         context: context,
        //                         text: 'Chocolate',
        //                         textAlign: TextAlign.center,
        //                         style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                     CommonUI.text(
        //                         context: context,
        //                         text: '0.50 JOD',
        //                         textAlign: TextAlign.center,
        //                         style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             Center(
        //               child: Container(
        //                   decoration: BoxDecoration(
        //                     borderRadius:
        //                         BorderRadius.circular(24),
        //                     color:
        //                         Colors.grey.withOpacity(0.5),
        //                   ),
        //                   height: 1,
        //                   width: 250),
        //             ),
        //             Padding(
        //               padding:
        //                   const EdgeInsets.all(
        //                       8.0),
        //               child:
        //                   GestureDetector(
        //                 onTap:
        //                     () {
        //                   setState(
        //                       () {
        //                     _selectedItem2 =
        //                         'Caramel';
        //                   });
        //                 },
        //                 child:
        //                     Row(
        //                   mainAxisAlignment:
        //                       MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     CommonUI.text(
        //                         context: context,
        //                         text: 'Caramel',
        //                         textAlign: TextAlign.center,
        //                         style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                     CommonUI.text(
        //                         context: context,
        //                         text: '0.50 JOD',
        //                         textAlign: TextAlign.center,
        //                         style: FontStyle.small(context: context, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
        //                   ],
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       )
        //     : Padding(
        //         padding:
        //             const EdgeInsets
        //                     .only(
        //                 bottom:
        //                     42.0),
        //         child:
        //             Container(),
        //       ),
        SizedBox(height: 50),
        // _scroll
        // ? SizedBox(height: 50)
        // : Container(),
      ],
    );
  }
}
