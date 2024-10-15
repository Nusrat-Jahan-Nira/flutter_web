import 'package:flutter/material.dart';
import 'package:flutter_web/page_info.dart';
import 'package:get/get.dart';
import 'component_controller.dart';




class MyComponentList extends StatelessWidget {

  final pageInfo;
  const MyComponentList({super.key, required this.pageInfo});

  @override
  Widget build(BuildContext context) {
    final ComponentController componentController = Get.put(ComponentController(pageInfo));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Reduced padding
        child: Obx(() {
          return componentController.components.isEmpty
              ? SizedBox(
            height: 100,
            child: Card(
              elevation: 8,
              margin: const EdgeInsets.symmetric(vertical: 5), // Reduced margin
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.teal.shade200, width: 1.5),
              ),
              child: const Center(child: Text('No Data Found')),
            ),
          )
              : Stack(
            alignment: Alignment.center,
            children: [
              // Mobile frame image
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/screen.jpg'), // Path to your mobile frame image
                    fit: BoxFit.fill, // Cover the entire container
                  ),
                ),
                width: double.infinity, // Width of the mobile frame
                height: 600, // Height of the mobile frame
              ),
              // Component list
              Container(
                width: 350, // Match the mobile frame width
                height: 600, // Match the mobile frame height
                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 100.0,bottom: 100.0),  // Padding for content inside the mobile
                child: ListView(
                  children: componentController.components.asMap().map((index, component) {
                    final componentData = Map<String, dynamic>.from(component['value']);
                    return MapEntry(
                      index,
                      Dismissible(
                        key: Key(componentData.toString()), // Use a unique key for each item
                        direction: DismissDirection.endToStart, // Swipe from right to left
                        background: Container(
                          color: Colors.red, // Background color when swiped
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          // Call deleteComponent from the controller
                          componentController.deleteComponent(component['key'].toString(), pageInfo);

                          // Remove the item from the local list
                          componentController.components.removeAt(index);

                          // Show a snackbar to confirm deletion
                          Get.snackbar(
                            'Deleted',
                            '${componentData['Label']} has been deleted',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0), // Padding for content
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch, // Full width for elements
                            children: [
                              _buildComponentWidget(componentData),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).values.toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // A method to build the appropriate widget based on the type
  Widget _buildComponentWidget(Map<String, dynamic> componentData) {
    // Define the decoration to be used by all widgets
    InputDecoration inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5), // Padding inside
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.teal.shade200), // Border color
      ),
      filled: true,
      fillColor: Colors.grey.shade100, // Background color
    );

    switch (componentData['Type']) {
      case 'Text':
        return Center(
          child: Text(
            componentData['Label'],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        );
      case 'EditText':
      // Extracting the data from componentData
        String label = componentData['Label'] ?? 'Label';
        String placeholder = componentData['Placeholder'] ?? 'Enter text here';
        bool isRequired = (componentData['Required'] == 'Yes') ? true : false;
        String validationMsg = componentData['ValidationMsg'] ?? 'This field is required';
        String value = componentData['Value'] ?? '';
        return TextFormField(
          readOnly: false, // Set to true if it's a read-only field
          initialValue: value, // Pre-filled value if available
          decoration: inputDecoration.copyWith(
            labelText: label, // Display label inside the TextFormField
            hintText: placeholder, // Placeholder when the field is empty
          ),
          validator: (text) {
            // Perform validation if required
            if (isRequired && (text == null || text.isEmpty)) {
              return validationMsg; // Show validation message if empty
            }
            return null; // No validation error
          },
        );
      case 'Button':
      // Extract values from componentData
        String buttonLabel = componentData['Label'] ?? 'Button Widget'; // Default label if not provided
        bool isEnabled = componentData['Required'] == 'Yes' || componentData['Required'] == true; // Check for string "Yes" or boolean true
        String url = componentData['Url']; // URL can be used for navigation or actions
        String method = componentData['Method'] ?? ''; // The method can be an action name
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ElevatedButton(
            onPressed: isEnabled
                ? () {
              // Handle the button press
              if (method.isNotEmpty) {
                // Example of handling methods, you might want to implement your logic
                debugPrint('Executing method: $method');
              }
              if (url.isNotEmpty) {
                // Navigate to the URL if applicable
              }
            }
                : null, // If not enabled, the button will be disabled
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: Text(buttonLabel), // Use the label from componentData
          ),
        );

      case 'Radio Button':
      // Extract values from componentData
        String title = componentData['Label'] ?? 'Radio Button Title'; // Default title if not provided
        int selectedValue = componentData['SelectedValue'] ?? 0; // Default selected value
        dynamic itemsData = componentData['Items'];

        List<String> radioOptions = (itemsData is String)
            ? itemsData.split(',').map((item) => item.trim()).toList() // Split string by commas
            : (itemsData is List<String>) ? List<String>.from(itemsData) : [];

        // Check if the selected value is valid, if not set it to the first item's index
        if (selectedValue < 0 || selectedValue >= radioOptions.length) {
          selectedValue = 0; // Default to the first option
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align title to the start
          children: [
            Text(
              title, // Use the title from componentData
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            const SizedBox(height: 8), // Space between title and radio buttons
            Column( // Use Column to stack radio buttons vertically
              children: radioOptions.asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;

                return Row(
                  children: [
                    Radio<int>(
                      value: index, // Assign the index as the value
                      groupValue: selectedValue, // Control which radio is selected
                      onChanged: (value) {
                        // Handle the value change here
                        // Update the selected value in your state management
                        // For example:
                        // setState(() {
                        //   selectedValue = value!;
                        // });
                      },
                    ),
                    Text(option), // Display the option text
                  ],
                );
              }).toList(),
            ),
          ],
        );


      case 'Dropdown':
      // Extracting the data from componentData
        String label = componentData['Label'] ?? 'Select Item'; // Default label if null
        dynamic itemsData = componentData['Items'];

// Preparing the items list
        List<String> items = (itemsData is String)
            ? itemsData.split(',').map((item) => item.trim()).toList() // Split string by commas
            : (itemsData is List<String>) ? List<String>.from(itemsData) : []; // Ensure it's a list, or set as empty

// Add label to items if not already included
        if (!items.contains(label)) {
          items.insert(0, label); // Insert the label at the beginning of the list
        }

        String requiredString = componentData['Required'] ?? 'No';
        bool isRequired = (requiredString == 'Yes') ? true : false;  // Convert "Yes" or "No" to bool
        String validationMsg = componentData['ValidationMsg'] ?? 'This field is required'; // Validation message
        dynamic selectedItem = componentData['SelectedItem'] ;

        if (!items.contains(selectedItem)) {
          // If selectedItem is not in the items list, set to the first item or handle as needed
          selectedItem = items.isNotEmpty ? items[0] : null; // Default to first item if available, or null
        }
        // The currently selected item
        //dynamic value = componentData['Value']; // Default selected value

        // Map the dropdown items to DropdownMenuItem widgets
        List<DropdownMenuItem<dynamic>> dropdownItems = items.map((item) {
          return DropdownMenuItem(
            value: item, // Value of the item (can be the item string itself)
            child: Text(item), // Display label of the item
          );
        }).toList();
        return DropdownButtonFormField(
          value: selectedItem, // Initial selected value
          decoration: InputDecoration(
            labelText: label, // Display the label
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: dropdownItems.isNotEmpty ? dropdownItems : null, // Use items only if not empty
          onChanged: (newValue) {
            selectedItem = newValue; // Update the selected item
          },
          validator: (selectedValue) {
            // Perform validation if required
            if (isRequired && (selectedValue == null || selectedValue.toString().isEmpty)) {
              return validationMsg; // Show validation message if no item is selected
            }
            return null; // No validation error
          },
          hint: const Text('Select an item'), // Placeholder when no item is selected
        );
      case 'Checkbox':
      // Extract values from componentData
        String label = componentData['Label'] ?? 'Checkbox'; // Default label if not provided
        bool checkboxValue = componentData['Value'] == 'True'?true : false; // Default to false if not provided

        return Row(
          children: [
            Checkbox(
              value: checkboxValue, // Bind the value of the checkbox
              onChanged: (value) {
                // Update the state here (if using state management)
                // For example, using GetX:
                // componentController.updateCheckboxValue(value);
              },
            ),
            Expanded( // Use Expanded to allow text to occupy available space
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal[800],
                ),
              ),
            ),
          ],
        );

      default:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade200),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: const Text(
            'Unknown Component Type',
            style: TextStyle(color: Colors.grey),
          ),
        );
    }
  }
}


