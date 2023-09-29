import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Home Page'),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            color: Colors.white,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ], // Add logout button here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Schedule Appointment'),
              onTap: () {
                // Add navigation or logic for scheduling appointments.
              },
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Upcoming Appointments'),
              onTap: () {
                // Add navigation or logic to view upcoming appointments.
              },
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('Shift Management'),
              onTap: () {
                // Add navigation or logic for shift management.
              },
            ),
            // Add more ListTile widgets for additional options.
          ],
        ),
      ),
    );
  }
}
