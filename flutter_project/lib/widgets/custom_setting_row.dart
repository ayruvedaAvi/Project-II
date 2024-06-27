import 'package:flutter/material.dart';

class CustomSettingRow extends StatefulWidget {
  final IconData? suffixIcon;
  final String? suffixText;
  final IconData? prefixIcon;
  final String? prefixText;
  final bool suffixTextBool;
  final Function? onTap;
  const CustomSettingRow(
      {super.key,
      this.prefixIcon,
      this.prefixText,
      this.suffixIcon,
      this.suffixText,
      this.onTap,
      this.suffixTextBool = false});

  @override
  State<CustomSettingRow> createState() => _CustomSettingRowState();
}

class _CustomSettingRowState extends State<CustomSettingRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // mainAxisAlignment:
            //     MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 20,
              ),
              Icon(
                widget.prefixIcon,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.prefixText.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
          Row(
            children: [
              widget.suffixTextBool
                  ? Text(
                      widget.suffixText.toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                    )
                  : const SizedBox(),
              const SizedBox(
                width: 20,
              ),
              Icon(
                widget.suffixIcon,
                color: Colors.grey,
                size: 15,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
