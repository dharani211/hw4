import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              // Add change password functionality
            },
          ),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              AuthService.logout();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
