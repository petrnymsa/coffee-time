import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'core/firebase/authentication.dart';
import 'presentation/shell.dart';
import 'presentation/splash.dart';

///
/// Widget which controls start-up of application
/// Sign-in into Firebase
///
class Bootstrapper extends StatelessWidget {
  final FirebaseAuthProvider authProvider;

  const Bootstrapper({Key key, @required this.authProvider}) : super(key: key);

  Future<void> signIn() async {
    await authProvider.logIn();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            signIn();
          }

          // return SafeArea(
          //     child: Scaffold(
          //         body: FutureBuilder<IdTokenResult>(
          //   future: user.getIdToken(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return SelectableText(snapshot.data.token);
          //     } else {
          //       return Column(
          //         children: <Widget>[
          //           Text('Signed in...'),
          //           CircularProgressIndicator(),
          //         ],
          //       );
          //     }
          //   },
          // )));
          return Shell();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
