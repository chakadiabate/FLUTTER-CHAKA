import 'package:firstapp/login_screen.dart';
import 'package:flutter/material.dart';


class Demarrage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket-Zo',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/brandbox.png'),
              ),
              SizedBox(height: 20),
              Text(
                'TICKET-ZO',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                     MaterialPageRoute(builder: (context) => LoginScreen())
                  );
                  // Your action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Cliquez ici pour continuer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}