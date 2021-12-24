import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardTileAdmin extends StatelessWidget {
  final String background;
  final String text;
  final String routeName;

  DashBoardTileAdmin(
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
              Navigator.pushNamed(context, '/' + routeName);
            },
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(background), fit: BoxFit.cover),
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(color: Color(0x4D303030)),
                      child: Center(
                          child: Text(
                        text, // .toCapitalized(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 14),
                          Icon(
                            Icons.delete_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 14),
                          Icon(
                            Icons.toggle_on_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    )));
  }
}
