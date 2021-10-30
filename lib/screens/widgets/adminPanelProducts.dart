import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/home/components/categorries.dart';
import 'package:shop_app/screens/home/components/itemCardDataAdmin.dart';
import 'package:shop_app/screens/widgets/addBannerButton.dart';
import 'package:shop_app/screens/widgets/addCategoryButton.dart';
import 'package:shop_app/screens/widgets/addProductButton.dart';
import 'package:shop_app/screens/widgets/adminPanelBanners.dart';
import 'package:shop_app/screens/widgets/deleteCategoryButton.dart';
import 'package:shop_app/screens/widgets/userProfile.dart';

class AdminPanelProducts extends StatefulWidget {
  final Stream<int> menu;
  AdminPanelProducts(this.menu);
  @override
  _AdminPanelProductsState createState() => _AdminPanelProductsState();
}

class _AdminPanelProductsState extends State<AdminPanelProducts> {
  int item = 0;

  @override
  void initState() {
    super.initState();
    widget.menu.listen((whichMenu) {
      mySetState(whichMenu);
    });
  }

  void mySetState(int whichMenu) {
    if (!mounted) return;

    setState(() {
      item = whichMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return item == 0 //USER
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
                        height: 10,
                        width: 25,
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
                            SizedBox(width: 4),
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
                EditProfileInformation()
              ],
            ),
          )
        : item == 1 //DASHBOARD
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
                            width: 25,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'WELCOME BACK MOE !',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 4),
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
                // BANNERS
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
                            width: 25,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'WELCOME BACK MOE !',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 4),
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
                    AddBannerButton(),
                    SizedBox(height: 15),
                    AdminPanelBanners()
                  ],
                ),
              );
  }
}
