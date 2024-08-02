import 'package:flutter/material.dart';

class DesignField extends StatelessWidget {
  DesignField({required this.hints});
  final String hints;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 31.0,left: 25.0,right: 25.0,bottom: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hints,
          hintStyle: TextStyle(
            fontSize: 23.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
          )
        ),
      ),
    );
  }
}
