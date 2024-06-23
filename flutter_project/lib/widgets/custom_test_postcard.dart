import 'package:flutter/material.dart';
import 'package:flutter_project/screens/singlepost_screen.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:flutter_project/widgets/custom_activeuser_bottomsheet.dart';
import 'package:flutter_project/widgets/custom_otheruser_bottomsheet.dart';
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
  final bool isActiveUser;
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
    this.isActiveUser = false,
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
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            // topLeft: Radius.circular(20), bottomRight: Radius.circular(20),
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000)
                  .withOpacity(0.3), // Semi-transparent black
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ]),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(widget.profileImg.toString()),
                radius: 25,
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
              trailing: widget.isActiveUser
                  ? const CustomActiveuserBottomsheet()
                  : const CustomOtheruserBottomsheet(),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      // color: Colors.teal,
                      border: Border.all(color: Colors.teal),
                      borderRadius: const BorderRadius.all(
                          // topRight: Radius.circular(8),
                          // bottomLeft: Radius.circular(8),
                          Radius.circular(20))),
                  child: Text(
                    "# ${widget.jobType.toString()}",
                    style: const TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
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
                      Text(
                        widget.title.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.workDescription.toString(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 70,
                  // margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      // border: Border.all(color: Colors.teal),
                      borderRadius: const BorderRadius.all(
                          // topRight: Radius.circular(8),
                          // bottomLeft: Radius.circular(8),
                          Radius.circular(10))),
                  child: Row(
                    children: [
                      Text(
                        "Rs ${widget.price.toString()}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "/ work",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Favorite button
                    Container(
                      // margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.chat),
                        // color: Colors.blue,
                        color: mainColor,
                        onPressed: () {
                          // Add favorite action here
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    // Apply now button
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // backgroundColor:
                          //     const Color(0xFF3B4FE4),
                          backgroundColor: borderButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Add apply now action here
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20.0),
                          child: Text(
                            'Apply now',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
