//it is a tabs screen basically
import 'package:flutter/material.dart';
import 'package:safety_app/ui/screens/notification_screen.dart';
// import 'package:safety_app/ui/widgets/clipshape_sos.dart';
import 'home_screen.dart';
//import 'package:safety_app/ui/signin.dart';
import 'contacts_screen.dart';
import 'user_profile.dart';

import '../widgets/responsive_ui.dart';

//import '../ui/widgets/textformfield.dart';
class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, Object>> _pages;
  @override
  initState() {
    _pages = [
      {'page': HomeScreen(), 'title': "Home"},
      {'page': ContactScreen(), 'title': "Contact"},
      {'page': UserProfile(), 'title': "Profile"},
      {'page': NotificationScreen(), 'title': "Notification"},
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
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  @override
  Widget build(BuildContext context) {
    _body = _pages[_selectedPageIndex]['page'];
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Scaffold(
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,

        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink,

        currentIndex: _selectedPageIndex,

        //it tells that which item is selected
        type: BottomNavigationBarType
            .fixed, //will add a transition and remove bgcolor as well
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Colors.pink[400],
            icon: Icon(
              Icons.home_rounded,
              size: 30,
            ),

            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              //Icons.contact_phone_rounded,
              Icons.phone,
              size: 30,
            ),
            title: Text('Contacts'),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.pink[400],
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            title: Text(
              'Profile',
            ),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.pink[400],
            icon: Icon(
              Icons.notification_important_rounded,
              size: 30,
            ),
            title: Text(
              'Notification',
            ),
          ),
        ],
      ),
    );
  }
}
