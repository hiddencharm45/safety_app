import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'message_bubble.dart';

class Messeges extends StatefulWidget {
  @override
  _MessegesState createState() => _MessegesState();
}

class _MessegesState extends State<Messeges> {
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
            itemBuilder: (ctx, index) => MessegeBubble(
              chatSnapshot.data.docs[index]['text'],
              chatSnapshot.data.docs[index]['userId'] == _user.uid,

              chatSnapshot.data.docs[index]['userImage'],
              chatSnapshot.data.docs[index]['username'],
              // key: ValueKey(chatSnapshot.data.docs[index].documentID),
            ),

            //valuekey is a unique key and use some unique document id
          );
        });
  }
}
