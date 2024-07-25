import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePictureSelectionScreen extends StatefulWidget {
  const ProfilePictureSelectionScreen({super.key});

  @override
  State<ProfilePictureSelectionScreen> createState() =>
      _ProfilePictureSelectionScreenState();
}

class _ProfilePictureSelectionScreenState
    extends State<ProfilePictureSelectionScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,

      // ),
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 70, bottom: 10, right: 10, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Choose profile picture",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                // Profiles
                CircleAvatar(
                  radius: 80,
                  backgroundImage: _image == null
                      ? const AssetImage('assets/images/profile_image.jpg')
                      : FileImage(File(_image!.path)) as ImageProvider,
                ),
                const SizedBox(height: 40),
                // Add profile button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.grey, // <-- Button color
                    // onPrimary: Colors.grey, // <-- Splash color
                  ),
                  onPressed: getImage,
                  child: const Icon(Icons.add, size: 30, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Add profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text('Skip',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text('Next',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
}
