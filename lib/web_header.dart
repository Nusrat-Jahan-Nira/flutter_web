import 'package:flutter/material.dart';

class WebHeader extends StatelessWidget implements PreferredSizeWidget {
  const WebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[800],
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo or App Title
          Row(
            children: [
              Image.asset(
                'assets/images/era_info_logo.jpeg', // Replace with your logo asset path
                height: 40,
              ),
              const SizedBox(width: 10),
              const Text(
                'Server Driven Web',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // Navigation buttons
          Row(
            children: [
              _buildNavButton(context, 'Home', '/home'),
              const SizedBox(width: 20),
              _buildNavButton(context, 'About', '/about'),
              const SizedBox(width: 20),
              _buildNavButton(context, 'Contact', '/contact'),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to create navigation buttons
  Widget _buildNavButton(BuildContext context, String title, String route) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60); // Set header height
}
