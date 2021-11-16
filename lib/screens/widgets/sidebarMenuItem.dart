import 'package:flutter/material.dart';
import 'package:sigmamenu/layout/sidebar.dart';
import 'package:sigmamenu/models/model.dart';
import 'package:sigmamenu/screens/adminPanel.dart';

class SideBarMenuItem extends StatefulWidget {
  final MenuItem item;
  final bool isDesktop;
  SideBarMenuItem(this.item, [this.isDesktop = false]);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<SideBarMenuItem> {
  int selectedIndex = 0;
  List<Color?> selectedColor = [
    Colors.grey[900],
    Colors.grey[900],
    Colors.grey[900]
  ];

  var _bgColor = Colors.transparent;
  var _iconColor = Colors.white;

  void myState(int index) {
    // if (selectedIndex == index) return;

    // if(selectedIndex == 0){}
    setState(() {
      selectedIndex = index;
      selectedColor[selectedIndex] = Colors.red;
    });
    streamControllerSideBar.add(selectedIndex);
    // print(menu.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.builder(
        // scrollDirection: Axis.vertical,
        itemCount: menuItems.length,
        itemBuilder: (context, index) => buildMenu(index, selectedIndex),
      ),
    );
  }

  Widget buildMenu(int index, int selectedIndex) {
    return MouseRegion(
      // opaque: ,
      onEnter: (e) {
        setState(() {
          _bgColor = Colors.white;
          _iconColor = Colors.brown;
        });
      },
      onExit: (e) {
        setState(() {
          _bgColor = Colors.transparent;
          _iconColor = Colors.white;
        });
      },
      child: InkWell(
        onTap: () {
          setState(() {
            selectedColor[selectedIndex] = Colors.red;

            _bgColor = Colors.white;
            _iconColor = Colors.brown;
            selectedIndex = index;
            // selectedColor[selectedIndex] = Colors.black;

            //   selectedIndex = 100;
          });
          if (widget.item.name == 'User') {
            // setState(() {
            //   selectedIndex = index;
            // });
            // selectedColor[0] = Colors.red;
            myState(0);
            print(index);
          } else if (widget.item.name == 'Dashboard') {
            // setState(() {
            //   selectedIndex = index;
            // });
            // selectedColor[1] = Colors.red;

            myState(1);
            print(index);
          } else if (widget.item.name == 'Banners') {
            // setState(() {
            //   selectedIndex = index;
            // });
            // selectedColor[2] = Colors.red;

            myState(2);
            print(index);
          }
        },
        child: Container(
          width: widget.isDesktop ? null : 44,
          height: 44,
          padding: EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: selectedColor[selectedIndex],
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: widget.isDesktop
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Icon(
                widget.item.icon,
                size: 20,
                color: _iconColor,
                // selectedIndex == index ? Colors.white : Colors.brown,
              ),
              if (widget.isDesktop) ...[
                SizedBox(
                  width: 16,
                ),
                Text(
                  widget.item.name,
                  style: TextStyle(color: _iconColor),
                  // selectedIndex == index
                  // ? Colors.white
                  // : Colors.brown),
                ),
              ] else
                SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
