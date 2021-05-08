import 'package:flutter/foundation.dart';

class Contacts with ChangeNotifier {
  String id;
  String name;
  int number;
  Contacts({this.id, this.name, this.number});
}
