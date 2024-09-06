import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Demarrage.dart';
import 'package:firstapp/traiter_page.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de Tickets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Demarrage(), // Page d'accueil de l'application
    );
  }
}
