import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/models/model.dart';
import 'package:shop_app/screens/widgets/sidebarMenuItem.dart';

final List<MenuItem> menuItems = [
  MenuItem('Home', Icons.home_outlined),
  MenuItem('Dashboard', Icons.dashboard_outlined),
  MenuItem('User', Icons.person),
  MenuItem('Banners', Icons.photo_size_select_actual_outlined),
];
// late List<MenuItem> menuItems = [];

// void getCategories() async {
//   final QuerySnapshot result =
//       await FirebaseFirestore.instance.collection('categories').get();
//   // print(res)
//   final List<DocumentSnapshot> documents = result.docs;

//   for (int i = 0; i < documents.length; i++) {

//     menuItems.add(MenuItem(documents[i].id, Icons.home_outlined));
//   }
// }

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  void initState() {
    // getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= screenLg;

    // return StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance.collection('categories').snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         return CommonUI.error(snapshot.error.toString());
    //       }
    //       if (snapshot.connectionState == ConnectionState.waiting)
    //         return CommonUI.loading();

    //       late List<MenuItem> menuItems = [];

    //       List<DocumentSnapshot> shots = snapshot.data!.docs;
    //       for (var item in shots) {
    //         menuItems.add(MenuItem.
    //             // MenuItem.fromMap(item.data() as Map<String, dynamic>)
    //             // .toString(),
    //             // Icons.ac_unit));
    //             fromMap(item.data() as Map<String, dynamic>));
    //       }

    return Container(
      decoration: BoxDecoration(color: Colors.brown),
      width: _isDesktop ? sideBarDesktopWidth : sideBarMobileWidth,
      padding:
          EdgeInsets.symmetric(vertical: 24, horizontal: _isDesktop ? 24 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              //  color: primaryAncient
            ),
            width: 200,
            height: 90,
            child: Center(
              child: Text(
                'Sigma Menu',
                style: TextStyle(
                    fontSize: _isDesktop ? 30 : 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                menuItems.map((e) => SideBarMenuItem(e, _isDesktop)).toList(),
          ))
        ],
      ),
    );
    // return Container();
    // });
  }
}
