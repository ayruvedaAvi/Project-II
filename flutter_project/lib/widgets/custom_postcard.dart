import 'package:flutter/material.dart';
import 'package:flutter_project/screens/singlepost_screen.dart';
// import 'package:flutter_project/utils/constants/colors.dart';
import 'package:get/get.dart';

class CustomPostcard extends StatefulWidget {
  final String? profileImg;
  final String? userName;
  final String? workDescription;
  final String? image;
  final String? title;
  final double? price;
  final String? createdAt;
  final String? jobType;
  const CustomPostcard({
    super.key,
    this.workDescription,
    this.image,
    this.profileImg,
    this.userName,
    this.title,
    this.price,
    this.createdAt,
    this.jobType,
  });

  @override
  State<CustomPostcard> createState() => _CustomPostcardState();
}

class _CustomPostcardState extends State<CustomPostcard> {
  String timeDifference = '';

  @override
  void initState() {
    super.initState();
    calculateTimeDifference();
  }

  void calculateTimeDifference() {
    if (widget.createdAt != null) {
      DateTime createdAtDateTime = DateTime.parse(widget.createdAt!);
      DateTime now = DateTime.now();
      Duration difference = now.difference(createdAtDateTime);

      if (difference.inDays > 0) {
        timeDifference = '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        timeDifference = '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        timeDifference = '${difference.inMinutes} minutes ago';
      } else {
        timeDifference = 'Just now';
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: InkWell(
        onTap: () {
          Get.to(() => SinglepostScreen(
                profileImg: widget.profileImg,
                userName: widget.userName,
                workDescription: widget.workDescription,
                image: widget.image,
                title: widget.title,
                price: widget.price ?? 0.0,
                createdAt: timeDifference,
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Stack(
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
                    subtitle: Text(
                      // widget.createdAt.toString(),
                      timeDifference,
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: const BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                            // topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ) // green shaped
                          ),
                      child: Text(
                        widget.jobType.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(
                widget.image.toString(),
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child:
                        Text("Image for this job was corrupted or not found!"),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Text(
                widget.title.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Text(
                widget.price.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
