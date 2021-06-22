import 'package:flutter/material.dart';
import '../widgets/responsive_ui.dart';
//will copy and make a clone

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final bool isReadOnly;
  final Color bgColor;
  final String initialValue;
  final Function(String) onSaved;

  CustomTextField({
    this.initialValue,
    this.hint,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.bgColor,
    this.isReadOnly = false,
    this.obscureText = false,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    bool large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    bool medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      color: bgColor,
      child: TextFormField(
        initialValue: initialValue,
        readOnly: isReadOnly,
        controller: textEditingController,
        keyboardType: keyboardType,
        onSaved: onSaved,
        cursorColor: Colors.orange[200],
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black45, size: 20),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
