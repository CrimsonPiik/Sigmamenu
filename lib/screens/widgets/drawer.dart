import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/widgets/adminPanelProducts.dart';

class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  late String title;

  @override
  void initState() {
    title = "Home";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    //  MaterialApp(
      // debugShowCheckedModeBanner: false,
      // home:
       Scaffold(
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
            sliderMain: Row(
              children: [
                AdminPanelProducts(streamControllerSideBar.stream),
              ],
            )),
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
              child: CircleAvatar(
                radius: 
                30.0,
                backgroundImage:
                    AssetImage('assets/images/user.png'),
                //NetworkImage(user.image),
                // backgroundColor: Colors.brown,
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
          sliderItem('User', Icons.person, selectedIndex, 0),
          sliderItem('Dashboard', Icons.dashboard_outlined, selectedIndex, 1),
          sliderItem('Banners', Icons.photo_size_select_actual_outlined,
              selectedIndex, 2),
          sliderItem('Setting', Icons.settings, selectedIndex, 3),
          sliderItem('LogOut', Icons.arrow_back_ios, selectedIndex, 4)
        ],
      ),
    );
  }

  Widget sliderItem(
      String title, IconData icons, int selectedIndex, int index) {
    return SizedBox(
        height: 56,
        child: InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onItemClick!(title);
            if (title == 'User') {
              myState(0);
            } else if (title == 'Dashboard') {
              myState(1);
            } else if (title == 'Banners') {
              myState(2);
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
                  color: Colors.white,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'BalsamiqSans_Regular'),
                ),
              ],
            ),
          ),
        ));
  }
}
