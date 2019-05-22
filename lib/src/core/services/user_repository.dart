import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<Null> _ensureLoggedIn() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser == null) {
      print("Not logged in");
    } else {
      print("We are logged into firebase, ${firebaseUser.displayName}");

      if (crossCheckDatabase(firebaseUser) != null) {
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .setData({
          'username': firebaseUser.displayName,
          'id': firebaseUser.uid,
          'email': firebaseUser.email,
        });
      } else {
        print("User exists in database");
      }
    }
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    _ensureLoggedIn();
    return _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> signInWithCredentials(String email, String password) async {
     FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    _ensureLoggedIn();
    return user;
  }


  Future<void> signUp({String email, String password}) async {
    FirebaseUser newuser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    newuser.sendEmailVerification();
    _ensureLoggedIn();
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getUser() async {
    return (await _firebaseAuth.currentUser());
  }

  Future<String> getUserEmail() async {
    return (await _firebaseAuth.currentUser()).email;
  }
  Future<void> deleteUser() async {
    return (await _firebaseAuth.currentUser()).delete();
  }

  Future<bool> crossCheckDatabase(FirebaseUser firebaseUser) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: firebaseUser.uid)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return (documents.length == 0);
  }
}
