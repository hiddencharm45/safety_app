import 'package:flutter/material.dart';
//it is a tabs screen basically

import '../model/contacts.dart';
//import 'package:safety_app/ui/signin.dart';

import 'package:provider/provider.dart';
import '../providers/contact_provider.dart';

class AddContacts extends StatefulWidget {
  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  final _form = GlobalKey<FormState>();
  var _contacts = Contacts(id: null, name: "", number: 0);

  void _saveForm() {
    _form.currentState.save();
    Provider.of<ContactProvider>(context, listen: false).addContact(_contacts);
    Navigator.of(context).pop(); //to close modal sheet
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350, //here I have to adjust the height
      padding: EdgeInsets.all(8.0),
      child: Form(
          key: _form,
          child: ListView(
              //to make items scrollable
              children: <Widget>[
                TextFormField(
                  //initialValue: _initValues[
                  //'title'], //to get already exiting values if we click edit
                  decoration: InputDecoration(labelText: 'Name'),
                  textInputAction: TextInputAction
                      .next, //when clicked on botton right of keyboard it'll goto next element
                  //onFieldSubmitted:(_){
                  //FocusScope.of(context).requestFocus(_priceFocusNode);
                  //}

                  onSaved: (value) {
                    _contacts = Contacts(
                        id: _contacts.id,
                        name: value,
                        number: _contacts.number);
                  },
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                ),
                TextFormField(
                  //initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  textInputAction: TextInputAction
                      .next, //when clicked on botton right of keyboard it'll goto next element
                  //to change the type of keyboard
                  keyboardType: TextInputType.number,
                  //focusNode:_priceFocusNode,
                  //VALIDATE PHONE NUMBER BEFORE SUBMITTING
                  onSaved: (value) {
                    _contacts = Contacts(
                      id: _contacts.id,
                      name: _contacts.name,
                      number: int.parse(value),
                    );
                  },
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                ),
                Spacer(),
                Divider(),
                Container(
                  padding: EdgeInsets.only(left: 186, top: 16, bottom: 16),
                  child: Text("OR"),
                ),
                Container(
                  width: 41.14,
                  height: 50,
                  margin: EdgeInsets.only(
                    top: 8,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    primary: Colors.pink.shade50),
                                onPressed: () {},
                                child: Icon(
                                  Icons.attachment_rounded,
                                  color: Colors.black87,
                                ),
                              )
                              //Icon(Icons.attachment_rounded),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              Text("Will show select contacts from device"),
                              Text("If none selected"),
                              Text("Else diplay name"),
                            ],
                          ),
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16, right: 16),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            primary: Colors.pinkAccent),
                        onPressed: _saveForm,
                        child: Container(
                          width: 80,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Text("Submit",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        )),
                  ),
                )
              ])),
    );
  }
}
