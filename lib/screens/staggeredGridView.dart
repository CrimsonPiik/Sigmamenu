import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
      text: 'Food'),
  BackGroundTile(
      background:
          'https://images.pexels.com/photos/1283219/pexels-photo-1283219.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      text: 'Hard Drinks'),
  BackGroundTile(
      background:
          'https://images.pexels.com/photos/2130134/pexels-photo-2130134.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      text: 'Brunch'),
  BackGroundTile(
      background:
          'https://images.pexels.com/photos/1200348/pexels-photo-1200348.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      text: 'Beverages'),
  BackGroundTile(
      background:
          'https://images.pexels.com/photos/6062039/pexels-photo-6062039.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      text: 'Desserts'),
  BackGroundTile(
      background:
          'https://images.pexels.com/photos/3637608/pexels-photo-3637608.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      text: 'Appetizers'),
];

class StaggerdGridView extends StatefulWidget {
  @override
  State<StaggerdGridView> createState() => _StaggerdGridViewState();
}

class _StaggerdGridViewState
    extends State<StaggerdGridView> /* with SingleTickerProviderStateMixin */ {
  // AnimationController? _animationContainer;

  // void animationLogin() {
  //   _animationContainer = AnimationController(
  //       vsync: this,
  //       duration: Duration(milliseconds: 1500),
  //       animationBehavior: AnimationBehavior.preserve);
  //   _animationContainer?.forward();
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   // analytics.setCurrentScreen(screenName: '/loginScreen');
  //   // _privacyPolicy = TapGestureRecognizer()..onTap = _handlePrivacyPress;
  //   // _termsAndConditions = TapGestureRecognizer()..onTap = _handleTermsPress;
  //   animationLogin();
  // }

  // @override
  // void dispose() {
  //   _animationContainer?.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: Text("YOUR LOGO")),
      // ),
      body: Container(
        // Staggered Grid View starts here
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          staggeredTiles: _cardTile,
          children: _listTile,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}

class BackGroundTile extends StatelessWidget {
  final String background;
  final String text;

  BackGroundTile({required this.background, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(background), fit: BoxFit.fill),
            ),
          ),
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
    );
  }
}
