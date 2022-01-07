import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/screens/staggeredGridView.dart';
import 'package:sigmamenu/style/CommonUI.dart';
import 'getFirebaseUserStream.dart';

class AuthMonitor extends StatelessWidget {
  const AuthMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            return CommonUI.error(snapshot.error.toString());
          }
          if (snapshot.data == null) {
            return StaggerdGridView();
          }
          if (snapshot.data != null) return FirebaseUserStreamBuilder();

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
