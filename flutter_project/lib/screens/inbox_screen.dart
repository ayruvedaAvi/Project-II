import 'package:flutter/material.dart';
// import 'package:flutter_project/widgets/custom_chatbubble.dart';

class InboxScreen extends StatefulWidget {
  final String? userName;
  final String? imagePath;
  const InboxScreen({super.key, this.imagePath, this.userName});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.imagePath.toString()),
              radius: 22,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.userName.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        shadowColor: Colors.grey,
      ),
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
          // scrollDirection: axisDirectionToAxis(AxisDirection.up),
          // child: ListView(
          //   children: const [
          //     CustomChatbubble(
          //       text: 'How was the concert?',
          //       isCurrentUser: false,
          //     ),
          //     CustomChatbubble(
          //       text: 'Awesome! Next time you gotta come as well!',
          //       isCurrentUser: true,
          //     ),
          //     CustomChatbubble(
          //       text: 'Ok, when is the next date?',
          //       isCurrentUser: false,
          //     ),
          //     CustomChatbubble(
          //       text: 'They\'re playing on the 20th of November',
          //       isCurrentUser: true,
          //     ),
          //     CustomChatbubble(
          //       text: 'Let\'s do it!',
          //       isCurrentUser: false,
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
