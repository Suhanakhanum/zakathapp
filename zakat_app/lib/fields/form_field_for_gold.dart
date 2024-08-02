import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';

class Form_field_for_gold extends StatelessWidget {
  Form_field_for_gold({required this.controller,
    required this.hints});

  final TextEditingController controller;
  final String hints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: textOutShadow,
        child: TextField(
          textInputAction: TextInputAction.next,
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: hints,
              hintStyle: TextStyle(
                  fontSize: 15
              ),
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))
              )
          ),
          style: TextStyle(
            fontSize: 17
          ),
        ),
      ),
    );
  }
}