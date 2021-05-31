//it is a tabs screen basically
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safety_app/utils/contact_utils.dart';

import '../widgets/clipshape_sos.dart';

import '../widgets/responsive_ui.dart';

import '../widgets/contact_items.dart';

class ContactScreen extends StatefulWidget {
  static const routeName = '/contact_screen';
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _user = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('contact');
  // bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  // void _showContacts(BuildContext ctx) {
  //   showModalBottomSheet(
  //       context: ctx,
  //       builder: (_) {
  //         //print(_height *
  //         // 0.5); //to give proper value in add contacts for now, later edit with media query
  //         //print(_width * 0.45);
  //         // print(_width * 0.1);
  //         return AddContacts();
  //       });
  // }

//

  final _scaffoldKey = GlobalKey<ScaffoldState>();
// // @override
  // // void initState() {
  // //   super.initState();

  // //   askContactsPermission();
  // // }

  Future askContactsPermission() async {
    final permission = await ContactUtils.getContactPermission();
    switch (permission) {
      case PermissionStatus.granted:
        uploadContacts();
        break;
      case PermissionStatus.permanentlyDenied:
        print("Permission denied");
        break;
      default:
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: Text('Please allow to "Upload Contacts"'),
            duration: Duration(seconds: 3),
          ),
        );
        break;
    }
  }

  Future uploadContacts() async {
    final contacts = await ContactsService.openDeviceContactPicker();
    //We already have permissions for contact when we get to this page, so we
    // are now just retrieving it

    // Logic to send data to firestore//
    final phoneNum = contacts.phones.map((e) => e.value).toList();
    //collection ref and user defined in the beginning as variable
    collectionReference.doc(_user.uid).collection('allContacts').add({
      'contactName': contacts.givenName,
      'phone': phoneNum[0],
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    // final contacts = Provider.of<ContactProvider>(context);
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

            child: StreamBuilder(
                stream: collectionReference
                    .doc(_user.uid)
                    .collection('allContacts')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                      // reverse: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (_, i) => Column(
                            children: [
                              ContactItem(
                                snapshot.data.docs[i]['contactName'],
                                snapshot.data.docs[i]['phone'],
                                snapshot.data.docs[i].reference,
                              ),
                              //dummy data accepting
                              Divider(),
                            ],
                          ));
                }),
            // child: ListView.builder(
            //     itemCount: contacts.items.length,
            //     itemBuilder: (_, i) => Column(
            //           children: [
            //             ContactItem(contacts.items[i].id,
            //                 contacts.items[i].name, contacts.items[i].number),
            //             //dummy data accepting
            //             Divider(),
            //           ],
            //         )),
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
                // onPressed: () => _showContacts(context),
                onPressed: askContactsPermission,
              )),
        ),
      ]),
    );
  }
}
