import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: false)
              .snapshots(),
      builder: (context, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs!.isEmpty) {
          return Center(
            child: Text(
              "No message found...",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (chatSnapshots.hasError) {
          return Center(
            child: Text(
              "Something went wrong...",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final loadedMessage = chatSnapshots.data!.docs;
        return ListView.builder(
          itemCount: loadedMessage.length,
          itemBuilder: (ctx, index) {
            return Text(
              loadedMessage[index].data()['text'],
              style: TextStyle(color: Colors.white),
            );
          },
        );
      },
    );
  }
}
