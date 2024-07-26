import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});
  void _selectLanguage(BuildContext context, String language) {
    // Handle language selection
    print('Selected language: $language');
    // You can navigate to another screen or perform other actions here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Language',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/usa flag.png'),
                ),
                title: const Text(
                  'English (US)',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () => _selectLanguage(context, 'English'),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/nepali flag.png'),
                ),
                title: const Text(
                  'नेपाली (Nepali)',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () => _selectLanguage(context, 'Nepali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
