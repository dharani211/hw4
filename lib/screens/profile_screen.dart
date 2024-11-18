import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          children: [
            Text('Profile Information'),
            ElevatedButton(
              onPressed: () {
                // Add functionality to update user info
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
