import 'package:flutter/material.dart';
import 'package:shop_app/models/model.dart';
import 'package:shop_app/screens/home/components/body.dart';
class SideBarMenuItem extends StatefulWidget {
  final MenuItem item;
  final bool isDesktop;
  SideBarMenuItem(this.item, [this.isDesktop = false]);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<SideBarMenuItem> {
  String selectedChoice = 'Home';
  String banner = 'Banners';
  String home = 'Home';
  String user = 'User';
  String dashboard = 'Dashboard';
  String selectedMenu = 'Banners';

  var _bgColor = Colors.transparent;
  var _iconColor = Colors.white;
  

  void myState(String menu) {
    setState(() {
      selectedMenu = menu;
    });
    streamControllerSideBar.add(selectedMenu);
    print(menu.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
            if (widget.item.name == 'Banners') {
              myState(banner);
            } else if (widget.item.name == 'User') {
              myState(user);
            } else if (widget.item.name == 'Dashboard') {
              myState(dashboard);
            } else if (widget.item.name == 'Home') {
              myState(home);
            }
          },
          child: Container(
            width: widget.isDesktop ? null : 44,
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: _bgColor, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: widget.isDesktop
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Icon(
                  widget.item.icon,
                  size: 20,
                  color: _iconColor,
                ),
                if (widget.isDesktop) ...[
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.item.name,
                    style: TextStyle(
                      color: _iconColor,
                    ),
                  )
                ] else
                  SizedBox.shrink(),
              ],
            ),
          ),
        ));
  }
}
