import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  
  String Function(dynamic val) ?validator;
  
   AuthField(
      {super.key,
      required this.hintText,
      required this.prefixIcon,   this.validator,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
