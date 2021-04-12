import 'package:flutter/material.dart';

import 'core/firebase/authentication.dart';
import 'presentation/shell.dart';

///
/// Widget which controls start-up of application
/// Sign-in into Firebase
///
class Bootstrapper extends StatelessWidget {
  final FirebaseAuthProvider authProvider;

  const Bootstrapper({Key key, @required this.authProvider}) : super(key: key);

  Future<void> signIn() async {
    //await authProvider.logIn();
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<FirebaseUser>(
    //   stream: FirebaseAuth.instance.onAuthStateChanged,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       final user = snapshot.data;
    //       if (user == null) {
    //         signIn();
    //       }
    //       return Shell();
    //     } else {
    //       return const SplashScreen();
    //     }
    //   },

    return Shell();
  }
}
