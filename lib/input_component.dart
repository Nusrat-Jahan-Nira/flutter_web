
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import 'page_info.dart';

class InputComponent extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());
  final PageInfo pageInfo;
  InputComponent({super.key, required this.pageInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  hint: const Text("Select type"),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _controller.selectedIsRequiredValue.value = "";
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
                            labelText: 'Enter label',
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
                      && (_controller.selectedDropdownValue.value == 'EditText')
                  ) {
                    return Column(
                      children: [
                        TextField(
                          controller: _controller.valueTextFieldController,
                          decoration: InputDecoration(
                            labelText: 'Enter default value',
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
                  if (_controller.selectedDropdownValue.value == 'EditText') {
                    return Column(
                      children: [
                        TextField(
                          controller: _controller.placeholderTextFieldController,
                          decoration: InputDecoration(
                            labelText: 'Enter placeholder',
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
                  if (_controller.selectedDropdownValue.value == 'EditText'||
                      _controller.selectedDropdownValue.value == 'Dropdown' ||
                      _controller.selectedDropdownValue.value == 'Button' ) {
                    return Column(
                      children: [
                    DropdownButtonFormField<String>(
                    value: _controller.selectedIsRequiredValue.value.isEmpty ? null : _controller.selectedIsRequiredValue.value,
                      hint: _controller.selectedDropdownValue.value == 'Button'?
                      const Text("Is enable", style: TextStyle(
                        color: Colors.black87
                      ),):
                      const Text("Is required",style: TextStyle(
                          color: Colors.black87
                      )) ,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          _controller.selectedIsRequiredValue.value = newValue; // Update dropdown value
                        }
                      },
                      items: _controller.isRequiredItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                       ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return Container(); // Return empty container if conditions are not met
                }),

                Obx(() {
                  if (_controller.selectedDropdownValue.value == 'EditText'||
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

                        DropdownButtonFormField<String>(
                          value: _controller.selectedActionTypeValue.value.isEmpty ? null : _controller.selectedActionTypeValue.value,
                          hint: const Text("Action Type", style: TextStyle(
                              color: Colors.black87
                          ),),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              _controller.selectedMethodValue.value = "";
                              _controller.selectedActionTypeValue.value = newValue; // Update dropdown value
                            }
                          },
                          items: _controller.actionTypeItems.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),

                        // Display TextFields based on selectedActionTypeValue
                        if (_controller.selectedActionTypeValue.value == 'API Call' ||
                            _controller.selectedActionTypeValue.value == 'Navigation') ...[
                          TextField(
                            controller: _controller.urlTextFieldController,
                            decoration: InputDecoration(
                              labelText: _controller.selectedActionTypeValue.value == 'API Call'?'Enter Url':'Enter navigation page name',
                              hintText: _controller.selectedActionTypeValue.value == 'API Call'?'Please enter your URL':'Please enter your page name',
                              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                        if (_controller.selectedActionTypeValue.value == 'API Call') ...[

                          DropdownButtonFormField<String>(
                            value: _controller.selectedMethodValue.value.isEmpty ? null : _controller.selectedMethodValue.value,
                            hint: const Text("Enter Method", style: TextStyle(
                                color: Colors.black87
                            ),),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                _controller.selectedMethodValue.value = newValue; // Update dropdown value
                              }
                            },
                            items: _controller.methodItems.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                        ],

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
                            labelText: 'Enter items with comma separator',
                            hintText: 'Please write with comma separator (e.g. C,C++,Java)',
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
                  if (_controller.selectedDropdownValue.value == 'Dropdown') {
                    return Column(
                      children: [
                        TextField(
                          controller: _controller.selectedItemTextFieldController,
                          decoration: InputDecoration(
                            labelText: 'Enter selected item',
                            hintText: 'Please enter item from your list',
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
                  onPressed:()=> _controller.saveData(context, pageInfo),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black87,
                  ),
                  child: const Text('Add Data', style: TextStyle(fontSize: 18,)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
