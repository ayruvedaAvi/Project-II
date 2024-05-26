import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final Icon? suffixIcon;
  bool? obscureText;

  CustomTextFormField({
    super.key,
    this.validator,
    this.suffixIcon,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  var isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isVisible,
      cursorColor: Theme.of(context).colorScheme.onPrimary,
      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 20),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        suffixIconColor: Theme.of(context).colorScheme.onPrimary,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: widget.obscureText!? IconButton(
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
        ) : widget.suffixIcon,
      ),
    );
  }
}
