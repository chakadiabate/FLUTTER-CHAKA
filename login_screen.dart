import 'package:firstapp/Principale.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Inscription.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth users = FirebaseAuth.instance;
    late String email;
    late String password;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.blue),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Connexion',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              'Bienvenue',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Ajoute la logique pour réinitialiser le mot de passe
                },
                child: Text(
                  'Mot de passe oublié ?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                UserCredential userCredential = await users.signInWithEmailAndPassword(email: email, password: password);

                if (userCredential != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Principale()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Se connecter',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inscription()),
                  );
                },
                child: Text(
                  "je n'ai pas de compte, je m'inscris",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
