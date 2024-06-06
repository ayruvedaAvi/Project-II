import 'package:flutter/material.dart';

class CustomSizedboxButton extends StatefulWidget {
  final IconData? prefixIcon;
  final String? labelText;
  final void Function()? onTap;

  const CustomSizedboxButton(
      {super.key,
      required this.prefixIcon,
      required this.labelText,
      required this.onTap});

  @override
  State<CustomSizedboxButton> createState() => _CustomSizedboxButtonState();
}

class _CustomSizedboxButtonState extends State<CustomSizedboxButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 233, 218, 250),
        ),
        onPressed: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Icon(
                widget.prefixIcon,
                size: 30,
                color: Colors.deepPurple,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                (widget.labelText).toString(),
                style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ]),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.deepPurple,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
