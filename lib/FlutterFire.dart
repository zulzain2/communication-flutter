import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:communication/HomePage.dart';


/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class FlutterFire extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _FlutterFireState createState() => _FlutterFireState();
}

class _FlutterFireState extends State<FlutterFire> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        // if (snapshot.hasError) {
        //   return SomethingWentWrong();
        // }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return HomePage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        // return Loading();
        return Container();
      },
    );
  }
}