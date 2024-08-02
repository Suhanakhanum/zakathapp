import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';

class Zakath_for_now extends StatelessWidget {
  Zakath_for_now({required this.controller,required this.zamt});
  final TextEditingController controller;
  double zamt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: textInOutShadow,
        child: TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
              labelText: 'Your Zakat for now is: ${zamt}',
              labelStyle: TextStyle(
                  fontSize: 15,
                  color: kPeachColor
              ),
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))
              )
          ),
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF88047E),
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}