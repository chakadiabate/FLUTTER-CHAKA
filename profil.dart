import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  User? user;
  DocumentSnapshot? userDocument;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get user information from Firestore
      userDocument = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Profil'),
          backgroundColor: Color(0xFF0D47A1),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profil'),
        backgroundColor: Color(0xFF0D47A1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileOverview(),
            SizedBox(height: 26),
            _buildProfileSettings(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOverview() {
    String name = userDocument?.get('name') ?? 'Non défini';
    String email = user?.email ?? 'Non défini';
    String photoUrl = user?.photoURL ?? "https://via.placeholder.com/92x92";

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 46,
            backgroundColor: Color(0xFF0D47A1),
            backgroundImage: NetworkImage(photoUrl),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                email,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSettings() {
    String name = userDocument?.get('name') ?? 'Non défini';
    String email = user?.email ?? 'Non défini';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Information personnelle',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildProfileDetailRow('Nom:', name),
          SizedBox(height: 16),
          _buildProfileDetailRow('Email:', email),
          SizedBox(height: 16,)
        ],
      ),
    );
  }

  Widget _buildProfileDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
