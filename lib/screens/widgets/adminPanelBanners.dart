import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/GeneralFunction/constaints.dart';
import 'package:sigmamenu/models/banner.dart';
import 'package:sigmamenu/screens/widgets/bannerItem.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

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
          // DateTime.now().millisecondsSinceEpoch.toString());
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                  itemCount: banners.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 3.5)
                          : MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 4)),
                  itemBuilder: (context, index) => Container(
                        // padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: BannersItem(banners[index]),
                      )),
            ),
          );
        });
  }
}
