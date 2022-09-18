import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('sendTime', descending: true)
          .snapshots(),
      builder: (context,AsyncSnapshot snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snapShot.data!.docs;
        final user= FirebaseAuth.instance.currentUser;
        return ListView.builder(
          itemBuilder: (context, index) => MessageBubble(
            message: docs[index]['text'],
            userName: docs[index]['username'],
            userImage: docs[index]['userImage'],
            isMe: docs[index]['userId']==user!.uid,
            key:  ValueKey(docs[index].id),
          ),
          itemCount: docs.length,
          reverse: true,
        );
      },
    );
  }
}
