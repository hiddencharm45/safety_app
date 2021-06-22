import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class SOSEntry {
  Future<int> storeLocation(Placemark placemark) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('sos');
    int count = 0;
    collectionRef
        .where('postalCode', isEqualTo: placemark.postalCode)
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  collectionRef.doc(value.docs.single.id).update({
                    'count': (value.docs.single.data()['count'] + 1)
                  }).then((x) => collectionRef
                      .doc(value.docs.single.id)
                      .collection('users')
                      .add({'uid': FirebaseAuth.instance.currentUser.uid})),
                  count = 1 + value.docs.single.data()['count'],
                  if (count > 5) debugPrint("You've entered red zone")
                }
              else
                {
                  debugPrint("New Pincode Entered"),
                  count = 1,
                  collectionRef.add({
                    'postalCode': placemark.postalCode,
                    'count': 1,
                    'lastSOS': DateTime.now()
                  }).then((value) => collectionRef
                      .doc(value.id)
                      .collection('users')
                      .add({'uid': FirebaseAuth.instance.currentUser.uid})),
                }
            })
        .catchError((onError) => debugPrint(onError.toString()));
    // if (count > 5) {
    //   debugPrint("You've entered red zone");
    // }
    return count;
  }
}
