import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MyComponentList extends StatefulWidget {
  const MyComponentList({super.key});

  @override
  _MyComponentListState createState() => _MyComponentListState();
}

class _MyComponentListState extends State<MyComponentList> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<Map<dynamic, dynamic>> _components = [];

  @override
  void initState() {
    super.initState();
    _getData(); // Fetch data when the widget is initialized
  }

  void _getData() {
    _database.child("component").once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          _components = data.entries.map((entry) => {
            'key': entry.key,
            'value': entry.value,
          }).toList();
        });
      } else {
        debugPrint("No data available");
      }
    }).catchError((error) {
      debugPrint("Error retrieving data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Component List"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800), // Restrict the width for web-like appearance
              child: _components.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                children: _components.map((component) {
                  final componentData = component['value'];
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.teal[50], // Light background for the card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Type: ${componentData['Type'] ?? 'No Type'}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800], // Text color for Type
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Label: ${componentData['Label'] ?? 'No Label'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.teal[700], // Text color for Label
                            ),
                          ),
                          if (componentData['Value'] != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  'Value: ${componentData['Value']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.teal[600], // Text color for Value
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
