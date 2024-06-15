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
  bool descField;

  CustomTextFormField({
    super.key,
    this.validator,
    this.suffixIcon,
    required this.controller,
    required this.labelText,
    required this.keyType,
    this.hintText,
    this.obscureText = false,
    this.descField = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  var isVisible = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _errorText = null;
    print("yo kaam gardaixa?");
  }

  void _setErrorText(String? errorText) {
    // setState(() {
    //   _errorText = errorText;
    // });

    if (errorText != null) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _errorText = null;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.descField ? 180 : 85,
      child: TextFormField(
        maxLines: widget.descField ? 4 : 1,
        expands: false, //constant for all
        controller: widget.controller,
        validator: (value) {
          final validationResult = widget.validator?.call(value);
          _setErrorText(validationResult);
          return validationResult;
        },
        obscureText: widget.obscureText ? !isVisible : false,
        keyboardType: widget.keyType,
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        cursorHeight: 22,
        style:
            TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 20),
        decoration: InputDecoration(
          errorText: _errorText,
          errorStyle: const TextStyle(color: Colors.red),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                  icon:
                      Icon(isVisible ? Icons.visibility_off : Icons.visibility),
                )
              : widget.suffixIcon,
        ),
      ),
    );
  }
}
