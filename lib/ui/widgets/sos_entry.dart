import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class SOSEntry {
  storeLocation(Placemark placemark) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('sos');
    int count;
    collectionRef
        .where('postalCode', isEqualTo: placemark.postalCode)
        .get()
        .then((value) => {
              collectionRef.doc(value.docs.first.id).update({
                'count': (value.docs.first.data()['count'] + 1)
              }).then((val) => collectionRef
                  .doc(value.docs.first.id)
                  .collection('users')
                  .add({'uid': FirebaseAuth.instance.currentUser.uid})),
              count = value.docs.first.data()['count'],
            })
        .catchError((onError) {
      debugPrint("New Pincode Entered");
      count = 1;
      collectionRef.add({
        'postalCode': placemark.postalCode,
        'count': 1,
        'lastSOS': DateTime.now()
      }).then((value) => collectionRef
          .doc(value.id)
          .collection('users')
          .add({'uid': FirebaseAuth.instance.currentUser.uid}));
    });
    if (count > 5) debugPrint("You've entered red zone");
  }
}
