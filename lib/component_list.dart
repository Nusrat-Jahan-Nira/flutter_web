import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component_controller.dart';
import 'home_controller.dart'; // Import the HomeController

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart'; // Ensure this still points to the correct file

class MyComponentList extends StatelessWidget {
  const MyComponentList({super.key});

  @override
  Widget build(BuildContext context) {
    final ComponentController componentController = Get.put(ComponentController());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Obx(() {
            return componentController.components.isEmpty
                ? SizedBox(
              height: 100,
              child: Card(
                elevation: 12, // Stronger shadow
                margin: const EdgeInsets.symmetric(vertical: 3),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.teal.shade200, width: 1.5), // Border for the card
                ),
                child: const Center(child: Text('No Data Found')),
              ),
            )
                : Column(
              children: componentController.components.map((component) {
                final componentData = component['value'];
                return Card(
                  elevation: 12, // Stronger shadow
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.teal.shade200, width: 1.5), // Border for the card
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.widgets_outlined, // Example icon
                          color: Colors.teal[700],
                          size: 30,
                        ),
                        const SizedBox(width: 16), // Space between icon and text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type: ${componentData['Type'] ?? 'No Type'}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal[800],
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (componentData['Label'] != null)...[
                                Text(
                                  'Label: ${componentData['Label'] ?? 'No Label'}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.teal[700],
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],

                              if (componentData['Value'] != null)...[
                                Text(
                                  'Value: ${componentData['Value']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal[600],
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],

                              if (componentData['Placeholder'] != null)...[
                                Text(
                                  'Placeholder: ${componentData['Placeholder']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal[600],
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],

                              if (componentData['Required'] != null)...[
                                Text(
                                  'Required: ${componentData['Required']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal[600],
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                              if (componentData['ValidationMsg'] != null)...[
                                Text(
                                  'ValidationMsg: ${componentData['ValidationMsg']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal[600],
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                              if (componentData['Items'] != null) ...[
                                Text(
                                  'Items:',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal[600],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                // Split the Items by comma and create a list of Text widgets with numbering
                                ...componentData['Items']
                                    .replaceAll(',', '') // Remove commas
                                    .split(' ') // Split by spaces (assuming items are separated by spaces)
                                    .asMap() // Convert to a map to get indexes
                                    .entries // Get the entries (index-value pairs)
                                    .map((entry) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    '${entry.key + 1}. ${entry.value.trim()}', // Numbering starts from 1
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.teal[600],
                                    ),
                                  ),
                                ))
                                    .toList(),
                              ],


                              if (componentData['SelectedItem'] != null)...[
                                Text(
                                  'SelectedItem: ${componentData['SelectedItem']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal[600],
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],

                              if (componentData['Url'] != null)...[
                                Text(
                                  'Url: ${componentData['Url']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal[600],
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],

                              if (componentData['Method'] != null)...[
                                Text(
                                  'Method: ${componentData['Method']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.teal[600],
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],


                            ],
                          ),
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red), // Delete icon
                          onPressed: () {
                            componentController.deleteComponent(componentData['key']);
                            // Define the action to delete the item here
                            // For example, you might want to call a function to remove the item from a list
                            // Example: deleteItem(componentData['id']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}


