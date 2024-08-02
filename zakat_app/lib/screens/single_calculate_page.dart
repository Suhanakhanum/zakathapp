import 'package:flutter/material.dart';
import 'package:zakat_app/navs/bottom_nav.dart';
import '../screen_switches/multiSwitch.dart';
import '../screen_switches/singleSwitch.dart';
import '../constants/constants.dart';


class SingleCalculatePage extends StatefulWidget {
  static const String id='single_calculate_page';

  @override
  State<SingleCalculatePage> createState() => _SingleCalculatePageState();
}

class _SingleCalculatePageState extends State<SingleCalculatePage> {
  bool isOption1Selected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 80,
        backgroundColor: kPeachColor,
        title: Align(
          alignment: Alignment.centerLeft,
            child: Text('Calculate',
              style:barTextStyle)),
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
      body: isOption1Selected ? MultiSwitch() : SingleSwitch(),
      bottomNavigationBar: BottomNav()
    );
  }
}


