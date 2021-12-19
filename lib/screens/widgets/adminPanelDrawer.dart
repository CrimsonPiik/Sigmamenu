import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigmamenu/models/user.dart';
import 'package:sigmamenu/provider/userStateProvider.dart';
import 'package:sigmamenu/screens/customerScreen.dart';
import 'package:sigmamenu/screens/home/components/categoriesWithDeleteButton.dart';
import 'package:sigmamenu/screens/widgets/productsAdmin.dart';
import 'package:sigmamenu/screens/home/components/users.dart';
import 'package:sigmamenu/screens/widgets/addBannerButton.dart';
import 'package:sigmamenu/screens/widgets/addCategoryButton.dart';
import 'package:sigmamenu/screens/widgets/addProductButton.dart';
import 'package:sigmamenu/screens/widgets/addUserButton.dart';
import 'package:sigmamenu/screens/widgets/adminPanelBanners.dart';

class AdminPanelDrawer extends StatefulWidget {
  final Stream<int> menu;
  AdminPanelDrawer(this.menu);
  @override
  _AdminPanelDrawerState createState() => _AdminPanelDrawerState();
}

class _AdminPanelDrawerState extends State<AdminPanelDrawer> {
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

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserState>(context, listen: true).appUser;
    return item == 0 //DASHBOARD
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),     
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: CategoriesWithDeleteButton(streamController.stream),
              ),
         
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AddProductButton(streamController.stream),
                  SizedBox(width: 12),
                  AddCategoryButton(),
                ],
              ),
              SizedBox(height: 12),
              ProductsAdmin(streamController.stream),
            ],
          )
        : item == 1 //BANNERS
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  AddBannerButton(),
                  SizedBox(height: 15),
                  AdminPanelBanners()
                ],
              )
            : //USERS
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  user.role == 'admin' ? AddUserButton() : Container(),
                  SizedBox(height: 12),
                  AllUsers(),
                  // user.role == 'admin' ? AllUsers() : MyUser(user: user)
                ],
              );
  }
}
