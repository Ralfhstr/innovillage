import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:innovillage/pages/splash%20screen/splash_screen.dart';

import 'firebase_options.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: darkblue),
      home: SplashScreen(),
    );
  }
}
