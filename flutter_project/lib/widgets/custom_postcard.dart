import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return InkWell(
      onTap: () {
        Get.to(() => const ());
      },
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
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
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(widget.image.toString(), fit: BoxFit.fitHeight),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Text(
                widget.workDescription.toString(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
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
            // const SizedBox(
            //   height: 10,
            // ),
            Row(children: [
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                  child: Text(
                "Balkumari, Lalitpur",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              )),
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
            ]),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
