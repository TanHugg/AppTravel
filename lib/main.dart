import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/pages/introduce_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('vi_VN', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Initialize Firebase
  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(  //Check state current == state firebase
        future: _initializeFirebase(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return IntroducePage();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

