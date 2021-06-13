import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);
  final void Function(File pickedImage) imagePickFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  Future<void> _pickImage() async {
    //seperate dialog can be used to select the user choice
    final pickedImageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 60,
      maxWidth: 150,
    ); //to take smaller image fast to upload and as we need a bubble only so it'll do just fine
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return _pickedImage != null
        ? CircleAvatar(
            radius: 65,
            backgroundColor: Colors.black87,
            backgroundImage:
                _pickedImage != null ? FileImage(_pickedImage) : null,
          )
        : SizedBox.fromSize(
            size: Size(90, 90), // button width and height
            child: ClipOval(
              child: Material(
                color: Colors.white, // button color
                child: InkWell(
                  splashColor: Colors.pink[50],
                  onTap: _pickImage,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add_a_photo,
                        size: 36,
                        color: Colors.orange[200],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
