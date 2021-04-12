import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // FirebaseUser user;
  // IdTokenResult userToken;
  //
  // Future<FirebaseUser> logIn() async {
  //   final result = await _firebaseAuth.signInAnonymously();
  //   user = result.user;
  //
  //   return user;
  // }
  //
  // Future<FirebaseUser> getUser() async => user ?? logIn();
  //
  Future<String> getAuthToken() async {
    // if (userToken == null) {
    //   return _revokeToken();
    // } else if (userToken.expirationTime.compareTo(DateTime.now()) < 0) {
    //   return _revokeToken(refresh: true);
    // }
    //
    // return userToken.token;

    return Future.value("xx");
  }
  //
  // Future<String> _revokeToken({bool refresh = false}) async {
  //   final user = await getUser();
  //   userToken = await user.getIdToken(refresh: refresh);
  //   return userToken.token;
  // }
}
