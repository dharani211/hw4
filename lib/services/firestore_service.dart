import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to get all message boards
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessageBoards() {
    return _firestore.collection('messageBoards').snapshots();
  }

  // Method to retrieve messages from a specific message board
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String boardName) {
    return _firestore
        .collection('messageBoards')
        .doc(boardName)
        .collection('messages')
        .orderBy('datetime', descending: false)
        .snapshots();
  }

  // Method to send a message to a specific message board
  static Future<void> sendMessage(String boardName, String message) async {
    await _firestore
        .collection('messageBoards')
        .doc(boardName)
        .collection('messages')
        .add({
      'message': message,
      'username': 'Anonymous', // Replace with actual username
      'datetime': DateTime.now().toIso8601String(),
    });
  }

  // Method to save user data to Firestore
  static Future<void> saveUserData(
      String uid, String firstName, String lastName, String role) async {
    await _firestore.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'createdAt': DateTime.now(),
    });
  }
}
