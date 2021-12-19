import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sigmamenu/animation/page_slide_widget.dart';
import 'package:sigmamenu/language/widgets/changeLanguageButton.dart';
import 'package:sigmamenu/screens/backGroundTile.dart';
import 'package:sigmamenu/screens/widgets/LoginForm.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

//List of Cards with size
List<StaggeredTile> _cardTile = <StaggeredTile>[
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 2.5),
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 2.5),
  StaggeredTile.count(2, 2),
];

//List of Cards with color and icon
List<Widget> _listTile = <Widget>[
  BackGroundTile(
    background:
        'https://images.pexels.com/photos/842571/pexels-photo-842571.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    text: 'Food',
    routeName: '/admin',
  ),
  BackGroundTile(
    background:
        'https://images.pexels.com/photos/1283219/pexels-photo-1283219.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    text: 'Hard Drinks',
    routeName: '/customer',
  ),
  BackGroundTile(
    background:
        'https://images.pexels.com/photos/2130134/pexels-photo-2130134.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    text: 'Brunch',
    routeName: '/customer',
  ),
  BackGroundTile(
    background:
        'https://images.pexels.com/photos/1200348/pexels-photo-1200348.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    text: 'Beverages',
    routeName: '/admin',
  ),
  BackGroundTile(
    background:
        'https://images.pexels.com/photos/6062039/pexels-photo-6062039.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    text: 'Desserts',
    routeName: '/customer',
  ),
  BackGroundTile(
    background:
        'https://images.pexels.com/photos/3637608/pexels-photo-3637608.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    text: 'Appetizers',
    routeName: '/admin',
  ),
];

class StaggerdGridView extends StatefulWidget {
  @override
  State<StaggerdGridView> createState() => _StaggerdGridViewState();
}

class _StaggerdGridViewState extends State<StaggerdGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.login),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context)
                                .push(createRoute(LoginForm()));
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: Responsive.isDesktop(context) ? 60 : 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Image.asset(
                        'assets/images/sigmabanner.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     isLight
                    //         ? IconButton(
                    //             icon:
                    //                 Icon(Icons.dark_mode, color: Colors.white),
                    //             onPressed: () {
                    //               // setState(() {
                    //               //   isLight = false;
                    //               // });
                    //               // widget.theme.setDarkMode();
                    //             },
                    //           )
                    //         : IconButton(
                    //             icon:
                    //                 Icon(Icons.light_mode, color: Colors.white),
                    //             onPressed: () {
                    //               // setState(() {
                    //               //   isLight = true;
                    //               // });
                    //               // widget.theme.setLightMode();
                    //             },
                    //           ),
                    //     SizedBox(width: 5),
                        Container(
                          child: ChangeLanguageButton(),
                        ),
                        // SizedBox(width: 5),
                      // ],
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                // Staggered Grid View starts here
                child: StaggeredGridView.count(
                  crossAxisCount: 4,
                  staggeredTiles: _cardTile,
                  children: _listTile,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
