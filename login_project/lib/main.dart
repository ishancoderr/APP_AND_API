import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_project/blocs/aut_bloc.dart';
import 'package:login_project/screens/login.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Google SignIn';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => AuthBlock(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: LoginScreen(),
      ),
    );
  }
}
