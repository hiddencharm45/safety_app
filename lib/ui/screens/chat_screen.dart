import 'package:flutter/material.dart';
import 'package:safety_app/ui/widgets/messages.dart';
import 'package:safety_app/ui/widgets/new_messages.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "/chat-screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help-Group"),
        backgroundColor: Colors.blue[300],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //expanded ensures list takes only space as needed also maing it scrollable
            Expanded(child: Messages()),
            NewMessage(), //m using a different spelling
          ],
        ),
      ),
    );
  }
}
