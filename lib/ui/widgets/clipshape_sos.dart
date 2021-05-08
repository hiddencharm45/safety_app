import 'package:flutter/material.dart';
import 'custom_shape.dart';

class ClipShapeSos extends StatelessWidget {
  final double height;
  final double width;
  final bool medium;
  final bool large;
  ClipShapeSos(this.height, this.width, this.medium, this.large);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height:
                  large ? height / 4 : (medium ? height / 3.75 : height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height:
                  large ? height / 4.5 : (medium ? height / 4.25 : height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: large ? height / 30 : (medium ? height / 25 : height / 20)),
          child: Container(
            height: height / 3.5,
            width: width / 3.5,
            child: RaisedButton(
              splashColor: Colors.black54,
              elevation: 20,
              onPressed: () {},
              shape: CircleBorder(),
              color: Colors.red,
              child: Text(
                "SOS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
