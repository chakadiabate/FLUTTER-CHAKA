import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/traiter_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/notification.dart';

class TicketListe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste des tickets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'la liste des tickets'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String?> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null; //Pas d'utilisateur connecté

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
              body: Center(
                child: CircularProgressIndicator(),
              ),
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
              title: Text(widget.title),
              backgroundColor: Color(0xFF5E35B1),
              leading: IconButton(
                onPressed: () {
                  // Action pour le menu
                },
                icon: Icon(Icons.menu),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationsPage()));
                  },
                  icon: Icon(Icons.notifications),
                ),
              ],
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('tickets')
                  .orderBy('timestamp',
                      descending: true) // Tri des tickets par timestamp
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Aucun ticket trouvé.'));
                }

                final tickets = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = tickets[index];
                    return TicketCard(
                      ticketId: ticket.id,
                      formateur: 'À: ${ticket['assignedPerson']}',
                      title: ticket['title'],
                      content: ticket['description'],
                      status:
                          'EN COURS',
                      userRole: role!, // Pass the role to the TicketCard// Vous pouvez ajouter un champ `status` dans Firestore pour suivre l'état.
                    );
                  },
                );
              },
            ),
          );
        });
  }
}

class TicketCard extends StatelessWidget {
  final String ticketId;
  final String formateur;
  final String title;
  final String content;
  final String status;
  final String userRole;

  const TicketCard({
    Key? key,
    required this.ticketId,
    required this.formateur,
    required this.title,
    required this.content,
    required this.status,
    required this.userRole,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formateur,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              content,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.visibility, color: Colors.blue),
                      onPressed: () {
                        _viewTicket(context, content);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        _editTicket(context, ticketId);
                      },
                    ),


                    // Afficher le bouton « Supprimer » uniquement si le rôle de l'utilisateur est Apprenant"
                    if (userRole == 'Apprenant')
                      IconButton(
                         icon: Icon(Icons.delete, color: Colors.red),
                         onPressed: () {
                           _deleteTicket(context, ticketId);
                         },
                       )

                  ],
                ),
                  // New button in the Container to resolve the ticket
                  if( userRole == 'Formateur' )
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        // Action to perform on button press
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> TraiterPage())
                        );
                      },
                      child: Text(
                        'Prendre en charge',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Button color
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: status == 'EN COURS'
                        ? Colors.yellow
                        : status == 'RESOLU'
                            ? Colors.green
                            : Colors.grey[300],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _viewTicket(BuildContext context, String content) {
    // Logique pour afficher les détails d'un ticket
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Voir le ticket"),
        content: Text("Description: $content"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fermer"),
          ),
        ],
      ),
    );
  }

  void _editTicket(BuildContext context, String ticketId) {
    // Logique pour modifier un ticket
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Modifier le ticket"),
        content: Text("Fonction de modification pour le ticket $ticketId"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fermer"),
          ),
        ],
      ),
    );
  }


  void _deleteTicket (BuildContext context, String ticketId) {
    // Logique pour supprimer un ticket de Firebase
    FirebaseFirestore.instance
        .collection('tickets')
        .doc(ticketId)
        .delete()
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ticket supprimé avec succès")),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la suppression du ticket")),
      );
    });
  }
}
