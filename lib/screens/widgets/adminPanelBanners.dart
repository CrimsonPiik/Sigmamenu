import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constaints.dart';
import 'package:shop_app/models/banner.dart';
import 'package:shop_app/screens/widgets/bannerItem.dart';
import 'package:shop_app/style/CommonUI.dart';
import 'package:shop_app/style/ScreenUtil.dart';

class AdminPanelBanners extends StatefulWidget {
  AdminPanelBanners({Key? key}) : super(key: key);

  @override
  _AdminPanelBannersState createState() => _AdminPanelBannersState();
}

class _AdminPanelBannersState extends State<AdminPanelBanners> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Banner')
            // .where('category', isEqualTo: category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);
          List<BannerModel> banners = [];

          List<DocumentSnapshot> shots = snapshot.data!.docs;
          for (var item in shots) {
            banners
                .add(BannerModel.fromMap(item.data() as Map<String, dynamic>));
          }

          print("Banner - Admin Side : " + banners.toString());
          return Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: GridView.builder(
                  itemCount: banners.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 4)
                          : MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 2.7)
                      //       //               // ScreenUtil.isDesktop(context)
                      //       //               // ? 7
                      //       //               // : ScreenUtil.isTablet(context)
                      //       //               // ? 4
                      //       //               //  : 2,
                      //       //               // mainAxisSpacing: kDefaultPaddin,
                      //       //               // crossAxisSpacing: kDefaultPaddin,
                      // childAspectRatio: 130.0,
                      ),
                  itemBuilder: (context, index) =>
                      //  TextButton.icon(
                      //                   onPressed: () {}, icon: Icon(Icons.add), label: Text('Add')),
                      BannersItem(banners[index]),
                )),
          );
        });
  }
}
