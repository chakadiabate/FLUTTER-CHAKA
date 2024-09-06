import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/Principale.dart';
import 'package:flutter/material.dart';

class SoumissionTicketPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _assignedPerson;
  String? _category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soumission de ticket'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'À qui assigner le ticket ?',
              ),
              items: ['Omar Jabbie', 'Fatoumata']
                  .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
                  .toList(),
              onChanged: (value) {
                _assignedPerson = value;
              },
            ),
            SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'), // image de profil
                ),
                title: Text('Omar Jabbie'),
                subtitle: Text('envoyé par CHAKA DIABATE'),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Titre',
                hintText: 'C’est OHLA ?',
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Catégorie',
              ),
              items: ['Technique ', 'Pratique', 'Théorique']
                  .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
                  .toList(),
              onChanged: (value) {
                _category = value;
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Qu’est-ce qui ne va pas ?',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _submitTicket(context);
              },
              child: Text('Soumettre'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitTicket(BuildContext context) {
    if (_assignedPerson != null &&
        _category != null &&
        _titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('tickets').add({
        'assignedPerson': _assignedPerson,
        'category': _category,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'submittedBy': 'CHAKA DIABATE',
        'timestamp': FieldValue.serverTimestamp(),
      }).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Principale()),
        );
      }).catchError((error) {
        print('Erreur lors de la soumission du ticket: $error');
      });
    } else {
      print('Veuillez remplir tous les champs');
    }
  }
}
