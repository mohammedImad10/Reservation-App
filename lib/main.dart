import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stationj_project/screens/wrapper.dart';
import 'package:stationj_project/services/auth.dart';
import 'package:stationj_project/screens/home/profile.dart';
import 'models/AppUser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return StreamProvider<AppUser>.value(
        value: AuthService().user,
        child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Wrapper(),
      ),
    );
  }
}