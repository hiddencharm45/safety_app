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
    int j;
    if (pref.getString('num' + count.toString()) == widget.phone)
      pref.remove('num' + count.toString());
    else {
      for (int i = 1; i <= count; i++) {
        String temp = pref.getString('num' + i.toString());
        if (temp == widget.phone) {
          j = i;
          break;
        }
      }
      for (int i = count - 1; i >= j; i--) {
        pref.setString(
            'num' + i.toString(), pref.getString('num' + (i + 1).toString()));
      }
    }
    pref.setInt('count', --count);
    debugPrint("count after deleting: " + count.toString());
  }
}
