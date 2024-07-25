import 'package:flutter/material.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:get/get.dart';

class SinglepostScreen extends StatefulWidget {
  final String? profileImg;
  final String? userName;
  final String? workDescription;
  final String? image;
  final String? title;
  final double? price;
  final String? createdAt;
  final String? jobType;
  const SinglepostScreen({
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
  State<SinglepostScreen> createState() => _SinglepostScreenState();
}

class _SinglepostScreenState extends State<SinglepostScreen> {
  Color getJobTypeColor(String? jobType) {
    final List<Map<String, dynamic>> jobTypeCategories = [
      {'name': 'Technical', 'color': Colors.red},
      {'name': 'Household', 'color': Colors.blue},
      {'name': 'Repair', 'color': Colors.green},
      {'name': 'Construction', 'color': Colors.teal},
      {'name': 'Cleaning', 'color': Colors.purple},
      {'name': 'Gardening', 'color': Colors.orange},
      {'name': 'Cooking', 'color': Colors.indigo},
      {'name': 'Shifting Service', 'color': Colors.brown},
      {'name': 'Others', 'color': Colors.pink},
    ];

    var matchedCategory = jobTypeCategories.firstWhere(
        (category) => category['name'] == jobType,
        orElse: () => {'color': Colors.grey}); // Default color if no match
    return matchedCategory['color'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Post",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 5.0,
        shadowColor: Colors.grey,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            // margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // Container(
                //   decoration: const BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.only(
                //         topRight: Radius.circular(15),
                //         topLeft: Radius.circular(15)),
                //   ),
                //   child: ListTile(
                //     leading: CircleAvatar(
                //       backgroundImage: AssetImage(widget.profileImg.toString()),
                //       radius: 40,
                //     ),
                //     title: Text(
                //       widget.userName.toString(),
                //       style: const TextStyle(
                //           color: Colors.black,
                //           fontWeight: FontWeight.w500,
                //           fontSize: 18),
                //     ),
                //     subtitle: Text(
                //       widget.createdAt.toString(),
                //       style: const TextStyle(color: Colors.black45),
                //     ),
                //   ),
                // ),
                SizedBox(
                  child: Stack(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage(widget.profileImg.toString()),
                          radius: 20,
                        ),
                        title: Text(
                          widget.userName.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          widget.createdAt.toString(),
                          // timeDifference,
                          style: const TextStyle(color: Colors.black45),
                        ),
                      ),
                      // Positioned(
                      //   right: 0,
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(
                      //         vertical: 10, horizontal: 20),
                      //     decoration: const BoxDecoration(
                      //         color: Colors.teal,
                      //         borderRadius: BorderRadius.only(
                      //           topRight: Radius.circular(8),
                      //           bottomLeft: Radius.circular(8),
                      //         ) // green shaped
                      //         ),
                      //     child: const Text(
                      //       "Household",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                          // color: Colors.teal,
                          border: Border.all(
                              color: getJobTypeColor(widget.jobType)),
                          borderRadius: const BorderRadius.all(
                              // topRight: Radius.circular(8),
                              // bottomLeft: Radius.circular(8),
                              Radius.circular(20))),
                      child: Text(
                        "# ${widget.jobType.toString()}",
                        style:
                            TextStyle(color: getJobTypeColor(widget.jobType)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: getJobTypeColor(widget.jobType),
                        ),
                        Text(
                          "Balkumari, Lalitpur",
                          style:
                              TextStyle(color: getJobTypeColor(widget.jobType)),
                        ),
                      ],
                    )
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.title.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    widget.workDescription.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Image.network(
                      widget.image.toString(),
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                              "corruptImage".tr),
                        );
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.price.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: borderButtonColor,
                        ),
                        onPressed: () {},
                        child: Text(
                          "accept".tr,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(
                              width: 2, color: borderButtonColor),
                          foregroundColor: borderButtonColor,
                        ),
                        onPressed: () {},
                        child: Text(
                          "chat".tr,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        )),
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                ]),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
    );
  }
}
