import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//List of Cards with size
List<StaggeredTile> _cardTile = <StaggeredTile>[
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 2),
  // StaggeredTile.count(2, 3),
  // StaggeredTile.count(2, 2),
];

//List of Cards with color and icon
List<Widget> _listTile = <Widget>[
  BackGroundTile(backgroundColor: Colors.red, icondata: Icons.home),
  BackGroundTile(backgroundColor: Colors.orange, icondata: Icons.ac_unit),
  BackGroundTile(backgroundColor: Colors.pink, icondata: Icons.landscape),
  BackGroundTile(backgroundColor: Colors.green, icondata: Icons.portrait),
  BackGroundTile(
      backgroundColor: Colors.deepPurpleAccent, icondata: Icons.music_note),
  BackGroundTile(backgroundColor: Colors.blue, icondata: Icons.access_alarms),
  BackGroundTile(
      backgroundColor: Colors.yellowAccent, icondata: Icons.satellite_outlined),
  BackGroundTile(
      backgroundColor: Colors.deepOrange, icondata: Icons.search_sharp),
//   BackGroundTile(
//       backgroundColor: Colors.yellowAccent, icondata: Icons.adjust_rounded),
//   BackGroundTile(
//       backgroundColor: Colors.deepOrange, icondata: Icons.attach_money),
];

class StaggerdGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("GFG App"),
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
  final Color backgroundColor;
  final IconData icondata;

  BackGroundTile({required this.backgroundColor, required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Icon(icondata, color: Colors.white),
    );
  }
}
