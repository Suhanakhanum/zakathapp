import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:zakat_app/screens/distribute_plan_screen.dart';

class Distribute_plan_field extends StatefulWidget {
  const Distribute_plan_field({super.key});

  @override
  State<Distribute_plan_field> createState() => _Distribute_plan_fieldState();
}

class _Distribute_plan_fieldState extends State<Distribute_plan_field> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextButton(
        onPressed: (){
          setState(() {
            Navigator.pushNamed(
                context,
                DistributePlan.id
            );
          });
        },
        child: Text('Distribute Plan',style: barTextStyle),
        style:TextButton.styleFrom(
            backgroundColor:Color(0xFFADADAD),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)
            )
        ),),
    );
  }
}