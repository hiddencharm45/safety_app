import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'message_bubble.dart';
//Fetching the user messages from the database

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final _user = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('chat');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: collectionReference
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            reverse: true, //order messeges different
            itemCount: chatSnapshot.data.docs.length,
            itemBuilder: (ctx, index) => MessageBubble(
              chatSnapshot.data.docs[index]['text'],
              chatSnapshot.data.docs[index]['userId'] == _user.uid,
              chatSnapshot.data.docs[index]['userImage'],
              chatSnapshot.data.docs[index]['username'],
              // key: ValueKey(chatSnapshot.data.docs[index].documentID),
            ),
            // valuekey is a unique key and use some unique document id
          );
        });
  }
}
