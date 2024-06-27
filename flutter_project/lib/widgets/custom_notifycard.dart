import 'package:flutter/material.dart';

class CustomNotifycard extends StatelessWidget {
  final String? message;
  const CustomNotifycard({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(right: 10.0, left: 10, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile_image.jpg'),
            radius: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.toString(),
                  style: const TextStyle(fontSize: 16.0),
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '08:39 AM',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
