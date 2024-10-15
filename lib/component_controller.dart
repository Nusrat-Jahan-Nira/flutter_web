import 'package:flutter/material.dart';
import 'package:flutter_web/page_info.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class ComponentController extends GetxController {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  var components = <Map<dynamic, dynamic>>[].obs; // Observable list of components

  var pageInfo = PageInfo();

  ComponentController(this.pageInfo) {
    fetchData(pageInfo);
  }

  void fetchData(PageInfo info) {
    _database
        .child(info.pageRoute.toString())
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

  void deleteComponent(String key,PageInfo info) {
    _database.child(info.pageRoute.toString()).child(key).remove().then((_) {
      debugPrint("Component deleted successfully.");
      fetchData(info); // Refresh the data after deletion
    }).catchError((error) {
      debugPrint("Error deleting component: $error");
    });
  }

}
