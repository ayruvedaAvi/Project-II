import 'package:flutter/material.dart';

class CustomPostcard extends StatefulWidget {
  final String? profileImg;
  final String? userName;
  final String? workDescription;
  final String? image;
  const CustomPostcard(
      {super.key,
      this.workDescription,
      this.image,
      this.profileImg,
      this.userName});

  @override
  State<CustomPostcard> createState() => _CustomPostcardState();
}

class _CustomPostcardState extends State<CustomPostcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 248, 248, 248),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            ),
            child: ListTile(
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
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: Text(
              "Looking for a Plumber!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 6),
            child: Text(
              widget.workDescription.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.asset(widget.image.toString(), fit: BoxFit.fill),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: Text(
              "Rs. 1000",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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
                    backgroundColor: const Color.fromARGB(255, 168, 105, 227),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Accept",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(
                        width: 2, color: Color.fromARGB(255, 168, 105, 227)),
                    foregroundColor: const Color.fromARGB(255, 168, 105, 227),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 18,
                    ),
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
