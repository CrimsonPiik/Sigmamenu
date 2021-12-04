import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/constaints.dart';
import 'package:sigmamenu/models/user.dart';
import 'package:sigmamenu/screens/home/components/usersCard.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'package:sigmamenu/style/ScreenUtil.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'user')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return CommonUI.loading(context);
          List<DocumentSnapshot> shots = snapshot.data!.docs;
          List<AppUser> usersList = [];
          for (var item in shots) {
            usersList.add(AppUser.fromMap(item.data() as Map<String, dynamic>));
          }
          print("Users : " + usersList.toString());

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                  itemCount: usersList.length,
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
                        child: UsersCard(data: usersList[index]),
                      )),
            ),
          );
        });
  }
}
