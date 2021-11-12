// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sigmamenu/screens/adminPanel.dart';

// class DeleteCategoryButton extends StatefulWidget {
//   final Stream<int> stream;
//   DeleteCategoryButton(this.stream);
//   @override
//   State<DeleteCategoryButton> createState() => _DeleteCategoryButtonState();
// }

// class _DeleteCategoryButtonState extends State<DeleteCategoryButton> {
//   String category = categoriesList.elementAt(0);

//   TextEditingController newCollectionNameController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     widget.stream.listen((index) {
//       mySetState(index);
//     });
//   }

//   void mySetState(int index) {
//     if (!mounted) return;

//     setState(() {
//       category = categoriesList.elementAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Align(
//           alignment: Alignment.center,
//           child: TextButton.icon(
//               onPressed: () {
//                 _showDeleteCategoryDialog();
//               },
//               icon: Icon(Icons.remove),
//               label: Text('Category')),
//         ),
//         SizedBox(width: 21),
//       ],
//     );
//   }

//   _showDeleteCategoryDialog() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(
//               'Delete',
//               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
//             ),
//             content: Text('Are you sure you want to delete this category ?'),
//             actions: [
//               TextButton(
//                 onPressed: () async {
//                   categoriesList.remove(category);
//                   // setState(() {
//                   //   category = categoriesList.elementAt(0);
//                   // });
//                   await FirebaseFirestore.instance
//                       .collection('Categories')
//                       .doc(category)
//                       .delete();

//                   Navigator.of(context).pop();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   child: Text(
//                     'YES',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   child: Text(
//                     'NO',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
// }
