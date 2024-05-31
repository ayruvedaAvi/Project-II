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
          backgroundColor: const Color.fromARGB(255, 242, 242, 242),
        ),
        onPressed: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Icon(
                widget.prefixIcon,
                color: Colors.black,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                (widget.labelText).toString(),
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ]),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 17,
            ),
          ],
        ),
      ),
    );
  }
}
