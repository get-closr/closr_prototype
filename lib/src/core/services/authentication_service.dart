import 'dart:async';

// import 'package:closr_prototype/src/core/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  StreamController<FirebaseUser> _userController =
      StreamController<FirebaseUser>();

  Stream<FirebaseUser> get user => _userController.stream;

  Future<bool> login(String email, String password) async {
    FirebaseUser fetchedUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }
    return hasUser;
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    FirebaseUser fetchedUser = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    fetchedUser.sendEmailVerification();
    return fetchedUser;
  }

  Future<bool> googleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser fetchedUser =
        await _firebaseAuth.signInWithCredential(credential);

    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }
    return hasUser;
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  Future<FirebaseUser> getUser() async => await _firebaseAuth.currentUser();
}
