// import 'package:flutter/material.dart';
// import 'package:sigmamenu/constaints.dart';
// import 'package:sigmamenu/models/model.dart';
// import 'package:sigmamenu/screens/widgets/sidebarMenuItem.dart';

// final List<MenuItem> menuItems = [
//   // MenuItem('Home', Icons.home_outlined),
//   MenuItem('User', Icons.person, isSelected: true),
//   MenuItem('Dashboard', Icons.dashboard_outlined, isSelected: false),
//   MenuItem('Banners', Icons.photo_size_select_actual_outlined,
//       isSelected: false),
// ];

// class SideBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     final bool _isDesktop = _size.width >= screenLg;

//     return Container(
//       decoration: BoxDecoration(color: Colors.brown),
//       width: _isDesktop ? sideBarDesktopWidth : sideBarMobileWidth,
//       padding:
//           EdgeInsets.symmetric(vertical: 24, horizontal: _isDesktop ? 24 : 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               //  color: primaryAncient
//             ),
//             width: 200,
//             height: 90,
//             child: Center(
//               child: Container(
//                   width: _isDesktop ? 120 : 60,
//                   height: _isDesktop ? 120 : 60,
//                   child:
//                       Image(image: AssetImage('assets/images/sigmamenu.png'))),
//               // Text(
//               //   'Sigma Menu',
//               //   style: TextStyle(
//               //       fontSize: _isDesktop ? 30 : 12,
//               //       fontWeight: FontWeight.bold,
//               //       color: Colors.white),
//               // ),
//             ),
//           ),
//           SizedBox(
//             height: 24,
//           ),
//           Expanded(
//               //     child: Column(
//               //   crossAxisAlignment: CrossAxisAlignment.center,
//               //   children:
//               //       menuItems.map((e) => SideBarMenuItem(e, _isDesktop)).toList(),
//               // )
//               child: ListView.builder(
//                   itemCount: menuItems.length,
//                   itemBuilder: (context, index) =>
//                       SideBarMenuItem(menuItems[index], _isDesktop))),
//           // )
//         ],
//       ),
//     );
//     // return Container();
//     // });
//   }
// }
