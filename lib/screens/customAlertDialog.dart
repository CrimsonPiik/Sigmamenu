// import 'package:flutter/material.dart';

// class CustomDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//       elevation: 0.0,
//       backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }

//   Widget dialogContent(BuildContext context) {
//     return Container(
//       width: 300,
//       height: 370,
//       margin: EdgeInsets.only(left: 0.0, right: 0.0),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(
//               top: 18.0,
//             ),
//             margin: EdgeInsets.only(top: 13.0, right: 8.0),
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(16.0),
//                 boxShadow: <BoxShadow>[
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 0.0,
//                     offset: Offset(0.0, 0.0),
//                   ),
//                 ]),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 // SizedBox(
//                 //   height: 3.0,
//                 // ),
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Form(
//                       child: Column(
//                         children: <Widget>[
//                           Text("Create a new product "),
//                           SizedBox(height: 5.0),
//                           TextFormField(
//                             // style: TextStyle(color: Colors.brown),
//                             decoration: InputDecoration(
//                               labelText: 'Product Name',
//                               icon: Icon(Icons.account_box),
//                             ),
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               labelText: 'Product Price',
//                               icon: Icon(Icons.money),
//                             ),
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               labelText: 'Product Description',
//                               icon: Icon(Icons.message),
//                             ),
//                           ),
//                           TextFormField(
//                             decoration: InputDecoration(
//                               labelText: 'Product Image',
//                               icon: Icon(Icons.image),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 InkWell(
//                   child: Container(
//                     padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(16.0),
//                           bottomRight: Radius.circular(16.0)),
//                     ),
//                     child: Text(
//                       "Create",
//                       style: TextStyle(color: Colors.black, fontSize: 25.0),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 )
//               ],
//             ),
//           ),
//           Positioned(
//             right: 0.0,
//             child: InkWell(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: CircleAvatar(
//                   radius: 16.0,
//                   backgroundColor: Colors.red,
//                   child: Icon(Icons.close, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // void showDialogWithFields() {
// //   showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           // backgroundColor: Colors.brown,
// //           scrollable: true,
// //           title: Center(child: Text('Create a new Product')),
// //           content: Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Form(
// //               child: Column(
// //                 children: <Widget>[
// //                   TextFormField(
// //                     // style: TextStyle(color: Colors.brown),
// //                     decoration: InputDecoration(
// //                       labelText: 'Product Name',
// //                       icon: Icon(Icons.account_box),
// //                     ),
// //                   ),
// //                   TextFormField(
// //                     decoration: InputDecoration(
// //                       labelText: 'Product Price',
// //                       icon: Icon(Icons.money),
// //                     ),
// //                   ),
// //                   TextFormField(
// //                     decoration: InputDecoration(
// //                       labelText: 'Product Description',
// //                       icon: Icon(Icons.message),
// //                     ),
// //                   ),
// //                   TextFormField(
// //                     decoration: InputDecoration(
// //                       labelText: 'Product Image',
// //                       icon: Icon(Icons.image),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           actions: [
// //             TextButton(
// //                 child: Center(child: Text("Create")),
// //                 onPressed: () {
// //                   // your code
// //                 })
// //           ],
// //         );
// //       });
// // }
