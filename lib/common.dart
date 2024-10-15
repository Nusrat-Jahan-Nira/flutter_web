import 'package:flutter/material.dart';

class Common{
  static void showFlutterSnackbar(BuildContext context, String title, Color color) {
    final snackBar = SnackBar(
      content: Text(title),
      backgroundColor: color, // Optional: You can customize the background color
      duration: const Duration(seconds: 3), // How long the snackbar will stay visible
    );

    // Find the Scaffold and show the Snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}