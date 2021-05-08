import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/contact_provider.dart';

class ContactItem extends StatelessWidget {
  final String id;
  final String name;
  final int number;
  ContactItem(this.id, this.name, this.number);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        backgroundColor: Colors.pink,
        child: Text(
          name[0].toString().toUpperCase(),
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
                  Provider.of<ContactProvider>(context, listen: false)
                      .deleteContact(id);
                },
                color: Theme.of(context).errorColor),
          ],
        ),
      ),
    );
  }
}
