//it is a tabs screen basically
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safety_app/utils/contact_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  int count;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future askContactsPermission() async {
    final permission = await ContactUtils.getContactPermission();
    switch (permission) {
      case PermissionStatus.granted:
        uploadContacts();
        break;
      case PermissionStatus.permanentlyDenied:
        print("Permission Denied");
        break;
      default:
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: Text('Please Allow to "Upload Contacts"'),
            duration: Duration(seconds: 3),
          ),
        );
        break;
    }
  }

  Future uploadContacts() async {
    // Having allowed the permissions for contacts, we are now retrieving it
    final contacts = await ContactsService.openDeviceContactPicker();
    // Storing contacts to firestore (collectionReference and user defined in the beginning as variable)
    final phoneNum = contacts.phones.map((e) => e.value).toList();
    collectionReference.doc(_user.uid).collection('allContacts').add({
      'contactName': contacts.givenName,
      'phone': phoneNum[0],
      'createdAt': Timestamp.now(),
    });
    // Storing numbers as local data for offline SOS
    SharedPreferences pref = await SharedPreferences.getInstance();
    // Retrieves the number of existing contacts
    count = pref.getInt('count');
    if (count == null) {
      // Sets the number of contact as 0 for the first one
      pref.setInt('count', 0);
      count = 0;
    }
    count++;
    // The naming of the variables is like num1, num2
    pref.setString('num' + count.toString(), phoneNum[0]);
    debugPrint("number added: " + pref.getString('num' + count.toString()));
    pref.setInt('count', count);
    debugPrint("count after adding: " + count.toString());
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Container(
      height: _height,
      width: _width,
      margin: EdgeInsets.only(bottom: 5),
      child: Column(children: <Widget>[
        ClipShapeSos(_height, _width, _medium, _large),
        Container(
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
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (_, i) => Column(
                            children: [
                              ContactItem(
                                snapshot.data.docs[i]['contactName'],
                                snapshot.data.docs[i]['phone'],
                                snapshot.data.docs[i].reference,
                              ),
                              Divider(),
                            ],
                          ));
                }),
          ),
        ),
        Container(
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
                onPressed: askContactsPermission,
              )),
        ),
      ]),
    );
  }
}
