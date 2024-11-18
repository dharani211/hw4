import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  void _register() async {
    try {
      final user = await AuthService.register(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        await FirestoreService.saveUserData(
          user.uid,
          _firstNameController.text,
          _lastNameController.text,
          'user',
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name')),
            TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name')),
            TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: Text('Register')),
          ],
        ),
      ),
    );
  }
}
