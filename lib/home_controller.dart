import 'package:flutter/material.dart';
import 'package:flutter_web/page_info.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

import 'common.dart';
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
  //var isRequiredTextFieldController = TextEditingController();
  var validationFieldController = TextEditingController();

  var selectedDropdownValue = ''.obs; // Observable for selected dropdown value
  var selectedIsRequiredValue = ''.obs;
  var selectedActionTypeValue = ''.obs;
  var selectedMethodValue = ''.obs;

  final List<String> dropdownItems = [
    'Text',
    'EditText',
    'Button',
    'Radio Button',
    'Dropdown',
    'Checkbox'
  ]; // Example dropdown options
  final List<String> isRequiredItems = [
    'Yes',
    'No',
  ];
  final List<String> actionTypeItems = [
    'Navigation',
    'API Call',
  ];
  final List<String> methodItems = [
    'GET',
    'POST',
  ];
  void saveData(BuildContext context, PageInfo info) {
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
      else if (selectedDropdownValue.value == 'EditText' &&
          placeholderTextFieldController.text.isEmpty) {
        validationMessage = "Placeholder cannot be empty ";
      }else if ((selectedDropdownValue.value == 'EditText'||
          selectedDropdownValue.value == 'Dropdown' ||
          selectedDropdownValue.value == 'Button' ) &&
          selectedIsRequiredValue.value.isEmpty) {
        validationMessage = selectedDropdownValue.value == 'Button'?"IsEnable cannot be empty ":
        "IsRequired cannot be empty";
      }
      else if ((selectedDropdownValue.value == 'EditText'||
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
        if(selectedActionTypeValue.value == "API Call"){
          if (urlTextFieldController.text.isEmpty) {
            validationMessage = "URL cannot be empty";
          } else if (methodTextFieldController.text.isEmpty) {
            validationMessage = "Method cannot be empty";
          }
        }
        else{
          if (urlTextFieldController.text.isEmpty) {
            validationMessage = "Navigation page name cannot be empty";
          }
        }

      }
      if (validationMessage != null) {
        Common.showFlutterSnackbar(context,validationMessage,Colors.red);
        return; // Stop execution if validation fails
      }

      Map<String, dynamic> data = {
        'Type': selectedDropdownValue.value,
        'Label': labelTextFieldController.text,
        if (selectedDropdownValue.value == 'EditText')
          'Value': valueTextFieldController.text,
        if (selectedDropdownValue.value == 'EditText')
          'Placeholder': placeholderTextFieldController.text,
        if(selectedDropdownValue.value == 'EditText'||
            selectedDropdownValue.value == 'Dropdown' ||
            selectedDropdownValue.value == 'Button')
          'Required': selectedIsRequiredValue.value,
        if(selectedDropdownValue.value == 'EditText'||
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

      _database.child(info.pageRoute.toString()).push().set(data).then((value) {
        labelTextFieldController.clear();
        valueTextFieldController.clear();
        placeholderTextFieldController.clear();
        selectedIsRequiredValue.value = '';
        validationFieldController.clear();
        itemsTextFieldController.clear();
        selectedItemTextFieldController.clear();
        urlTextFieldController.clear();
        methodTextFieldController.clear();
        selectedDropdownValue.value = ''; // Clear the dropdown value
        // Get.snackbar(
        //   "Success",
        //   "Data saved successfully!",
        //   snackPosition: SnackPosition.TOP, // Choose position
        //   duration: const Duration(seconds: 3), // Duration to display
        //   backgroundColor: Colors.green, // Custom background color
        //   colorText: Colors.white, // Text color
        // );

        Common.showFlutterSnackbar(context,"Data saved successfully!",Colors.green);

      }).catchError((error) {
        Common.showFlutterSnackbar(context,"Error saving data",Colors.amber.shade400);
      });
    }



  // void getData() {
  //   Get.to( MyComponentList(pageInfo: ,));
  // }
}
