import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactItem extends StatefulWidget {
  final String name;
  final String phone;
  final DocumentReference ref;

  ContactItem(this.name, this.phone, this.ref);

  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      leading: CircleAvatar(
        backgroundColor: Colors.pink,
        child: Text(
          widget.name[0].toString().toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      trailing: Container(
        //color: Colors.black,
        width: 50,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.ref.delete();
                  deleteLocal();
                },
                color: Theme.of(context).errorColor),
          ],
        ),
      ),
    );
  }

  void deleteLocal() async {
    // Code for deleting contacts from Local data
    SharedPreferences pref = await SharedPreferences.getInstance();
    int count = pref.getInt('count');
    for (int i = 1; i <= count; i++) {
      String temp = pref.getString('num' + i.toString());
      if (temp == widget.phone) {
        pref.remove('num' + i.toString());
        debugPrint(temp);
      }
    }
    debugPrint(count.toString());
    pref.setInt('count', --count);
  }
}
