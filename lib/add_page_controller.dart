import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common.dart';

class AddPageController extends GetxController{
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  var pageLabelTextFieldController = TextEditingController();
  var pageList = <Map<dynamic, dynamic>>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  void saveData(BuildContext context) {
    String? validationMessage;

    if (pageLabelTextFieldController.value.text.isEmpty) {
      validationMessage = "Please enter page name.";
    }

    if (validationMessage != null) {
      Common.showFlutterSnackbar(context,validationMessage,Colors.red);
      return; // Stop execution if validation fails
    }

    Map<String, dynamic> data = {
      'PageName': pageLabelTextFieldController.text,
      'PageRoute': convertToSlug(pageLabelTextFieldController.text)
    };

    _database.child("page-name").push().set(data).then((value) {
      pageLabelTextFieldController.clear();

      Get.snackbar(
        "Success",
        "Data saved successfully!",
        snackPosition: SnackPosition.TOP, // Choose position
        duration: const Duration(seconds: 3), // Duration to display
        backgroundColor: Colors.green, // Custom background color
        colorText: Colors.white, // Text color
      );

      //Common.showFlutterSnackbar(context,"Data saved successfully!",Colors.green);

    }).catchError((error) {
      Common.showFlutterSnackbar(context,"Error saving data",Colors.amber.shade400);
    });
  }

  String convertToSlug(String input) {
    return input.toLowerCase().replaceAll(' ', '-');
  }

  void fetchData() {
    _database
        .child("page-name")
        .onValue
        .listen((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        pageList.value = data.entries.map((entry) =>
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
    _database.child("page-name").child(key).remove().then((_) {
      debugPrint("Component deleted successfully.");
      fetchData(); // Refresh the data after deletion
    }).catchError((error) {
      debugPrint("Error deleting component: $error");
    });
  }

}