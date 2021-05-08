//it is a tabs screen basically
import 'package:flutter/material.dart';
import '../model/contacts.dart';
//import 'package:safety_app/ui/signin.dart';
import '../widgets/clipshape_sos.dart';
import 'package:provider/provider.dart';
import '../providers/contact_provider.dart';
import '../widgets/responsive_ui.dart';
import 'add_contact_screen.dart';
import '../widgets/contact_items.dart';

//import '../ui/widgets/textformfield.dart';
class ContactScreen extends StatefulWidget {
  static const routeName = '/contact_screen';
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  //final List<Contacts> _contacts = [];

  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  void _showContacts(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          //print(_height *
          // 0.5); //to give proper value in add contacts for now, later edit with media query
          //print(_width * 0.45);
          // print(_width * 0.1);
          return AddContacts();
        });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    final contacts = Provider.of<ContactProvider>(context);
    return Container(
      height: _height,
      width: _width,
      margin: EdgeInsets.only(bottom: 5),
      child: Column(children: <Widget>[
        //Opacity(opacity: 0.88, child: CustomAppBar()),
        ClipShapeSos(_height, _width, _medium, _large),

        //Text("Contact is this ok?"),
        Container(
          //color: Colors.black,
          height: _height * 0.45,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
                itemCount: contacts.items.length,
                itemBuilder: (_, i) => Column(
                      children: [
                        ContactItem(contacts.items[i].id,
                            contacts.items[i].name, contacts.items[i].number),
                        Divider(),
                      ],
                    )),
          ),
        ),
        Container(
          //color: Colors.black,
          height: _height * 0.1,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), primary: Colors.pinkAccent),
                child: Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Icon(
                    Icons.add,
                    size: 40,
                  ),
                ),
                onPressed: () => _showContacts(context),
              )),
        ),
      ]),
    );
  }
}
