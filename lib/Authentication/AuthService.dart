import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

Future deleteUser(String email, String password) async {
    try {
      User? user =  _auth.currentUser;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      print(user);
      UserCredential result = await user!.reauthenticateWithCredential(credentials);
      await DatabaseService(uid: result.user!.uid).deleteuser(); // called from database class
      await result.user!.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future deleteuser() {
    return userCollection.doc(uid).delete();
  }
}
