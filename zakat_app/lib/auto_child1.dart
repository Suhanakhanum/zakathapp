import 'package:flutter/material.dart';
import 'package:zakat_app/fields/plans_fields.dart';
import 'constants/constants.dart';
class AutoChild1 extends StatelessWidget {
  final double txt;
  AutoChild1({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: textInOutShadow,
          height: 80,
          width: 450,
          margin: EdgeInsets.only(left: 10.0, right: 10.0,top: 25.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Color(0xFFFFEBFE),
                borderRadius: BorderRadius.circular(6.0),
                shape: BoxShape.rectangle,
                border: Border.all(
                    color: kPeachColor,
                    width: 1
                ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text('MY TOTAL ZAKAT IS $txt',
                style: TextStyle(
                    color: kPeachColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}