import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';
import 'package:sigmamenu/models/user.dart';
import 'package:sigmamenu/style/AssetsManager.dart';

class ProjectFirebaseAuth {
  Future resetEmailPassword(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<dynamic> registerWithEmail(
    String email,
    String password,
  ) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => value);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return (e);
    }
  }

  Future anonymousSignin() async {
    return await FirebaseAuth.instance.signInAnonymously().then((value) async =>
        await createFirebaseUser(value, 'guestAccount', 'user', 'phone'));
  }

  Future<dynamic> createFirebaseUser(
    UserCredential userCredential,
    String? name,
    String? role,
    String? phone,
  ) async {
    AppUser _appUser = AppUser();
    User userData = userCredential.user!;
    _appUser.uid = userData.uid;
    _appUser.id = generateId();
    _appUser.name = userData.displayName ?? name ?? 'userName';
    _appUser.phone = userData.phoneNumber ?? phone ?? 'phone';
    _appUser.email = userData.email ?? 'email';
    _appUser.image = userData.photoURL ?? ImageAssets.user;
    _appUser.role = role ?? 'user';

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: _appUser.uid)
          .get()
          .then(
        (value) async {
          if (value.docs.isEmpty)
            try {
              return await FirebaseFirestore.instance
                  .collection('users')
                  .doc(_appUser.id)
                  .set(
                    _appUser.toMap(),
                  )
                  .then((value) => FirebaseFirestore.instance
                      .collection('users')
                      .doc(_appUser.id)
                      .update(
                        _appUser.toMap(),
                      ))
                  .then((value) => true);
            } catch (e) {
              return (e);
            }
        },
      );
    } catch (e) {
      return (e);
    }
  }

  login(String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    } catch (e) {
      return (e);
    }
  }

  // Future<UserCredential> googleSignIn() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser!.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  // Future googleLogout() async {
  //   await GoogleSignIn().signOut();
  // }

  // Future signInWithGoogle() async {
  //   try {
  //     return await googleSignIn().then(
  //       (value) async =>
  //           await createFirebaseUser(value, 'google', 'user', 'phone'),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     throw (e);
  //   } catch (e) {
  //     throw (e);
  //   }
  // }

  // Future<UserCredential> signInWithFacebook() async {
  //   FacebookAuthProvider facebookProvider = FacebookAuthProvider();
  //   facebookProvider.addScope('email');
  //   facebookProvider.setCustomParameters({
  //     'display': 'popup',
  //   });
  //   return await FirebaseAuth.instance.signInWithPopup(facebookProvider);
  //   // Or use signInWithRedirect
  //   // return await FirebaseAuth.instance.signInWithRedirect(facebookProvider);
  // }
}
