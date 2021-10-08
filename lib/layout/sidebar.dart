import 'package:flutter/material.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/models/model.dart';
import 'package:shop_app/screens/widgets/sidebar_menu_item.dart';

final List<MenuItem> menuItems = [
  MenuItem('Home', Icons.home_outlined),
  MenuItem('Dashboard', Icons.dashboard_outlined),
  MenuItem('User', Icons.person),
  MenuItem('Contact', Icons.contact_mail),
  MenuItem('Add a Product', Icons.add),
];

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= screenLg;
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
                'Coffee Shop',
                style: TextStyle(
                    fontSize: _isDesktop ? 30 : 15,
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
  }
}
