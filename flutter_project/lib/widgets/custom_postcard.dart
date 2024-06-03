import 'package:flutter/material.dart';

class CustomPostcard extends StatefulWidget {
  final String? profileImg;
  final String? userName;
  final String? descText;
  final String? postImg;
  const CustomPostcard(
      {super.key, this.descText, this.postImg, this.profileImg, this.userName});

  @override
  State<CustomPostcard> createState() => _CustomPostcardState();
}

class _CustomPostcardState extends State<CustomPostcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 245, 245, 245),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.profileImg.toString()),
              radius: 20,
            ),
            title: Text(
              widget.userName.toString(),
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: const Text(
              "10 hours ago",
              style: TextStyle(color: Colors.black45),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4, left: 4, bottom: 6),
            child: Text(
              widget.descText.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.asset(widget.postImg.toString(), fit: BoxFit.fill),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Accept",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Chat",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
