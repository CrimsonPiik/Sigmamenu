import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigmamenu/Authentication/AuthService.dart';
import 'package:sigmamenu/models/user.dart';

class UserState with ChangeNotifier {
  /// [nice]
  String _dateTime = DateTime.now().toIso8601String();
  String get dateTime => _dateTime;

  void setDateTime(String newDate) {
    _dateTime = newDate;
    notifyListeners();
  }

  AppUser _appUser = AppUser();
  AppUser get appUser => _appUser;

  ///To display a spinner if the current state is still authenticating.
  bool _isSigningn = false;
  bool get isSigningIn => _isSigningn;

  ///To notify the app that our user is signed in, then trigger UI changes
  bool _isSignedin = false;
  bool get isSignedin => _isSignedin;

  ///This is the AppUser object that we will be dealing with.
  String _name = '';
  String get name => _name;
  String _email = '';
  String get email => _email;
  String _password = '';
  String get password => _password;

  String _error = '';
  String get error => _error;

  void setAppUser(AppUser newAppUSer) {
    _appUser = newAppUSer;
    _isSignedin = true;
    monitorUserChanges();
  }

  ///This function monitors all local changes and updates firebase accordingly.
  void monitorUserChanges() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(_appUser.id)
        .snapshots()
        .listen((event) {
      Map<String, dynamic>? data = event.data();
      if (data != null) {
        _appUser = AppUser.fromMap(data);
        notifyListeners();
      }
    });
    // updateFcmToken();
  }

  ///Checks if currently signed in user has a different FCM token than the one in firebase, and sets up a stream to listen to changes.
  // void updateFcmToken() async {
  //   String? newfcmToken = await FirebaseMessaging.instance.getToken();
  //   // ignore: unrelated_type_equality_checks
  //   if (newfcmToken != _appUser.fcmToken)
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(_appUser.id)
  //         .update({'fcmToken': newfcmToken});

  //   FirebaseMessaging.instance.onTokenRefresh.listen((event) {
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(_appUser.id)
  //         .update({'fcmToken': event});
  //   });
  // }

  void nameChange(String nameX) async {
    nameX = nameX.trim();
    _name = nameX;
    // if (nameX.length > 3) await StorageProvider().set('hmkName', nameX);
  }

  void emailChange(String emailX) async {
    emailX = emailX.trim();
    _email = emailX;
  }

  void passwordChange(String pwd) async {
    pwd = pwd.trim();
    _password = pwd;
  }

  Future signInWithEmail() async {
    print(email + ' ' + _email);
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } catch (e) {
      print('Email signin Error: ' + e.toString());
      return e;
    }
  }

  Future signUpWithEmail() async {
    print(email + ' ' + _email);
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } catch (e) {
      print('Email signUp Error: ' + e.toString());
      return e;
    }
  }

  Future deleteUser() async {
    print(email + ' ' + _email);
    try {
      return await AuthService().deleteUser('abcdefg@gmail.com', '123456');
    } catch (e) {
      print('Email deleting user Error: ' + e.toString());
      return e;
    }
  }

  notifyListeners();
}
