import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/notification.dart';
import 'package:firstapp/soumission_ticket_screen.dart';
import 'package:flutter/material.dart';

class AccueilPage extends StatelessWidget {
  Future<String?> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null; // Pas d'utilisateur connecté

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return userDoc['role'] as String?;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Erreur: ${snapshot.error}')),
          );
        }

        String? role = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text('Rechercher un ticket'),
            backgroundColor: Color(0xFF673AB7), // Couleur violette
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsPage()),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Résumé des tickets
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'RESOLU',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '20',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'EN COURS',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '200',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Total de tes tickets',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '230',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'En attente',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '10',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                Expanded(
                  child: ListView(
                    children: [
                      // Exemple d'un ticket dans l'historique
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'À: Orange Digital',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Titre: Thié ya keh a kaira djanna no ne ma bie',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'En attente',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: role != 'Formateur'
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SoumissionTicketPage()),
                    );
                  },
                  label: Text(
                    'Soumettre un ticket',
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                  icon: Icon(Icons.edit, color: Colors.orange),
                  backgroundColor: Colors.white,
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
