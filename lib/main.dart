import 'package:e_commers/const%20Widget/color.dart';
import 'package:e_commers/view/home.dart';
import 'package:e_commers/view/login_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // this method used to know state of account
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: prirmyColor,
          iconTheme: IconThemeData(
            color: Colors.white,
          )
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
        )
      ),
      debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser != null ? home():loginScreen(),
      //(FirebaseAuth.instance.currentUser != null || FirebaseAuth.instance.currentUser!.emailVerified)? home():loginScreen(),
    );
  }
}

