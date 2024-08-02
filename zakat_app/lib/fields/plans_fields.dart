import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';

class PlanFields extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;

  final Function onChange;
  PlanFields({required this.controller1,
    required this.controller2,
  required this.onChange});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      right: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  style: BorderStyle.solid,
                  color: kPeachColor,
                  width: 1
              )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 4,right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 65,
                  width: 250,
                  child: Container(
                    decoration: textOutShadow,
                    child: TextField(
                      controller: controller1,
                      decoration: InputDecoration(
                        hintText: 'Where are u Planning to donate',
                        hintStyle: TextStyle(
                          color: kPeachColor,
                          fontSize: 14
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                        )
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 65,
                  width: 100,
                  child: Container(
                    decoration: textOutShadow,
                    child: TextField(
                      readOnly: true,
                      onChanged:onChange(),
                      controller: controller2,
                      decoration: InputDecoration(
                        hintText: '0000',
                        hintStyle: TextStyle(
                            color: kPeachColor
                        ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          )
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}