import 'package:flutter/material.dart';
import 'package:communication/PermissionHandler.dart';
import 'package:communication/HomePage.dart';
import 'package:communication/in_app_webiew_example.screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  
  RemoteNotification? notification = message.notification;
  Map data = message.data;

  print("Terminate: ${notification.hashCode}");
  print('Terminate: ${notification?.title}');
  print('Terminate: ${notification?.body}');

  // HomePage.controller.loadUrl(globals.domain + "/" + data['route']); 
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

       var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
            AndroidServiceWorkerController.instance();

        serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            print(request);
            return null;
          },
        );
      }
    }

  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  PermissionHandler.requestPermission();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'COMMUNICATION',
        theme: ThemeData(
          primarySwatch: Tema,
        ),
        initialRoute: '/',
        routes: {
           '/': (context) => HomePage(),
        });
  }
}

const MaterialColor Tema = const MaterialColor(
  0xFF1B1D21,
  const <int, Color>{
    50: const Color(0xFF1B1D21),
    100: const Color(0xFF1B1D21),
    200: const Color(0xFF1B1D21),
    300: const Color(0xFF1B1D21),
    400: const Color(0xFF1B1D21),
    500: const Color(0xFF1B1D21),
    600: const Color(0xFF1B1D21),
    700: const Color(0xFF1B1D21),
    800: const Color(0xFF1B1D21),
    900: const Color(0xFF1B1D21),
  },
);

