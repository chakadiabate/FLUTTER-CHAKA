import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'message',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Entrez votre message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            _buildMessageItem('Ali', 'Ali t\'a envoyé un message'),
            _buildMessageItem('Kalid', 'Kalid t\'a envoyé un message'),
            _buildMessageItem('Omar', 'Omar t\'a envoyé un message'),
            _buildMessageItem('Cheick omar', 'Cheick t\'a envoyé un message'),
            _buildMessageItem('Youssouf', 'Youssouf t\'a envoyé un message'),
            _buildMessageItem('Marcelo', 'Mohamed t\'a envoyé un message'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'profil',
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(String name, String message) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/${name.toLowerCase()}.jpg'), // Assuming you have images in assets
          ),
          SizedBox(width: 10),
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
              SizedBox(height: 5),
              Text(
                message,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}