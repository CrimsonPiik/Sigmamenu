import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sigmamenu/animation/page_slide_widget.dart';
import 'package:sigmamenu/language/widgets/changeLanguageButton.dart';
import 'package:sigmamenu/screens/home/components/customerScreen.dart';
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
                        SizedBox(width: 20),
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
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isLight
                            ? IconButton(
                                icon:
                                    Icon(Icons.dark_mode, color: Colors.white),
                                onPressed: () {
                                  // setState(() {
                                  //   isLight = false;
                                  // });
                                  // widget.theme.setDarkMode();
                                },
                              )
                            : IconButton(
                                icon:
                                    Icon(Icons.light_mode, color: Colors.white),
                                onPressed: () {
                                  // setState(() {
                                  //   isLight = true;
                                  // });
                                  // widget.theme.setLightMode();
                                },
                              ),
                        SizedBox(width: 5),
                        Container(
                          child: ChangeLanguageButton(),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
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

class BackGroundTile extends StatelessWidget {
  final String background;
  final String text;
  final String routeName;

  BackGroundTile(
      {required this.background, required this.text, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: <Widget>[
        Center(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, routeName);
            },
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(background), fit: BoxFit.cover),
                )),
                Container(
                  decoration: BoxDecoration(color: Color(0x4D303030)),
                  child: Center(
                      child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
              ],
            ),
          ),
        ),
      ],
    )));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
//   StaggeredTile.extent(2, 150.0),
//   StaggeredTile.extent(1, 150.0),
//   StaggeredTile.extent(1, 150.0),
//   StaggeredTile.extent(2, 150.0),
//   StaggeredTile.extent(1, 150.0),
//   StaggeredTile.extent(1, 150.0),
//   StaggeredTile.extent(2, 150.0),
// ];

// List<Widget> _tiles = const <Widget>[
//   const MyItems(Icons.shop, "Text1 Here", 0xff42a5f5, "/first"),
//   const _Example01Tile(Colors.green, Icons.widgets),
//   const _Example01Tile(Colors.amber, Icons.panorama_wide_angle),
//   const MyItems(Icons.shop, "Text 2 Here", 0xff42a5f5, "/second"),
//   const _Example01Tile(Colors.deepOrange, Icons.send),
//   const _Example01Tile(Colors.indigo, Icons.airline_seat_flat),
//   const _Example01Tile(Colors.red, Icons.bluetooth),
//   const _Example01Tile(Colors.pink, Icons.battery_alert),
//   const _Example01Tile(Colors.purple, Icons.desktop_windows),
//   const _Example01Tile(Colors.blue, Icons.radio),
// ];

// class Example01 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Example 01'),
//         ),
//         body: Padding(
//             padding: const EdgeInsets.only(top: 12.0),
//             child: StaggeredGridView.count(
//               crossAxisCount: 4,
//               staggeredTiles: _staggeredTiles,
//               children: _tiles,
//               mainAxisSpacing: 4.0,
//               crossAxisSpacing: 4.0,
//               padding: const EdgeInsets.all(4.0),
//             )));
//   }
// }

// class _Example01Tile extends StatelessWidget {
//   const _Example01Tile(this.backgroundColor, this.iconData);

//   final Color backgroundColor;
//   final IconData iconData;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: backgroundColor,
//       child: InkWell(
//         onTap: () {},
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Icon(
//               iconData,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyItems extends StatelessWidget {
//   const MyItems(this.icon, this.heading, this.color, this.routeName);

//   final int color;
//   final IconData icon;
//   final String heading;
//   final String routeName;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       elevation: 12.0,
//       shadowColor: Color(0xff2962ff),
//       borderRadius: BorderRadius.circular(20.0),
//       child: Center(
//           child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         //Text here
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             heading,
//                             style: TextStyle(
//                               color: new Color(color),
//                               fontSize: 18.0,
//                             ),
//                           ),
//                         ), //text

//                         //icon
//                         Material(
//                           color: new Color(color),
//                           borderRadius: BorderRadius.circular(24.0),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: IconButton(
//                               icon: Icon(icon),
//                               iconSize: 20,
//                               color: Colors.white,
//                               onPressed: () {
//                                 Navigator.pushNamed(context, routeName);
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ]))),
//     );
//   }
// }

// // void main() => runApp(MyApp());

// class MyAppp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       routes: {
//         // When navigating to the "/" route, build the FirstScreen widget.
//         '/': (context) => Example01(),
//         '/first': (context) => FirstScreen(),
//         '/second': (context) => SecondScreen(),
//       },
//     );
//   }
// }

// class FirstScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Text("First Screen");
//   }
// }

// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Text("Second Screen");
//   }
// }
