import 'package:flutter/material.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:flutter_project/widgets/custom_chatlist.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Conversations",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: borderButtonColor,
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        )),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.black,
                    hintText: "Search...",
                    hintStyle: const TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomChatlist(
              userName: "Donald Trump",
              latestMessage: "Haha no problem",
              imagePath: "assets/images/Donald Trump.jpg",
            ),
            const CustomChatlist(
              userName: "Vladimir Putin",
              latestMessage: "Hey there!",
              imagePath: "assets/images/Vladimir Putin.png",
            ),
            const CustomChatlist(
              userName: "Jeffrey Dahmer",
              latestMessage: "How you doing bro?",
              imagePath: "assets/images/boy_image.jpg",
            ),
            const CustomChatlist(
              userName: "Recep Erdogan",
              latestMessage: "Hello sir",
              imagePath: "assets/images/Recep Erdogan.jpg",
            ),
            const CustomChatlist(
              userName: "Xi Jinping",
              latestMessage: "Thank you man!",
              imagePath: "assets/images/Xi Jinping.png",
            ),
            const CustomChatlist(
              userName: "Benjamin Netanyahu",
              latestMessage: "Ok sure",
              imagePath: "assets/images/Benjamin Netanyahu.jpg",
            ),
            const CustomChatlist(
              userName: "Ted Bundy",
              latestMessage: "Why not",
              imagePath: "assets/images/boy_image.jpg",
            ),
            const CustomChatlist(
              userName: "Pedro Lopez",
              latestMessage: "Ok sure",
              imagePath: "assets/images/profile_image.jpg",
            ),
            const CustomChatlist(
              userName: "Ted Bundy",
              latestMessage: "Why not",
              imagePath: "assets/images/boy_image.jpg",
            ),
            const CustomChatlist(
              userName: "Xi Jinping",
              latestMessage: "Thank you man!",
              imagePath: "assets/images/Xi Jinping.png",
            ),
            const CustomChatlist(
              userName: "Benjamin Netanyahu",
              latestMessage: "Ok sure",
              imagePath: "assets/images/Benjamin Netanyahu.jpg",
            ),
            const CustomChatlist(
              userName: "Ted Bundy",
              latestMessage: "Why not",
              imagePath: "assets/images/boy_image.jpg",
            ),
            const CustomChatlist(
              userName: "Pedro Lopez",
              latestMessage: "Ok sure",
              imagePath: "assets/images/profile_image.jpg",
            ),
          ],
        ),
      )),
    );
  }
}
