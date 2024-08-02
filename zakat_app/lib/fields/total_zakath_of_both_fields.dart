import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';

class Total_zakath_of_both_fields extends StatelessWidget {
  Total_zakath_of_both_fields({required this.controller,required this.tzamt});

  final TextEditingController controller;
  double tzamt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF235B93),
        ),
        child: TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
              hintText: 'Your total zakat for now is : ${tzamt}',
              hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.white
              ),
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))
              )
          ),
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}