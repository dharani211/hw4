import 'package:flutter/material.dart';
import 'chat_screen.dart';
import '../services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Boards'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Profile'),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreService.getMessageBoards(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No message boards available.'));
          }

          // Extract message boards
          final boards = snapshot.data!.docs;

          return ListView.builder(
            itemCount: boards.length,
            itemBuilder: (context, index) {
              final board = boards[index].data();
              return ListTile(
                leading: const Icon(Icons.chat),
                title: Text(board['name'] ?? 'Unnamed Board'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(boardName: boards[index].id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
