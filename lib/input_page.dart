
import 'package:flutter/material.dart';
import 'package:flutter_web/add_page_controller.dart';
import 'package:get/get.dart';

class InputPage extends StatelessWidget {
  final AddPageController _controller = Get.put(AddPageController());

  InputPage({super.key});

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

                TextField(
                          controller: _controller.pageLabelTextFieldController,
                          decoration: InputDecoration(
                            labelText: 'Enter Page Name',
                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
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
