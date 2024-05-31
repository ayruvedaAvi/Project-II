import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String? descText;
  final String? buttonText;
  const CustomCard({super.key, this.buttonText, this.descText});

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
      color: Colors.blue[200],
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (widget.descText).toString(),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                  ),
                  onPressed: () {
                    print(widget.buttonText);
                  },
                  child: Text(
                    (widget.buttonText).toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
