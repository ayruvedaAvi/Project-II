import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(),
          SingleChildScrollView(
            scrollDirection: axisDirectionToAxis(AxisDirection.up),
          ),
        ],
      ),
    );
  }
}
