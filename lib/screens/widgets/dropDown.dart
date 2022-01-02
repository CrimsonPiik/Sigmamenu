// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sigmamenu/style/CommonUI.dart';

// class DropDown extends StatefulWidget {
//   const DropDown({Key? key}) : super(key: key);

//   @override
//   State<DropDown> createState() => _DropDownState();
// }

// class _DropDownState extends State<DropDown> {
//   String dropdownValue = 'One';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey,
//         body: DropdownButton<String>(
//             value: dropdownValue,
//             icon: Icon(Icons.arrow_forward_ios_outlined),
//             iconSize: 15,
//             underline: SizedBox(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 dropdownValue = newValue!;
//               });
//             },
//             items: <String>['One', 'Two', 'Three', 'Four']
//                 .map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: CommonUI.text(
//                     context: context,
//                     text: value,
//                     textAlign: TextAlign.center,
//                     style: FontStyle.smaller(
//                         context: context,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black.withOpacity(0.8))),
//               );
//             }).toList()));
//   }
// }
