import 'package:flutter/material.dart';

class CustomProfiledetailscard extends StatelessWidget {
  final String? name;
  final String? numCount;
  final IconData? contextIcon;
  final Function onTap;
  const CustomProfiledetailscard(
      {super.key, this.contextIcon, this.name, this.numCount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 143, 69, 211),
            borderRadius: BorderRadius.circular(10)),
        height: 130,
        width: 160,
        child: Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          decoration: BoxDecoration(
              // color: const Color.fromARGB(255, 233, 218, 250),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              // topRight: Radius.circular(10),
              // bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000)
                      .withOpacity(0.5), // Semi-transparent black
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    numCount.toString(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 58, 18, 89),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 192, 146, 238),
                      ),
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Icon(
                        contextIcon,
                        color: const Color.fromARGB(255, 58, 18, 89),
                      )),
                ],
              ),
              Text(
                name.toString(),
                style: const TextStyle(
                    color: Color.fromARGB(255, 58, 18, 89),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
