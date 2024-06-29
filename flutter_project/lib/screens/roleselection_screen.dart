import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/custom_card.dart';

class RoleselectionScreen extends StatefulWidget {
  const RoleselectionScreen({super.key});

  @override
  State<RoleselectionScreen> createState() => _RoleselectionScreenState();
}

class _RoleselectionScreenState extends State<RoleselectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: ClipPath(
          //     clipper: BezierClipper2(),
          //     child: Container(
          //       height: MediaQuery.of(context).size.height / 3,
          //       width: double.infinity,
          //       color: const Color.fromARGB(199, 177, 95, 255),
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Shrami",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Freelance Work.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "On Demand.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: const CustomCard(
                            imagePath: "assets/images/find a service.png",
                            titleText: "Find a Work",
                            descText:
                                "I'm looking for talented people to work with",
                            // buttonText: "A Work Provider",
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: const CustomCard(
                            imagePath: "assets/images/provide a service.png",
                            titleText: "Provide a Work",
                            descText: "I'd like to offer for my work",
                            // buttonText: "A Worker",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    // TextButton(
                    //     onPressed: () {},
                    //     child: const Text('Skip',
                    //         style: TextStyle(
                    //             fontSize: 15, color: Colors.black))),
                    //     TextButton(
                    //         onPressed: () {},
                    //         child: const Text('Sign In',
                    //             style: TextStyle(
                    //                 fontSize: 15, color: Colors.black))),
                    //   ],
                    // ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text('Sign in',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
