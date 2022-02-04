import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _ath;
import 'package:firebase_auth/firebase_auth.dart' as _firebase_auth;
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> signInWithFacebook() async {
  // Trigger the sign-in flow
  final _ath.LoginResult loginResult = await _ath.FacebookAuth.instance.login();
  // Create a credential from the access token
  final _firebase_auth.OAuthCredential facebookAuthCredential =
      _firebase_auth.FacebookAuthProvider.credential(
          loginResult.accessToken.token);

  // Once signed in, return the UserCredential
  _firebase_auth.UserCredential userCredential = await _firebase_auth
      .FirebaseAuth.instance
      .signInWithCredential(facebookAuthCredential);
  _firebase_auth.User user =
      await _firebase_auth.FirebaseAuth.instance.currentUser;
  final graphResponse = await http.get(Uri.parse(
      'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${loginResult.accessToken.token}'));
  print('print(userCredential.user.email);');
  final profile = jsonDecode(graphResponse.body);

  var map = {
    "email": 'fblogin' + profile['email'],
    "uid": user.uid,
    'displayName': user.displayName,
    'phoneNumber': user.phoneNumber
  };

  print(map);

  return map;
}
