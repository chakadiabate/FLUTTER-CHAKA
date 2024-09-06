import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Principale.dart';
import 'package:firstapp/login_screen.dart';
import 'package:flutter/material.dart';

class Inscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedRole = 'Apprenant'; // Valeur par défaut

  Future<void> registerUser() async {
    try {
      // Créer un utilisateur avec Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Ajouter des informations supplémentaires dans Firestore, y compris le rôle
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'role': _selectedRole, // Stocker le rôle
      });

      // Naviguer vers la page d'accueil après l'inscription
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Principale()));
    } catch (e) {
      print("Erreur lors de l'inscription : $e");
      // Vous pouvez afficher un message d'erreur à l'utilisateur ici
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
        title: Text('Inscription'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Inscrivez-vous maintenant',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Créer un compte',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmer Mot de passe',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  Text('J\'accepte les termes et conditions'),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_passwordController.text == _confirmPasswordController.text) {
                    await registerUser();
                  } else {
                    print("Les mots de passe ne correspondent pas.");
                    // Afficher un message d'erreur si nécessaire
                  }
                },
                child: Text('S\'inscrire'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
