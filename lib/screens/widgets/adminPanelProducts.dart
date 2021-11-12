import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigmamenu/models/user.dart';
import 'package:sigmamenu/provider/userStateProvider.dart';
import 'package:sigmamenu/screens/home/components/body.dart';
import 'package:sigmamenu/screens/home/components/categoriesWithDeleteButton.dart';
import 'package:sigmamenu/screens/home/components/itemCardDataAdmin.dart';
import 'package:sigmamenu/screens/home/components/users.dart';
import 'package:sigmamenu/screens/widgets/addBannerButton.dart';
import 'package:sigmamenu/screens/widgets/addCategoryButton.dart';
import 'package:sigmamenu/screens/widgets/addProductButton.dart';
import 'package:sigmamenu/screens/widgets/adminPanelBanners.dart';
import 'package:sigmamenu/screens/widgets/deleteCategoryButton.dart';
import 'package:sigmamenu/screens/widgets/userProfile.dart';

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
    widget.menu.listen((whichMenu) {
      mySetState(whichMenu);
    });
    super.initState();
  }

  void mySetState(int whichMenu) {
    if (!mounted) return;

    setState(() {
      item = whichMenu;
    });
  }

  // getUserName() async {
  //   await FirebaseFirestore.instance.collection('users');
  // }

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserState>(context, listen: true).appUser;

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
                              'WELCOME BACK ${user.name} !',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 4),
                            CircleAvatar(
                              backgroundImage: NetworkImage(user.image),
                              // backgroundColor: Colors.brown,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 25),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                EditProfileInformation(),
                Users(),
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
                                  'WELCOME BACK ${user.name} !',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 4),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(user.image),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 25),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 12),
                        CategoriesWithDeleteButton(streamController.stream),
                        AddCategoryButton(),
                      ],
                    ),
                    SizedBox(height: 12),
                    AddProductButton(streamController.stream),
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
                                  'WELCOME BACK ${user.name} !',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 4),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(user.image),
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
