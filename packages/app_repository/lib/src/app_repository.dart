import 'dart:io';

import 'models/mechanic.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_firestore;
import 'package:http/http.dart' as http;

class AppRepository {
  AppRepository({
    firebase_firestore.FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore =
            firebaseFirestore ?? firebase_firestore.FirebaseFirestore.instance;

  final firebase_firestore.FirebaseFirestore _firebaseFirestore;

  Future<List<Mechanic>> fetchNearbyMechanic() async {
    final query = await _firebaseFirestore.collection("mechanic").get();

    return query.docs.fold<List<Mechanic>>(
      [],
      (previousValue, doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return [...previousValue, Mechanic.fromMap(data)];
      },
    );
  }

  /*
  void getNearbyPlaces({
    required Map<String, dynamic> origin,
  }) async {
    var query = await _firebaseFirestore.collection("mechanic").get();
    var apikey = 'YOUR-API-KEY';
    var filter = query.docs.where((doc) {
      var data = doc.data();
      final String destination = "${data['lat']},${data['lng']}";
      var url = Uri.parse(
          'https://maps.googleapis.com/maps/api/distancematrix/json?origins=${origin['lat']},${origin['lng']}&destinations=$destination&key=$apikey');
      await http.post(url);
      return true;
    });
  }
  */
}
