import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';

class LastField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0B868F),
          border: Border.all(
            width: 1,
            color:  Color(0xFF0B868F),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Thank You. Come Again',style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 18
          ),),
        )
      ),
    );
  }
}
