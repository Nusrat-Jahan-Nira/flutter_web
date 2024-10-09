import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

import 'component_list.dart';

class HomeController extends GetxController {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  var labelTextFieldController = TextEditingController();
  var valueTextFieldController = TextEditingController();
  var placeholderTextFieldController = TextEditingController();
  var urlTextFieldController = TextEditingController();
  var methodTextFieldController = TextEditingController();
  var itemsTextFieldController = TextEditingController();
  var selectedItemTextFieldController = TextEditingController();
  var isRequiredTextFieldController = TextEditingController();
  var validationFieldController = TextEditingController();

  var selectedDropdownValue = ''.obs; // Observable for selected dropdown value

  final List<String> dropdownItems = [
    'Text',
    'TextView',
    'Button',
    'Radio Button',
    'Dropdown',
    'Checkbox'
  ]; // Example dropdown options

  void saveData(BuildContext context) {
      String? validationMessage;

      if (selectedDropdownValue.value.isEmpty) {
        validationMessage = "Please select a type.";
      } else if (labelTextFieldController.text.isEmpty) {
        validationMessage = "Label cannot be empty.";
      }
      // else if (selectedDropdownValue.value != 'Text' &&
      //     selectedDropdownValue.value != 'Button' &&
      //     valueTextFieldController.text.isEmpty) {
      //   validationMessage = "Value cannot be empty ";
      //}
      else if (selectedDropdownValue.value == 'TextView' &&
          placeholderTextFieldController.text.isEmpty) {
        validationMessage = "Placeholder cannot be empty ";
      }else if ((selectedDropdownValue.value == 'TextView'||
          selectedDropdownValue.value == 'Dropdown' ||
          selectedDropdownValue.value == 'Button' ) &&
          isRequiredTextFieldController.text.isEmpty) {
        validationMessage = selectedDropdownValue.value == 'Button'?"IsEnable cannot be empty ":
        "IsRequired cannot be empty";
      }
      else if ((selectedDropdownValue.value == 'TextView'||
          selectedDropdownValue.value == 'Dropdown') &&
          validationFieldController.text.isEmpty) {
        validationMessage = "Validation error msg cannot be empty";
      }
      else if ((selectedDropdownValue.value == 'Dropdown'||
          selectedDropdownValue.value == 'Radio Button') &&
          itemsTextFieldController.text.isEmpty) {
        validationMessage = "Items msg cannot be empty";
      }
      else if (selectedDropdownValue.value == 'Dropdown' &&
          selectedItemTextFieldController.text.isEmpty) {
        validationMessage = "Selected dropdown value cannot be empty";
      }
      else if (selectedDropdownValue.value == 'Button') {
        if (urlTextFieldController.text.isEmpty) {
          validationMessage = "URL cannot be empty";
        } else if (methodTextFieldController.text.isEmpty) {
          validationMessage = "Method cannot be empty";
        }
      }
      if (validationMessage != null) {
        showFlutterSnackbar(context,validationMessage,Colors.red);
        return; // Stop execution if validation fails
      }

      Map<String, dynamic> data = {
        'Type': selectedDropdownValue.value,
        'Label': labelTextFieldController.text,
        if (selectedDropdownValue.value != 'Text' &&
            selectedDropdownValue.value != 'Button')
          'Value': valueTextFieldController.text,
        if (selectedDropdownValue.value == 'TextView')
          'Placeholder': placeholderTextFieldController.text,
        if(selectedDropdownValue.value == 'TextView'||
            selectedDropdownValue.value == 'Dropdown' ||
            selectedDropdownValue.value == 'Button')
          'Required': isRequiredTextFieldController.text,
        if(selectedDropdownValue.value == 'TextView'||
            selectedDropdownValue.value == 'Dropdown')
          'ValidationMsg': validationFieldController.text,
        if(selectedDropdownValue.value == 'Dropdown'||
            selectedDropdownValue.value == 'Radio Button')
          'Items': itemsTextFieldController.text,
        if(selectedDropdownValue.value == 'Dropdown')
          'SelectedItem': selectedItemTextFieldController.text,
        if (selectedDropdownValue.value == 'Button') ...{
          'Url': urlTextFieldController.text,
          'Method': methodTextFieldController.text,
        }
      };

      _database.child("component").push().set(data).then((value) {
        labelTextFieldController.clear();
        valueTextFieldController.clear();
        placeholderTextFieldController.clear();
        isRequiredTextFieldController.clear();
        validationFieldController.clear();
        itemsTextFieldController.clear();
        selectedItemTextFieldController.clear();
        urlTextFieldController.clear();
        methodTextFieldController.clear();
        selectedDropdownValue.value = ''; // Clear the dropdown value
        Get.snackbar(
          "Success",
          "Data saved successfully!",
          snackPosition: SnackPosition.TOP, // Choose position
          duration: const Duration(seconds: 3), // Duration to display
          backgroundColor: Colors.green, // Custom background color
          colorText: Colors.white, // Text color
        );

        showFlutterSnackbar(context,"Data saved successfully!",Colors.green);

      }).catchError((error) {
        showFlutterSnackbar(context,"Error saving data",Colors.amber.shade400);
      });
    }

  void showFlutterSnackbar(BuildContext context, String title, Color color) {
    final snackBar = SnackBar(
      content: Text(title),
      backgroundColor: color, // Optional: You can customize the background color
      duration: const Duration(seconds: 3), // How long the snackbar will stay visible
    );

    // Find the Scaffold and show the Snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void getData() {
    Get.to(const MyComponentList());
  }
}
