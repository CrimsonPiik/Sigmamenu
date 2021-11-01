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

class _StaggerdGridViewState extends State<StaggerdGridView> {
  // void animationLogin() {
  //   _animationContainer = AnimationController(
  //       vsync: this,
  //       duration: Duration(milliseconds: 1500),
  //       animationBehavior: AnimationBehavior.preserve);
  //   _animationContainer?.forward();
  // }

  @override
  Widget build(BuildContext context) {
    // final double width = MediaQuery.of(context).size.width;
    // controller.forward();
    // return AnimatedBuilder(
    //     animation: controller,
    //     builder: (context, child) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: Text("YOUR LOGO")),
      // ),
      body:

          //  Transform(
          //   transform:
          //       Matrix4.translationValues(animation.value * width, 0.0, 0.0),
          //   child:
          Container(
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
    //   );
    // });
  }
}

class BackGroundTile extends StatefulWidget {
  final String background;
  final String text;

  BackGroundTile({required this.background, required this.text});

  @override
  State<BackGroundTile> createState() => _BackGroundTileState();
}

class _BackGroundTileState extends State<BackGroundTile>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation growingAnimation;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    growingAnimation = Tween(begin: 10.0, end: 100.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    animation = Tween(begin: -0.25, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          Navigator.pop(context);
        }
      });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    controller.forward();
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform(
              transform:
                  Matrix4.translationValues(animation.value * width, 0.0, 0.0),
              child: InkWell(
                onTap: () {},
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.background),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Color(0x4D303030)),
                      child: Center(
                          child: Text(
                        widget.text,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                  ],
                ),
              ));
        });
  }
}
