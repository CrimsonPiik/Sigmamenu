import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigmamenu/models/user.dart';
import 'package:sigmamenu/provider/userStateProvider.dart';
import 'package:sigmamenu/screens/home/home_screen.dart';
import 'package:sigmamenu/screens/widgets/drawer.dart';
import 'package:sigmamenu/style/CommonUI.dart';

class FirebaseUserStreamBuilder extends StatelessWidget {
  const FirebaseUserStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return CommonUI.error(snapshot.error.toString());
              }

              if (snapshot.hasData) if (snapshot.data!.docs.isNotEmpty) {
                Map<String, dynamic> data =
                    snapshot.data!.docs[0].data() as Map<String, dynamic>;
                AppUser appUser = AppUser.fromMap(data);
                if (appUser.isBlocked ||
                    appUser.uid == 'warning' ||
                    appUser.uid == 'null')
                  FirebaseAuth.instance.signOut().then((value) => Text(
                      'Please contact support, your account has been restricted'));

                Provider.of<UserState>(context, listen: false)
                    .setAppUser(appUser);
                // Provider.of<MKHM>(context, listen: false)
                //     .initializeMKHMprovider();

                switch (appUser.role) {
                  case 'user':
                    return HomeScreen();
                  // return EditProfile();

                  case 'admin':
                    return Drawerr();

                  // default:
                  // return AdminPanel();
                }
              }
              //  else {
              //   RhinoFirebaseAuth().createFirebaseUser(
              //       FirebaseAuth.instance.currentUser., 'guest', 'user');
              // }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CommonUI.loading(context),
                );
              }
//  if no users are found, it creates a new user ~Huthaifa
              // if (snapshot.data!.docs.isEmpty) {
              //   FirebaseAuth.instance.signOut();
              // }

              return Drawerr();
            }),
      ),
    );
  }
}
