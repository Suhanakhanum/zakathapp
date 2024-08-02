import 'package:flutter/material.dart';
import 'package:zakat_app/screens/welcome_screen.dart';
import 'dart:async';

class FirstScreen extends StatefulWidget {
  static const String id='first_screen';

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the second screen after a certain time duration (e.g., 3 seconds)
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, WelcomeScreen.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    child: Image.asset('images/Flash1.jpg',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    child: Image.asset('images/Flash2.jpg',
                    ),
                  ),
                )
              ],
          ),
        ),
      ),
    );
  }
}