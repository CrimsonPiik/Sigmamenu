// import 'package:flutter/cupertino.dart';
// import 'package:sigmamenu/style/CommonUI.dart';
// import 'package:flutter/material.dart';
// import 'package:sigmamenu/models/options.dart';
// import '../../../style/Style.dart';

// class ProductOptionItem extends StatelessWidget {
//   // final BuildContext context;
//   final List<OptionsModel> options;
//   final int index;
//   const ProductOptionItem({required this.index, required this.options});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Container(
//         margin: EdgeInsets.only(bottom: 20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(
//             Radius.circular(18),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.4),
//               spreadRadius: 1,
//               blurRadius: 6,
//               offset: Offset(1, 6),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {},
//               child: Container(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CommonUI.text(
//                           context: context,
//                           text: options
//                               .elementAt(index)
//                               .options
//                               .keys
//                               .first
//                               .toString(),
//                           textAlign: TextAlign.center,
//                           style: FontStyle.normal(
//                               context: context,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black)),
//                       Row(
//                         children: [
//                           CommonUI.text(
//                               context: context,
//                               text: 'Example!',
//                               // .product
//                               // .options1[
//                               //     '${widget.product.options1.keys.elementAt(index)}']
//                               // .keys
//                               // .elementAt(index),
//                               textAlign: TextAlign.center,
//                               style: FontStyle.normal(
//                                   context: context,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.orange[700])),
//                           SizedBox(width: 5),
//                           Icon(
//                             Icons.arrow_forward_ios_outlined,
//                             size: 15,
//                             color: Colors.orange[700],
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Center(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24),
//                       color: Colors.grey.withOpacity(0.5),
//                     ),
//                     height: 1,
//                     width: double.maxFinite,
//                   ),
//                 ),
//                 ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   itemCount: options.elementAt(index).options.keys.first.length,
//                   itemBuilder: (context, indexx) {
//                     return Column(
//                       children: [
//                         Center(
//                           child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(24),
//                                 color: Colors.grey.withOpacity(0.2),
//                               ),
//                               height: 1,
//                               width: double.maxFinite),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: GestureDetector(
//                             onTap: () {},
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CommonUI.text(
//                                     context: context,
//                                     text: 'II',
//                                     // options
//                                     //     .elementAt(index)
//                                     //     .options
//                                     //     .values
//                                     //     .elementAt(index)
//                                     //     .toString(),
//                                     textAlign: TextAlign.center,
//                                     style: FontStyle.small(
//                                         context: context,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black.withOpacity(0.8))),
//                                 CommonUI.text(
//                                     context: context,
//                                     text: 'widget',
//                                     // options.elementAt(index)
//                                     //     .product
//                                     //     .options1[noName
//                                     //         // widget.product.options1.keys
//                                     //         //   .elementAt(index)
//                                     //         ]
//                                     //     .values
//                                     //     .elementAt(indexx) +
//                                     // ' JOD',
//                                     textAlign: TextAlign.center,
//                                     style: FontStyle.small(
//                                         context: context,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black.withOpacity(0.8))),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
