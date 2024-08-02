import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';

class Forms_total_amount_field extends StatelessWidget {
  Forms_total_amount_field({required this.controller, required this.amt});

  final TextEditingController controller;
  double amt;

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
              labelText: 'Your Total Amount :${amt}',
              labelStyle: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF0F78A1)
              ),
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))
              )
          ),
          style: TextStyle(
            fontSize: 20,
              color: Color(0xFF0B868F),
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}