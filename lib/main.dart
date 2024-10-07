import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'component_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAfl7KJw-mH_fepBvLYbUvZmDYdrpJdA6Y",
      authDomain: "fir-project-1af8e.firebaseapp.com",
      databaseURL: "https://fir-project-1af8e-default-rtdb.firebaseio.com",
      projectId: "fir-project-1af8e",
      storageBucket: "fir-project-1af8e.appspot.com",
      messagingSenderId: "379090306880",
      appId: "1:379090306880:web:5227bafc3ce0461787dca5",
      measurementId: "G-EFXS7F29QM",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Server Driven UI Setting Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  final TextEditingController _labelTextFieldController = TextEditingController();
  final TextEditingController _valueTextFieldController = TextEditingController();
  final TextEditingController _placeholderTextFieldController = TextEditingController();
  final TextEditingController _urlTextFieldController = TextEditingController();
  final TextEditingController _methodTextFieldController = TextEditingController();

  String? _selectedDropdownValue; // To hold selected dropdown value

  final List<String> _dropdownItems = ['Text','TextView', 'Button']; // Example dropdown options

  void _saveData() {
    if (_labelTextFieldController.text.isNotEmpty && _selectedDropdownValue != null) {
      Map<String, dynamic> data = {
        'Type': _selectedDropdownValue,
        'Label': _labelTextFieldController.text,
        // Include value and placeholder only if applicable based on the selected dropdown value
        if (_selectedDropdownValue == 'Text' || _selectedDropdownValue == 'TextView') 'Value': _valueTextFieldController.text,
        if (_selectedDropdownValue == 'TextView') 'Placeholder': _placeholderTextFieldController.text,
        if (_selectedDropdownValue == 'Button') 'Url': _urlTextFieldController.text,
        if (_selectedDropdownValue == 'Button') 'Method': _methodTextFieldController.text,
      };

      _database.child("component").push().set(data).then((_) {
        _labelTextFieldController.clear();
        _valueTextFieldController.clear();
        _placeholderTextFieldController.clear();
        setState(() {
          _selectedDropdownValue = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data saved successfully!")),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving data: $error")),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
    }
  }

  void _getData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyComponentList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Server Driven UI Setting Web'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600), // Restrict width for a web-like appearance
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _selectedDropdownValue,
                        hint: const Text("Select Type"),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDropdownValue = newValue;
                          });
                        },
                        items: _dropdownItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),


                      TextField(
                        controller: _labelTextFieldController ,
                        decoration: InputDecoration(
                          labelText: 'Enter Label',
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Show Label field for all types
                      if (_selectedDropdownValue == 'Text' || _selectedDropdownValue == 'TextView')...[
                        TextField(
                          controller: _valueTextFieldController,
                          decoration: InputDecoration(
                            labelText: 'Enter Value',
                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],

                      // Show Placeholder field only for DropDown
                      if (_selectedDropdownValue == 'TextView') ...[
                        TextField(
                          controller: _placeholderTextFieldController,
                          decoration: InputDecoration(
                            labelText: 'Enter Placeholder',
                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],


                      if (_selectedDropdownValue == 'Button')...[
                        TextField(
                          controller: _urlTextFieldController,
                          decoration: InputDecoration(
                            labelText: 'Enter Url',
                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],


                      if (_selectedDropdownValue == 'Button')...[
                        TextField(
                          controller: _methodTextFieldController,
                          decoration: InputDecoration(
                            labelText: 'Enter Method',
                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                      ],

                      ElevatedButton(
                        onPressed: _saveData,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Add Data', style: TextStyle(fontSize: 18)),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _getData,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.blueGrey,
                        ),
                        child: const Text('Get Data', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



//
// class _HomeScreenState extends State<HomeScreen> {
//   final DatabaseReference _database = FirebaseDatabase.instance.reference();
//
//   final TextEditingController _labelTextFieldController = TextEditingController();
//   final TextEditingController _valueTextFieldController = TextEditingController();
//   final TextEditingController _placeholderTextFieldController = TextEditingController();
//
//   String? _selectedDropdownValue; // To hold selected dropdown value
//
//   final List<String> _dropdownItems = ['TextView', 'Button', 'DropDown']; // Example dropdown options
//
//   void _saveData() {
//     if (_labelTextFieldController.text.isNotEmpty && _selectedDropdownValue != null) {
//       Map<String, dynamic> data = {
//         'Type': _selectedDropdownValue,
//         'Label': _labelTextFieldController.text,
//         'Value': _labelTextFieldController.text,
//       };
//
//       _database.child("component").push().set(data).then((_) {
//         _labelTextFieldController.clear();
//         setState(() {
//           _selectedDropdownValue = null;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Data saved successfully!")),
//         );
//       }).catchError((error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error saving data: $error")),
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill in all fields")),
//       );
//     }
//   }
//
//   void _getData() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const MyComponentList()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Server Driven UI Setting Web'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Container(
//               constraints: const BoxConstraints(maxWidth: 600), // Restrict width for a web-like appearance
//               child: Card(
//                 elevation: 8,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       DropdownButtonFormField<String>(
//                         value: _selectedDropdownValue,
//                         hint: const Text("Select Type"),
//                         decoration: InputDecoration(
//                           contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _selectedDropdownValue = newValue;
//                           });
//                         },
//                         items: _dropdownItems.map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                       const SizedBox(height: 20),
//                       TextField(
//                         controller: _labelTextFieldController,
//                         decoration: InputDecoration(
//                           labelText: 'Enter Label',
//                           contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       TextField(
//                         controller: _valueTextFieldController,
//                         decoration: InputDecoration(
//                           labelText: 'Enter Value',
//                           contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       TextField(
//                         controller: _placeholderTextFieldController,
//                         decoration: InputDecoration(
//                           labelText: 'Enter PlaceHolder',
//                           contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       ElevatedButton(
//                         onPressed: _saveData,
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           backgroundColor: Colors.green,
//                         ),
//                         child: const Text('Add Data', style: TextStyle(fontSize: 18)),
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: _getData,
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           backgroundColor: Colors.blueGrey,
//                         ),
//                         child: const Text('Get Data', style: TextStyle(fontSize: 18)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import 'component_list.dart';
//
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Initialize Firebase
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyAfl7KJw-mH_fepBvLYbUvZmDYdrpJdA6Y",
//       authDomain: "fir-project-1af8e.firebaseapp.com",
//       databaseURL: "https://fir-project-1af8e-default-rtdb.firebaseio.com",
//       projectId: "fir-project-1af8e",
//       storageBucket: "fir-project-1af8e.appspot.com",
//       messagingSenderId: "379090306880",
//       appId: "1:379090306880:web:5227bafc3ce0461787dca5",
//       measurementId: "G-EFXS7F29QM",
//     ),
//   );
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(  // Ensures Directionality is provided
//       title: 'Flutter Web Firebase',
//       home: HomeScreen(),
//     );
//   }
// }
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final DatabaseReference _database = FirebaseDatabase.instance.reference();
//
//   // void _addData() {
//   //   _database.child("component").set({
//   //     'Type': 'TextField',
//   //     'Label': 'USD Amount',
//   //     'Value': '',
//   //     'Placeholder': 'USD Amount (\$)',
//   //   });
//   // }
//
//   // void _addData() {
//   //   // Use push() to add a new child under "component" without overwriting existing data
//   //   _database.child("component").push().set({
//   //     'Type': 'TextField',
//   //     'Label': 'USD Amount',
//   //     'Value': '1000',
//   //     'Placeholder': 'USD Amount (\$)',
//   //   }).then((_) {
//   //     debugPrint("Data added successfully");
//   //   }).catchError((error) {
//   //     debugPrint("Failed to add data: $error");
//   //   });
//   // }
//
//   //final DatabaseReference _database = FirebaseDatabase.instance.ref();
//   final TextEditingController _labelTextFieldController = TextEditingController();
//   final TextEditingController _valueTextFieldController = TextEditingController();
//   final TextEditingController _placeholderTextFieldController = TextEditingController();
//
//   String? _selectedDropdownValue; // To hold selected dropdown value
//
//   final List<String> _dropdownItems = ['TextView', 'Button', 'DropDown']; // Example dropdown options
//
//   void _saveData() {
//     if (_labelTextFieldController.text.isNotEmpty && _selectedDropdownValue != null) {
//       // Create a data map to save
//       Map<String, dynamic> data = {
//         'Type': _selectedDropdownValue,
//         'Label': _labelTextFieldController.text,
//         'Value': _labelTextFieldController.text,
//         'Label': _labelTextFieldController.text,
//
//       };
//
//       // Save to Firebase
//       _database.child("component").push().set(data).then((_) {
//         // Clear the input fields after saving
//         _labelTextFieldController.clear();
//         setState(() {
//           _selectedDropdownValue = null;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data saved successfully!")));
//       }).catchError((error) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error saving data: $error")));
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill in all fields")));
//     }
//   }
//
//   void _getData() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const MyComponentList()),
//     );
//
//     // _database.child("component").once().then((DatabaseEvent event) {
//     //   // Extract the DataSnapshot from the DatabaseEvent
//     //   DataSnapshot snapshot = event.snapshot;
//     //
//     //   // Check if the snapshot contains any data
//     //   if (snapshot.exists) {
//     //     // Accessing the value
//     //     Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
//     //     debugPrint(data.toString()); // You can process this data as needed
//     //   } else {
//     //     debugPrint("No data available");
//     //   }
//     // }).catchError((error) {
//     //   debugPrint("Error retrieving data: $error");
//     // });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Firebase Realtime Database')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DropdownButton<String>(
//                 value: _selectedDropdownValue,
//                 hint: const Text("Select Type"),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedDropdownValue = newValue;
//                   });
//                 },
//                 items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 16.0),
//               TextField(
//                 controller: _labelTextFieldController,
//                 decoration: const InputDecoration(
//                   labelText: 'Enter Label',
//                 ),
//               ),
//
//
//               const SizedBox(height: 16.0),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       foregroundColor: Colors.black
//                   ),
//                   onPressed: _saveData,
//                   child: const Text('Add Data'),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueGrey,
//                     foregroundColor: Colors.black
//                   ),
//                   onPressed: _getData,
//                   child: const Text('Get Data'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //
// //         title: Text('Realtime Database Demo'),
// //       ),
// //       body: Center(
// //         child: StreamBuilder<QuerySnapshot>(
// //           stream: FirebaseFirestore.instance.collection('users').snapshots(),
// //           builder: (context,
// //               snapshot) {
// //         if (!snapshot.hasData) {
// //         return CircularProgressIndicator();
// //         } else {
// //         return ListView(
// //         children: snapshot.data!.docs.map((document)
// //         {
// //         return ListTile(
// //         title: Text(document['name']),
// //         subtitle: Text(document['age'].toString()),
// //
// //         );
// //         }).toList(),
// //         );
// //         }
// //         },
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           final data = <String, dynamic>{
// //             'name': 'Alice',
// //             'age': 25,
// //           };
// //           FirebaseFirestore.instance.collection('users').add(data);
// //         },
// //         child: Icon(Icons.add),
// //       ),
// //     ),
// //     );
// //   }
// // }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'firebase_options.dart'; // Firebase configuration
// //
// // //
// // // void main() async {
// // //   WidgetsFlutterBinding.ensureInitialized();
// // //   await Firebase.initializeApp(
// // //     options: DefaultFirebaseOptions.currentPlatform,
// // //   );
// // //   runApp(const MyApp());
// // // }
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   print("Initializing Firebase...");
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );
// //   print("Firebase initialized.");
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: HomePage(),
// //     );
// //   }
// // }
// //
// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});
// //
// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }
// //
// // class _HomePageState extends State<HomePage> {
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _messageController = TextEditingController();
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //
// //   bool _isLoading = false;
// //   String _status = "";
// //
// //   Future<void> _saveToDatabase() async {
// //     // Check if any field is empty
// //     if (_nameController.text.isEmpty ||
// //         _emailController.text.isEmpty ||
// //         _messageController.text.isEmpty) {
// //       setState(() {
// //         _status = "Please fill in all the required fields.";
// //       });
// //       return;
// //     }
// //
// //     // Set loading state to true
// //     setState(() {
// //       _isLoading = true;
// //       _status = ""; // Clear previous status message
// //     });
// //
// //     try {
// //       // Save the data to Firestore
// //       await _firestore.collection('userMessages').add({
// //         'name': _nameController.text,
// //         'email': _emailController.text,
// //         'message': _messageController.text,
// //         'timestamp': FieldValue.serverTimestamp(), // Automatically set server timestamp
// //       });
// //
// //       // Set success status
// //       setState(() {
// //         _status = "Data saved successfully!";
// //       });
// //     } catch (e) {
// //       // Handle errors and set status message
// //       setState(() {
// //         _status = "Failed to save data: $e";
// //       });
// //     } finally {
// //       // Reset loading state and clear text fields
// //       setState(() {
// //         _isLoading = false;
// //         _nameController.clear();
// //         _emailController.clear();
// //         _messageController.clear();
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Flutter Web Firebase Form"),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             TextField(
// //               controller: _nameController,
// //               decoration: const InputDecoration(labelText: 'Name'),
// //             ),
// //             TextField(
// //               controller: _emailController,
// //               decoration: const InputDecoration(labelText: 'Email'),
// //             ),
// //             TextField(
// //               controller: _messageController,
// //               decoration: const InputDecoration(labelText: 'Message'),
// //             ),
// //             const SizedBox(height: 20),
// //             _isLoading
// //                 ? const CircularProgressIndicator()
// //                 : ElevatedButton(
// //               onPressed: _saveToDatabase,
// //               child: const Text('Submit'),
// //             ),
// //             const SizedBox(height: 20),
// //             Text(_status, style: const TextStyle(color: Colors.red)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
