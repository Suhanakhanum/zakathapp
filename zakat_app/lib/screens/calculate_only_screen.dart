import 'package:flutter/material.dart';
import 'package:zakat_app/screen_switches/multi_calculateOnly_switch.dart';
import 'package:zakat_app/screen_switches/single_calculateOnly_switch.dart';
import '../constants/constants.dart';

class CalculateOnly extends StatefulWidget {
  static const String id='calculate_only_screen';

  @override
  State<CalculateOnly> createState() => _CalculateOnlyState();
}

class _CalculateOnlyState extends State<CalculateOnly> {
  bool isOption1Selected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 80,
        backgroundColor: Color(0xFFAC6594),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text('Calculate',
                style: barTextStyle)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: SizedBox(
              width: 80,
              height: 60,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  value: isOption1Selected,
                  onChanged: (value) {
                    setState(() {
                      isOption1Selected = value;
                    });
                  },
                  activeColor: Color(0xFFAC6594),
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white,
                  inactiveThumbColor: Color(0xFFAC6594),
                ),
              ),
            ),
          ),
        ],
      ),
      body: isOption1Selected ? MultiCalculateOnlySwitch() : SingleCalculateOnlySwitch(),
    );
  }
}
