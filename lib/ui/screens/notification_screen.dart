//it is a tabs screen basically
import 'package:flutter/material.dart';

//import 'package:safety_app/ui/signin.dart';
import '../widgets/clipshape_sos.dart';

import '../widgets/responsive_ui.dart';

//import '../ui/widgets/textformfield.dart';
class NotificationScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

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
          //Opacity(opacity: 0.88, child: CustomAppBar()),
          ClipShapeSos(_height, _width, _medium, _large),
          Container(
            //color: Colors.black,
            height: _height * 0.56,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                  itemCount: 18,
                  itemBuilder: (_, i) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              child: Text("Notification Handled Here",
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                          Divider(),
                        ],
                      )),
            ),
          ),
        ]));
  }
}
