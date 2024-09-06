import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Notifications'),
      ),
      body: ListView(
        children: [
          NotificationCard(
            title: 'Titre de ticket',
            subtitle: 'Assigné au formateur Omar jabbie',
            icon: Icons.arrow_downward,
            status: 'Cet tikect est résolu',
          ),
          NotificationCard(
            title: 'Titre de ticket',
            subtitle: 'Assigné au formateur Omar jabbie',
            icon: Icons.arrow_forward,
            status: 'Cet likect est résolu',
          ),
          NotificationCard(
            title: 'Titre de ticket',
            subtitle: 'Assigné au formateur Ali',
            icon: Icons.key,
            status: 'Cet likect est résolu',
          ),
          NotificationCard(
            title: 'Titre de ticket',
            subtitle: 'Assigné au formateur ZAZA',
            icon: Icons.cancel,
            status: 'at ticket est',
          ),
          NotificationCard(
            title: 'Titre de ticket',
            subtitle: 'Assigné au formateur Souleymane',
            icon: Icons.arrow_downward,
            status: 'ticket est en cours',
          ),
          NotificationCard(
            title: 'Titre de ticket',
            subtitle: 'Assigné au formateur AGA',
            icon: Icons.arrow_forward,
            status: 'Cet ticket est résolu',
          ),
          NotificationCard(
            title: 'Password Changed',
            subtitle: 'Asssigné à OLO',
            icon: Icons.key,
            status: 'Cet ticket est en cours',
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String status;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              status,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}