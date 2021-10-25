import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPanelBanners extends StatefulWidget {
  AdminPanelBanners({Key? key}) : super(key: key);

  @override
  _AdminPanelBannersState createState() => _AdminPanelBannersState();
}

class _AdminPanelBannersState extends State<AdminPanelBanners> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // color: primaryLight.withAlpha(100),
      // padding: EdgeInsets.symmetric(horizontal: ),
      child: Column(
        children: [
          Container(
            height: 70,
            child: Row(
              children: [
                SizedBox(
                  height: 10,
                  width: 30,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'WELCOME BACK MOE !',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.brown,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 25),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text('Banners ')
        ],
      ),
    );
  }
}
