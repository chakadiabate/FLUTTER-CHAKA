import 'package:flutter/material.dart';



class discussion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the previous screen
            },
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
              SizedBox(width: 16),
              Text('Ali'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCard(
                      'Enregistrement et connexion des utilisateurs (apprenants et formateurs) via Firebase Authentication.',
                      icon: Icons.person_add,
                    ),
                    SizedBox(height: 16),
                    _buildCard(
                      'Enregistrement et connexion des utilisateurs (apprenants et formateurs) via Firebase Authentication.',
                      icon: Icons.person_add,
                    ),
                    SizedBox(height: 16),
                    _buildCard(
                      'Les tickets peuvent être classés par catégories.',
                      icon: Icons.local_offer,
                    ),
                    SizedBox(height: 16),
                    _buildCard(
                      'Enregistrement et connexion des utilisateurs via Firebase Authentication.',
                      icon: Icons.person_add,
                    ),
                    SizedBox(height: 16),
                    _buildCard(
                      'Enregistrement et connexion des utilisateurs (apprenants et formateurs) via Firebase Authentication.',
                      icon: Icons.person_add,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle floating action button press
          },
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }

  Widget _buildCard(String text, {required IconData icon}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}