import 'package:flutter/material.dart';
import '../model/contacts.dart';

class ContactProvider with ChangeNotifier {
  List<Contacts> _items = [
    Contacts(
      id: "c1",
      name: "Ritu Jalan",
      number: 7004043651,
    ),
    Contacts(
      id: "c2",
      name: "Riya Jalan",
      number: 9004043651,
    ),
    Contacts(
      id: "c3",
      name: "Shivam Jalan",
      number: 8004043651,
    ),
  ];
  List<Contacts> get items {
    return [..._items];
  }

  Contacts findById(String id) {
    return _items.firstWhere((contact) => contact.id == id);
  }

  void addContact(Contacts contact) {
    //_items.add(value);
    final newContact = Contacts(
      name: contact.name,
      number: contact.number,
      id: DateTime.now().toString(),
    );
    _items.add(
        newContact); //adds at the end if I want this to be at the beginning
    //I could use _items.insert(0,newProduct)

    notifyListeners();
  }

  void deleteContact(String id) {
    _items.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }
}
