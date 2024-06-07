import 'package:flutter/material.dart';
import 'package:flutter_project/screens/inbox_screen.dart';
import 'package:get/get.dart';

class CustomChatlist extends StatefulWidget {
  final String? userName;
  final String? latestMessage;
  final String? imagePath;
  const CustomChatlist(
      {super.key, this.latestMessage, this.userName, this.imagePath});

  @override
  State<CustomChatlist> createState() => _CustomChatlistState();
}

class _CustomChatlistState extends State<CustomChatlist> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => InboxScreen(
              userName: widget.userName,
              imagePath: widget.imagePath,
            ));
      },
      leading: CircleAvatar(
        backgroundImage: AssetImage(widget.imagePath.toString()),
        radius: 25,
      ),
      title: Text(
        widget.userName.toString(),
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        widget.latestMessage.toString(),
        style: const TextStyle(color: Colors.black45),
      ),
      trailing: const Icon(
        Icons.check_circle_outline,
        color: Colors.black45,
      ),
    );
  }
}
