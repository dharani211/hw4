import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register a new user with email and password
  static Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  // Login an existing user
  static Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Logout the current user
  static Future<void> logout() async {
    await _auth.signOut();
  }
}
