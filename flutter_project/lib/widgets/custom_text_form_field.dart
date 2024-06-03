// import 'dart:js_interop';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final Icon? suffixIcon;
  final TextInputType? keyType;
  bool obscureText;

  CustomTextFormField({
    super.key,
    this.validator,
    this.suffixIcon,
    required this.controller,
    required this.labelText,
    required this.keyType,
    this.hintText,
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
      expands: false, //constant for all
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText ? !isVisible : false,
      keyboardType: widget.keyType,
      cursorColor: Theme.of(context).colorScheme.onPrimary,
      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 20),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: const BorderSide(
              color: Colors.black,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: const BorderSide(
              color: Colors.black,
            )),
        suffixIconColor: Theme.of(context).colorScheme.onPrimary,
        labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
