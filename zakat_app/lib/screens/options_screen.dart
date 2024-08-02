import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:zakat_app/screens/calculate_only_screen.dart';
import 'package:zakat_app/screens/login_screen.dart';
import 'package:zakat_app/screens/sign_up_screen.dart';
import 'package:zakat_app/screens/single_calculate_page.dart';

class OptionScreen extends StatefulWidget {
  static const String id = 'options_screen';

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7E4EC),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10,),
              Container(
                height: 250,
                color: Color(0xFF038690),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                          child: Text('SIGN UP',
                          style: optTxtStyle1
                          )),
                      SizedBox(height: 15,),
                      Text('Hey there! Just wanted to let you know that '
                        'it\'s totally cool to have an account to keep'
                          'track of your zakat.It\'s super easy and totally'
                        'safe and secure!',
                        style: optTxtStyle2
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            backgroundColor: Color(0xFF10545F),
                            elevation: 10,
                            onPressed: (){
                              Navigator.pushNamed(context, SignUpScreen.id);
                            },
                            child: Icon(Icons.arrow_forward_ios,
                            size: 30,
                            color: Colors.white,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2,), 
              Container(
                height: 250,
                color: Color(0xFF94AC65),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                          child: Text('CALCULATE ONLY',
                          style: optTxtStyle1,
                          )),
                      SizedBox(height: 15,),
                      Text('I understand that you may need to perform'
                        'a calculation and leave the application.'
                        'You can go ahead and do that, whenever'
                        'you need to.',
                      style: optTxtStyle2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            backgroundColor: Color(0xFF48660C),
                            elevation: 10,
                            onPressed: (){
                              setState(() {
                                Navigator.pushNamed(
                                    context,
                                    CalculateOnly.id
                                );
                              });
                            },
                            child: Icon(Icons.arrow_forward_ios,
                              size: 30,
                              color: Colors.white,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2,), 
              Container(
                height: 250,
                color: Color(0xFFAC6594),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                          child: Text('LOGIN',
                          style: optTxtStyle1,
                          )),
                      SizedBox(height: 15,),
                      Text('You may want to continue with your account.'
                        'If you have one, please log in so we can assist'
                        'you further.',
                      style: optTxtStyle2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            backgroundColor: Color(0xFF660E48),
                            elevation: 10,
                            onPressed: (){
                              setState(() {
                                Navigator.pushNamed(context, LoginPage.id);
                              });
                            },
                            child: Icon(Icons.arrow_forward_ios,
                              size: 30,
                              color: Colors.white,),
                          ),
                        ),
                      )
                    ],
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