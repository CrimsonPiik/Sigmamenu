import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackGroundTile extends StatelessWidget {
  final String background;
  final String name;

  BackGroundTile({required this.background, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: <Widget>[
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/' + name);
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
                    name, // .toCapitalized(),
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
