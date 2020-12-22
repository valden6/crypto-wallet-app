import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String pwd) async {

  bool auth = false;

  try {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pwd);
    auth = true;
  } catch (e) {
    print(e);
  }
  return auth;
}

Future<bool> register(String email, String pwd) async {
  
  bool auth = false;
  
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pwd);
    auth = true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return auth;
}

Future<bool> addCoin(String id, String amount) async {

  bool res = false;

  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Coins').doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Amount': value});
        res = true;
      } else {
        double newAmount = snapshot.data()['Amount'] + value;
        transaction.update(documentReference, {'Amount': newAmount});
        res = true;
      }
    });
    //res = true;
  } catch (e) {
    print(e);
  }
  return res;
}

Future<bool> removeCoin(String id) async {
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore.instance.collection('Users').doc(uid).collection('Coins').doc(id).delete();
  return true;
}
