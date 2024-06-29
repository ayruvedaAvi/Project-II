import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String? descText;
  // final String? buttonText;
  final String? imagePath;
  final String? titleText;

  const CustomCard({super.key, this.descText, this.imagePath, this.titleText});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.imagePath.toString(),
                height: MediaQuery.of(context).size.height * 0.07,
                // width: MediaQuery.of(context).size.width * 0.3,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                (widget.titleText).toString(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                (widget.descText).toString(),
                style: const TextStyle(fontSize: 18),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.blue[50],
              //       ),
              //       onPressed: () {
              //         debugPrint(widget.buttonText);
              //       },
              //       child: Text(
              //         (widget.buttonText).toString(),
              //         style: const TextStyle(fontSize: 18, color: Colors.black),
              //       )),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
