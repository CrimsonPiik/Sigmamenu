import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigmamenu/models/category.dart';
import 'package:sigmamenu/models/user.dart';
import 'package:sigmamenu/provider/userStateProvider.dart';
import 'package:sigmamenu/screens/customerScreen.dart';
import 'package:sigmamenu/screens/widgets/addDashboardButton.dart';
import 'package:sigmamenu/screens/widgets/productOptions.dart';
import 'package:sigmamenu/screens/widgets/addOptionButton.dart';
import 'package:sigmamenu/screens/widgets/editDashboardAdmin.dart';
import 'package:sigmamenu/screens/widgets/productsAdmin.dart';
import 'package:sigmamenu/screens/widgets/supercategories.dart';
import 'package:sigmamenu/screens/widgets/users.dart';
import 'package:sigmamenu/screens/widgets/addBannerButton.dart';
import 'package:sigmamenu/screens/widgets/addCategoryButton.dart';
import 'package:sigmamenu/screens/widgets/addProductButton.dart';
import 'package:sigmamenu/screens/widgets/addUserButton.dart';
import 'package:sigmamenu/screens/widgets/adminPanelBanners.dart';
import 'package:sigmamenu/style/CommonUI.dart';

class AdminPanelDrawer extends StatefulWidget {
  final Stream<int> stream;
  final Stream<int> menu;
  AdminPanelDrawer(this.menu, this.stream);
  @override
  _AdminPanelDrawerState createState() => _AdminPanelDrawerState();
}

class _AdminPanelDrawerState extends State<AdminPanelDrawer> {
  int item = 0;
  String supercategory = superCat.elementAt(0);

  @override
  void initState() {
    widget.menu.listen((whichMenu) {
      mySetState(whichMenu);
    });
    widget.stream.listen((index) {
      mySuperSetState(index);
    });
    super.initState();
  }

  void mySuperSetState(int index) {
    if (!mounted) return;

    setState(() {
      supercategory = superCat.elementAt(index);
    });
  }

  void mySetState(int whichMenu) {
    if (!mounted) return;

    setState(() {
      item = whichMenu;
    });
  }

  // @override
  // void dispose() {
  //   superstreamController.done;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserState>(context, listen: true).appUser; //TODO
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('SuperCategories')
            .doc(supercategory)
            .collection(supercategory)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);

          List<DocumentSnapshot> shots = snapshot.data!.docs;

          for (var item in shots) {
            categoriesList.add(item.id.toString());
          }
          print("Categories : " + categoriesList.toString());

          for (var item in shots) {
            categoriesARnames.add(
                CategoryModel.fromMap(item.data() as Map<String, dynamic>));
          }

          return item == 0 //PRODUCTS
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: SuperCategories(streamController.stream,
                          superstreamController.stream),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    //   child: CategoriesWithDeleteButton(superstreamController.stream),
                    // ),
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
                  : item == 2 //DASHBOARD
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25),
                            AddDashboardButton(),
                            SizedBox(height: 15),
                            EditStaggerdGridView(),
                          ],
                        )
                      : item == 3 // PRODUCT OPTIONS
                          ? ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                SizedBox(height: 25),
                                AddOptionButton(),
                                SizedBox(height: 12),
                                ProductOptions(),
                              ],
                            )
                          : //USERS
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 25),
                                // user.role == 'admin' ? AddUserButton() : Container(),
                                SizedBox(height: 12),
                                AllUsers(),
                                AddUserButton(),
                                // user.role == 'admin' ? AllUsers() : MyUser(user: user)
                              ],
                            );
        });
  }
}
