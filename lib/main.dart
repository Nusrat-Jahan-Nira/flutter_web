import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'add_page_screen.dart';
import 'component_list.dart';
import 'home_screen.dart';
import 'web_header.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAfl7KJw-mH_fepBvLYbUvZmDYdrpJdA6Y",
      authDomain: "fir-project-1af8e.firebaseapp.com",
      databaseURL: "https://fir-project-1af8e-default-rtdb.firebaseio.com",
      projectId: "fir-project-1af8e",
      storageBucket: "fir-project-1af8e.appspot.com",
      messagingSenderId: "379090306880",
      appId: "1:379090306880:web:5227bafc3ce0461787dca5",
      measurementId: "G-EFXS7F29QM",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Server Driven UI Setting Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  const AddPageScreen(),
    );
  }
}






