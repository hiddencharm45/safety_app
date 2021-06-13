import 'package:flutter/material.dart';
import 'package:safety_app/ui/screens/chat_screen.dart';

class NotifItems extends StatelessWidget {
  // const NotifItems({ Key? key }) : super(key: key);
  final String id;
  NotifItems(this.id);
  void _openChat(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      ChatScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(
            right: 20,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          //Remove notif permanently until new one is rendered
        },
        child: InkWell(
          onTap: () => _openChat(context),
          child: Card(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      child: Icon(Icons.chat),
                    ),
                  ),
                ),
                title: Text("Enter Chat-Box"),
                subtitle: Text("Tap To enter the help-group"),
              ),
            ),
          ),
        ));
  }
}
