import 'package:flutter/material.dart';
import 'package:zakat_app/screens/options_screen.dart';
import '../constants/constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;

    // Set breakpoints for responsive design
    bool isSmallScreen = screenSize.width < 500;
    bool isMediumScreen = screenSize.width >= 600 && screenSize.width < 1200;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 550,
                    margin: EdgeInsets.only(
                      left: isSmallScreen ? 10.0 : 15.0,
                      right: isSmallScreen ? 10.0 : 8.0,
                      bottom: 10.0,
                      top: 0.001
                    ),
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/Image 13.jpg',
                          width: 500,
                          height: 400,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'Calculate and keep track on your Zakat',
                            style: TextStyle(
                              color: kAquaColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 24.0,
                              letterSpacing: isSmallScreen ? 0.7 : 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 400,
                    padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                    decoration: BoxDecoration(
                      color: kAquaColor,
                    ),
                    child: Expanded(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              'Welcome to MIHY Zakat account',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 24.0 : 40.0,
                                fontWeight: FontWeight.w900,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 2.0, right: 2.0),
                            child: Text(
                              'If you need to calculate and '
                                  'maintain your zakat, you are'
                                  ' welcome to use this tool. '
                                  'It is completely safe and secure.',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 18.0 : 34.0,
                                color: kWhiteColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 30),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: kWhiteColor,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, OptionScreen.id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10.0,
                                  right: 15.0,
                                  left: 15.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  'Let\'s get in',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 21.0 : 30.0,
                                    fontWeight: FontWeight.w900,
                                    color: kAquaColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}