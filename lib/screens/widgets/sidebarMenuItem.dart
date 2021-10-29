import 'package:flutter/material.dart';
import 'package:shop_app/models/model.dart';
import 'package:shop_app/screens/adminPanel.dart';

class SideBarMenuItem extends StatefulWidget {
  final MenuItem item;
  final bool isDesktop;
  SideBarMenuItem(this.item, [this.isDesktop = false]);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<SideBarMenuItem> {
  String selectedMenu = 'User';

  // bool isSelected = false;
  // int selectedIndex = 1;

  // var _bgColor = Colors.transparent;
  // var _iconColor = Colors.white;

  void myState(String menu) {
    setState(() {
      selectedMenu = menu;

    });
    streamControllerSideBar.add(selectedMenu);

    // print(menu.toString());
  }

  @override
  Widget build(BuildContext context) {
    // Widget buildMenu(int index) {
    // return MouseRegion(
    //     onEnter: (e) {
    //       setState(() {
    //         _bgColor = Colors.white;
    //         _iconColor = Colors.brown;
    //       });
    //     },
    //     onExit: (e) {
    //       setState(() {
    //         _bgColor = Colors.transparent;
    //         _iconColor = Colors.white;
    //       });
    //     },
    // child:
    return InkWell(
        onTap: () {
          if (selectedMenu != widget.item.name) {
            myState(widget.item.name);
            // setState(() {
            //   selectedMenu = "s";
            // });
          } else
            setState(() {
              selectedMenu = "s";
            });

          print(selectedMenu);
        },
        child: Container(
          width: widget.isDesktop ? null : 44,
          height: 44,
          padding: EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: selectedMenu == widget.item.name
                  ? Colors.white
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: widget.isDesktop
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Icon(
                widget.item.icon,
                size: 20,
                color: selectedMenu == widget.item.name
                    ? Colors.brown
                    : Colors.white,
              ),
              if (widget.isDesktop) ...[
                SizedBox(
                  width: 16,
                ),
                Text(
                  widget.item.name,
                  style: TextStyle(
                    color: selectedMenu == widget.item.name
                        ? Colors.brown
                        : Colors.white,
                  ),
                )
              ] else
                SizedBox.shrink(),
            ],
          ),
          // ),
        ));
  }
}
