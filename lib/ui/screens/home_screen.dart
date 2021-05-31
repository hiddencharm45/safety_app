//it is a tabs screen basically
import 'package:flutter/material.dart';
import 'package:safety_app/ui/widgets/news_items.dart';
import '../dummy_data.dart';
//import 'package:safety_app/ui/signin.dart';
import '../widgets/clipshape_sos.dart';
import '../widgets/responsive_ui.dart';
//import '../ui/widgets/textformfield.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

          Expanded(
            child: Container(
              height: _height * 0.56,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return NewsItem(
                      Dummy_News[index].title,
                      Dummy_News[index].image,
                      Dummy_News[index].description,
                      Dummy_News[index].id);
                },
                itemCount: Dummy_News.length,
              ),
            ),
          )
        ]));
  }
}
