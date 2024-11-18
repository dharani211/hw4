import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class ChatScreen extends StatelessWidget {
  final String boardName;

  ChatScreen({required this.boardName});

  @override
  Widget build(BuildContext context) {
    final _messageController = TextEditingController();

    void _sendMessage(String message) {
      FirestoreService.sendMessage(boardName, message);
      _messageController.clear();
    }

    return Scaffold(
      appBar: AppBar(title: Text(boardName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirestoreService.getMessages(boardName),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return ListTile(
                      title: Text(msg['message']),
                      subtitle: Text('${msg['username']} - ${msg['datetime']}'),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
