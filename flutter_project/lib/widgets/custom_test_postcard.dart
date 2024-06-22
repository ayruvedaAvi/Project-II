import 'package:flutter/material.dart';
import 'package:flutter_project/screens/singlepost_screen.dart';
import 'package:get/get.dart';

class CustomTestPostcard extends StatefulWidget {
  final String? profileImg;
  final String? userName;
  final String? workDescription;
  final String? image;
  final String? title;
  final double? price;
  final String? createdAt;
  final String? jobType;
  const CustomTestPostcard({
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
  State<CustomTestPostcard> createState() => _CustomTestPostcardState();
}

class _CustomTestPostcardState extends State<CustomTestPostcard> {
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
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000)
                  .withOpacity(0.2), // Semi-transparent black
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ]),
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
        child: Column(children: [
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
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 180,
                height: 250,
                child: Image.network(
                  widget.image.toString(),
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                          "Image for this job was corrupted or not found!"),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.price.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Balkumari, Lalitpur",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 168, 105, 227),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Accept",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ],
                ),
              )
            ],
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          //   child: Text(
          //     widget.title.toString(),
          //     style:
          //         const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          //   child: Text(
          //     widget.price.toString(),
          //     style:
          //         const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Row(children: [
          //   const SizedBox(
          //     width: 10,
          //   ),
          //   const Expanded(
          //       child: Text(
          //     "Balkumari, Lalitpur",
          //     style: TextStyle(color: Colors.grey, fontSize: 18),
          //   )),
          //   const SizedBox(
          //     width: 10,
          //   ),
          //   Expanded(
          //     child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: const Color.fromARGB(255, 168, 105, 227),
          //         ),
          //         onPressed: () {},
          //         child: const Text(
          //           "Accept",
          //           style: TextStyle(fontSize: 18, color: Colors.white),
          //         )),
          //   ),
          //   const SizedBox(
          //     width: 10,
          //   ),
        ]),
      ),
    );
  }
}
