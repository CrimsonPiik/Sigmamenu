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
  late AnimationController _controller;
  // late Animation growingAnimation;
  // late Animation animation;

  // AnimationController? _animationContainer;
  // static FirebaseAnalytics analytics = FirebaseAnalytics();
  late var transitionTween;
  late var borderRadius;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this)
          ..addStatusListener((status) {
            // if (status == AnimationStatus.completed) {
            // Navigator.pop(context);
            // }
          });

    transitionTween = Tween<double>(
      begin: 10.0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(75.0),
      end: BorderRadius.circular(0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // double containerMarginTop = 500;

  // double loginButtonsMargin = 20;

  // void animationLogin() {
  //   _animationContainer = AnimationController(
  //       vsync: this,
  //       duration: Duration(milliseconds: 1500),
  //       animationBehavior: AnimationBehavior.preserve);
  //   _animationContainer?.forward();
  // }

  // @override
  // void dispose() {
  //   // _privacyPolicy.dispose();
  //   // _termsAndConditions.dispose();
  //   _animationContainer?.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
            body: Center(
                child: Stack(
          children: <Widget>[
            // Center(
            //     child: Container(
            //   width: 200.0,
            //   height: 200.0,
            //   color: Colors.black12,
            // )),
            Center(
              child: InkWell(
                onTap: () {},
                child: Stack(
                  children: [
                    Container(
                        alignment: Alignment.bottomCenter,
                        width: transitionTween.value,
                        height: transitionTween.value,
                        // decoration: BoxDecoration(
                        // color: Colors.black12,
                        // borderRadius: borderRadius.value,
                        // ),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius.value,
                          image: DecorationImage(
                              image: NetworkImage(widget.background),
                              fit: BoxFit.fill),
                        )),
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
              ),
            ),
          ],
        )));
      },
    );
  }
}
    // return InkWell(
    //     onTap: () {},
    //     child: Stack(
    //       children: [
    //         Container(
    //           decoration: BoxDecoration(
    //             image: DecorationImage(
    //                 image: NetworkImage(widget.background), fit: BoxFit.fill),
    //           ),
    //         ),
    //         Container(
    //           decoration: BoxDecoration(color: Color(0x4D303030)),
    //           child: Center(
    //               child: Text(
    //             widget.text,
    //             style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.white),
    //           )),
    //         ),
    //       ],
    //       // ),
    //     ));
    // });
  

