import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:sigmamenu/GeneralFunction/constaints.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/widgets/adminPanelDrawer.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  late String title;

  @override
  void initState() {
    title = "Dashboard";
    super.initState();
  }

  @override
  void dispose() {
    streamControllerSideBar.done;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderMenuContainer(
        appBarColor: Colors.white,
        key: _key,
        sliderMenuOpenSize: 200,
        title: Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        sliderMenu: MenuWidget(
          onItemClick: (title) {
            _key.currentState!.closeDrawer();
            setState(() {
              this.title = title;
            });
          },
        ),
        sliderMain:
            // Row(
            // children: [
            AdminPanelDrawer(streamControllerSideBar.stream),
        // ],
        // )
      ),
      // ),
    );
  }
}

class MenuWidget extends StatefulWidget {
  final Function(String)? onItemClick;

  const MenuWidget({Key? key, this.onItemClick}) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  int selectedIndex = 0;

  void myState(int index) {
    setState(() {
      selectedIndex = index;
    });
    streamControllerSideBar.add(selectedIndex);
  }

  // @override
  // void dispose() {
  //   streamControllerSideBar.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    final bool _isDesktop = _size.width >= screenLg;

    return Container(
      decoration: BoxDecoration(color: Colors.orange[300]),
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
              child: Container(
                height: 80,
                width: 80,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/images/user.png'),
                  //NetworkImage(user.image),
                  // backgroundColor: Colors.brown,
                ),
              ),
              //  Container(
              //     width: _isDesktop ? 120 : 60,
              //     height: _isDesktop ? 120 : 60,
              //     child:
              //         Image(image: AssetImage('assets/images/sigmamenu.png'))),
              // Text(
              //   'Sigma Menu',
              //   style: TextStyle(
              //       fontSize: _isDesktop ? 30 : 12,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white),
              // ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          sliderItem(
              'Products', Icons.restaurant_menu_rounded, selectedIndex, 0),
          sliderItem('Banners', Icons.photo_size_select_actual_outlined,
              selectedIndex, 1),
          sliderItem('Dashboard', Icons.dashboard, selectedIndex, 2),
          sliderItem('Product Options', Icons.settings, selectedIndex, 3),
          sliderItem('Users', Icons.person, selectedIndex, 4),
          sliderItem('LogOut', Icons.arrow_back_ios, selectedIndex, 5)
        ],
      ),
    );
  }

  Widget sliderItem(
      String title, IconData icons, int selectedIndex, int index) {
    return SizedBox(
        height: 56,
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onItemClick!(title);
            if (title == 'Products') {
              myState(0);
            } else if (title == 'Banners') {
              myState(1);
            } else if (title == 'Dashboard') {
              myState(2);
            } else if (title == 'Product Options') {
              myState(3);
            } else if (title == 'Users') {
              myState(4);
            } else if (title == 'LogOut') {
              Navigator.pushNamed(context, '/');
            }
          },
          child: Container(
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icons,
                  size: 20,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular'),
                ),
              ],
            ),
          ),
        ));
  }
}
