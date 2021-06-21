import 'package:flutter/material.dart';
import 'package:safety_app/ui/screens/notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'contacts_screen.dart';
import 'user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:safety_app/ui/signin.dart';
// import 'package:safety_app/ui/widgets/clipshape_sos.dart';
//import '../widgets/responsive_ui.dart';
//import '../ui/widgets/textformfield.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  String name;
  String email;
  String message;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, Object>> _pages;

  void initializeValues() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String localMessageData = _pref.getString('message');
    if (localMessageData == null) localMessageData = "Write additional message";

    //retrieve name and email of user here & assign to name & email variables
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      debugPrint(value.data().toString());
      widget.name = value.data()['name'];
      widget.email = value.data()['email'];
      widget.message = (value.data()['message'] == null)
          ? localMessageData
          : value.data()['message'];
    });
  }

  @override
  initState() {
    initializeValues();
    _pages = [
      {'page': NotificationScreen(), 'title': "Home"},
      {'page': ContactScreen(), 'title': "Contact"},
      {
        'page': UserProfile(widget.name, widget.email, widget.message),
        'title': "Profile"
      },
      {'page': HomeScreen(), 'title': "Tips"},
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  bool checkBoxValue = false;
  var _body;
  //double _height;
  //double _width;
  //double _pixelRatio;
  //bool _large;
  //bool _medium;
  @override
  Widget build(BuildContext context) {
    _body = _pages[_selectedPageIndex]['page'];
    //_height = MediaQuery.of(context).size.height;
    //_width = MediaQuery.of(context).size.width;
    //_pixelRatio = MediaQuery.of(context).devicePixelRatio;
    //_large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    //_medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Scaffold(
      body: _body,
      drawer: Drawer(
        child: Container(
            padding: EdgeInsets.fromLTRB(12, 60, 5, 5),
            child: Column(
              children: [
                FlatButton(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    return FirebaseAuth.instance.signOut();
                  },
                ),
                FlatButton(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Clear App Data'),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.clear();
                  },
                ),
              ],
            )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.orange[400],
        currentIndex: _selectedPageIndex,
        //it tells that which item is selected
        type: BottomNavigationBarType
            .fixed, //will add a transition and remove bgcolor as well
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Colors.pink[400],
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              //Icons.contact_phone_rounded,
              Icons.phone,
              size: 30,
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.pink[400],
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.pink[400],
            icon: Icon(
              Icons.lightbulb,
              size: 30,
            ),
            label: 'Tips',
          ),
        ],
      ),
    );
  }
}
