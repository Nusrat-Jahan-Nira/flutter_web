import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class ComponentController extends GetxController {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  var components = <Map<dynamic, dynamic>>[].obs; // Observable list of components

  @override
  void onInit() {
    super.onInit();
    fetchData(); // Fetch data when the controller is initialized
  }

  void fetchData() {
    _database
        .child("component")
        .onValue
        .listen((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        components.value = data.entries.map((entry) =>
        {
          'key': entry.key,
          'value': entry.value,
        }).toList();
      } else {
        debugPrint("No data available");
      }
    }).onError((error) {
      debugPrint("Error retrieving data: $error");
    });
  }

  void deleteComponent(String key) {
    _database.child("component").child(key).remove().then((_) {
      debugPrint("Component deleted successfully.");
      fetchData(); // Refresh the data after deletion
    }).catchError((error) {
      debugPrint("Error deleting component: $error");
    });
  }

}
