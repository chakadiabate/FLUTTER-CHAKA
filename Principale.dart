import 'package:firstapp/accueil_screen.dart';
import 'package:firstapp/message.dart';
import 'package:firstapp/profil.dart';
import 'package:firstapp/ticket_liste.dart';
import 'package:flutter/material.dart';

class Principale extends StatefulWidget {
  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<Principale> {
  int _selectedIndex = 0;

  // Liste des pages que vous souhaitez afficher dans le BottomNavigationBar
  final List<Widget> _pages = [
    AccueilPage(),   // Remplacez par votre page d'accueil ou une autre page
    TicketListe(),   // Remplacez par la page de chat
    Message(),
    ProfilPage(),    // Remplacez par la page de profil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Afficher la page en fonction de l'index sélectionné
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Changez la couleur de fond ici
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Color(0xFF9598A6), // Vous pouvez également changer la couleur des icônes non sélectionnées ici
        onTap: _onItemTapped, // Appeler la fonction de gestion des taps
      ),
    );
  }
}
