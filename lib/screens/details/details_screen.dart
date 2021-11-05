// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shop_app/constaints.dart';
// import 'package:shop_app/language/logic/ProjectLanguage.dart';
// import 'package:shop_app/models/product.dart';
// import 'package:shop_app/style/ScreenUtil.dart';

// class DetailsScreen extends StatelessWidget {
//   final Product product;

//   const DetailsScreen({Key? key, required this.product}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       // each product have a color
//       // backgroundColor: product.color,
//       // appBar: buildAppBar(context),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 // SingleChildScrollView(
//                 // child:
//                 SizedBox(
//                   child: Stack(
//                     children: <Widget>[
//                       // SingleChildScrollView(
//                       // child:
//                       Container(
//                         padding: EdgeInsets.only(
//                             top: kDefaultPaddin * 2,
//                             left: kDefaultPaddin,
//                             right: kDefaultPaddin,
//                             bottom: kDefaultPaddin),
//                         // height: size.height *1.5,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.1),
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(24),
//                             topRight: Radius.circular(24),
//                             bottomLeft: Radius.circular(24),
//                             bottomRight: Radius.circular(24),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Center(
//                               child: Hero(
//                                 tag: "${product.id}",
//                                 child: Image.network(
//                                   product.image,
//                                   width: 300,
//                                   height: 250,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 18),
//                             Text(
//                               product.nameEn,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headline4!
//                                   .copyWith(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 24),
//                             ),
//                             SizedBox(height: 15),

//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(text: "Price\n"),
//                                   TextSpan(
//                                     text: "\$${product.price}",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headline4!
//                                         .copyWith(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 40),
//                             // RichText(
//                             // text: TextSpan(
//                             // style: TextStyle(color: kTextColor),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // SizedBox(height: 35),
//                                 Text(
//                                   "Description\n",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 // SizedBox(height: 1),
//                                 Container(
//                                   padding: EdgeInsets.only(
//                                       right: Responsive.isDesktop(context)
//                                           ? size.width / 2
//                                           : 1),
//                                   child: Text(
//                                     ProjectLanguage.isLTR()
//                                         ? "${product.descriptionEn}"
//                                         : "${product.descriptionAr}",
//                                     // style: Theme.of(context)
//                                     // .textTheme
//                                     // .headline5!
//                                     // .copyWith(
//                                     // fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 SizedBox(height: kDefaultPaddin * 2)
//                                 // ],
//                               ],
//                             ),
//                             // ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                       // ),
//                     ],
//                   ),
//                 ),
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         // color: Colors.black,
//         icon: SvgPicture.asset('assets/icons/back.svg', color: kTextColor),
//         onPressed: () => Navigator.pop(context),
//       ),
//       // actions: <Widget>[
//       //   IconButton(
//       //     color: Colors.black,
//       //     icon: SvgPicture.asset("assets/icons/search.svg"),
//       //     onPressed: () {},
//       //   ),
//       //   IconButton(
//       //     color: Colors.black,
//       //     icon: SvgPicture.asset("assets/icons/cart.svg"),
//       //     onPressed: () {},
//       //   ),
//       //   SizedBox(width: kDefaultPaddin / 2)
//       // ],
//     );
//   }
// }
