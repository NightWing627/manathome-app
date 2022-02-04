import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _ath;
import 'package:google_sign_in/google_sign_in.dart';

Future<Map<String, dynamic>> signInWithGoogle() async {
  // Initiate the auth procedure
  final GoogleSignInAccount googleUser =
      await GoogleSignIn(scopes: <String>["email"]).signIn();
  // fetch the auth details from the request made earlier
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  // Create a new credential for signing in with google
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  // Once signed in, return the UserCredential
  UserCredential user =
      await FirebaseAuth.instance.signInWithCredential(credential);
  print(user.toString());
  var map = {
    "email": 'glogin' + user.user.email,
    "uid": user.user.uid,
    'displayName': user.user.displayName,
    'phoneNumber': user.user.phoneNumber
  };
  return map;
}

Future signoutSocials() async {
  try {
    await GoogleSignIn().disconnect();
  } catch (e) {}
  try {
    _ath.FacebookAuth.instance.logOut();
  } catch (err) {}
  await FirebaseAuth.instance.signOut();
}
