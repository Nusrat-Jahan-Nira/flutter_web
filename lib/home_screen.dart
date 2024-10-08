

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component_list.dart';
import 'home_controller.dart';
import 'web_header.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  HomeScreen({super.key}); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WebHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Server Driven UI Input",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.teal.shade200, width: 1.5),
                          ),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Obx(() => DropdownButtonFormField<String>(
                                  value: _controller.selectedDropdownValue.value.isEmpty ? null : _controller.selectedDropdownValue.value,
                                  hint: const Text("Select Type"),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      _controller.isRequiredTextFieldController.text = '';
                                      _controller.selectedDropdownValue.value = newValue; // Update dropdown value
                                    }
                                  },
                                  items: _controller.dropdownItems.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )),
                                const SizedBox(height: 10),


                                Obx(() {
                                  if (_controller.selectedDropdownValue.value.isNotEmpty) {
                                    return Column(
                                      children: [
                                        TextField(
                                          controller: _controller.labelTextFieldController,
                                          decoration: InputDecoration(
                                            labelText: 'Enter Label',
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }
                                  return Container(); // Return empty container if conditions are not met
                                }),

                                Obx(() {
                                  if (_controller.selectedDropdownValue.value.isNotEmpty
                                  && (_controller.selectedDropdownValue.value != 'Text')&&
                                      (_controller.selectedDropdownValue.value != 'Button')
                                  ) {
                                    return Column(
                                      children: [
                                        TextField(
                                          controller: _controller.valueTextFieldController,
                                          decoration: InputDecoration(
                                            labelText: 'Enter Value',
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }
                                  return Container(); // Return empty container if conditions are not met
                                }),

                                Obx(() {
                                  if (_controller.selectedDropdownValue.value == 'TextView') {
                                    return Column(
                                      children: [
                                        TextField(
                                          controller: _controller.placeholderTextFieldController,
                                          decoration: InputDecoration(
                                            labelText: 'Enter Placeholder',
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }
                                  return Container();
                                }),

                                Obx(() {
                                  if (_controller.selectedDropdownValue.value == 'TextView'||
                                      _controller.selectedDropdownValue.value == 'Dropdown' ||
                                      _controller.selectedDropdownValue.value == 'Button' ) {
                                    return Column(
                                      children: [
                                        TextField(
                                          controller: _controller.isRequiredTextFieldController,
                                          decoration: InputDecoration(
                                            labelText: _controller.selectedDropdownValue.value == 'Button'? 'Is Enable':'Is Required',
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }
                                  return Container(); // Return empty container if conditions are not met
                                }),

                                Obx(() {
                                  if (_controller.selectedDropdownValue.value == 'TextView'||
                                      _controller.selectedDropdownValue.value == 'Dropdown'
                                  ) {
                                    return Column(
                                      children: [
                                        TextField(
                                          controller: _controller.validationFieldController,
                                          decoration: InputDecoration(
                                            labelText: 'Validation error message',
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }
                                  return Container(); // Return empty container if conditions are not met
                                }),

                                Obx(() {
                                  if (_controller.selectedDropdownValue.value == 'Button') {
                                    return Column(
                                      children: [
                                        TextField(
                                          controller: _controller.urlTextFieldController,
                                          decoration: InputDecoration(
                                            labelText: 'Enter Url',
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextField(
                                          controller: _controller.methodTextFieldController,
                                          decoration: InputDecoration(
                                            labelText: 'Enter Method',
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }
                                  return Container();
                                }),

                                Obx(() {
                                  if (_controller.selectedDropdownValue.value == 'Radio Button' ||
                                      _controller.selectedDropdownValue.value == 'Dropdown'
                                  ) {
                                    return Column(
                                      children: [
                                        TextField(
                                          controller: _controller.itemsTextFieldController,
                                          decoration: InputDecoration(
                                            labelText: 'Enter write items with comma separator',
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }
                                  return Container();
                                }),
                                Obx(() {
                                  if (_controller.selectedDropdownValue.value == 'Radio Button') {
                                    return Column(
                                      children: [
                                        TextField(
                                          controller: _controller.selectedItemTextFieldController,
                                          decoration: InputDecoration(
                                            labelText: 'Enter Selected Item',
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  }
                                  return Container();
                                }),

                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed:()=> _controller.saveData(context),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.black87,
                                  ),
                                  child: const Text('Add Data', style: TextStyle(fontSize: 18)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: MyComponentList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}