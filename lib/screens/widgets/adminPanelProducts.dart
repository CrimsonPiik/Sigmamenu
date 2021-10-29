import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/home/components/categorries.dart';
import 'package:shop_app/screens/home/components/itemCardDataAdmin.dart';
import 'package:shop_app/screens/widgets/addCategoryButton.dart';
import 'package:shop_app/screens/widgets/addProductButton.dart';
import 'package:shop_app/screens/widgets/adminPanelBanners.dart';
import 'package:shop_app/screens/widgets/deleteCategoryButton.dart';

class AdminPanelProducts extends StatefulWidget {
  final Stream<String> menu;
  AdminPanelProducts(this.menu);
  @override
  _AdminPanelProductsState createState() => _AdminPanelProductsState();
}

class _AdminPanelProductsState extends State<AdminPanelProducts> {
  String item = 'Dashboard';

  // @override
  // void dispose() {
  //   streamController.close();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    widget.menu.listen((whichMenu) {
      mySetState(whichMenu);
    });
  }

  void mySetState(String whichMenu) {
    if (!mounted) return;

    setState(() {
      item = whichMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return item == 'Dashboard'
        ? Expanded(
            // color: primaryLight.withAlpha(100),
            // padding: EdgeInsets.symmetric(horizontal: ),
            child: Column(
              children: [
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
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
                Categories(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AddProductButton(streamController.stream),
                    DeleteCategoryButton(streamController.stream),
                    AddCategoryButton(),
                  ],
                ),
                SizedBox(height: 12),
                ItemCardDataAdmin(streamController.stream),
              ],
            ),
          )
        : Expanded(
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
                      SizedBox(width: 35),
                    ],
                  ),
                ),
                AdminPanelBanners()
              ],
            ),
          );
  }
}
