import 'package:flutter/material.dart';
import 'constants/constants.dart';

class DisplayColumn extends StatelessWidget {
  const DisplayColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Container(
            child: Column(
              children: [
                Text(note2,
                  style: TextStyle(
                      fontSize: 12,
                      color: kPeachColor
                  ),),
                Text(note3,
                  style: TextStyle(
                      fontSize: 12,
                      color: kPeachColor
                  ),),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        )
      ],
    );
  }
}