import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zakat_app/navs/bottom_nav.dart';
import 'package:zakat_app/screens/accounts.dart';
import 'package:zakat_app/screens/editProfileScreen.dart';
import 'package:zakat_app/screens/sign_up_screen_two.dart';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShowBottomSheet extends StatefulWidget {
  const ShowBottomSheet({super.key});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  int pid=0;
  String year="";
  String plan_type="";
  int month=0;
  String purpose="";
  double amount=0.0;
  bool status=true;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xff757575),
      child: Container(
          height: 600, // Adjust the height based on the screen height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenHeight * 0.02), // Adjust the radius based on the screen height
              topRight: Radius.circular(screenHeight * 0.02),
            ),
          ),
          child: Scaffold(
            backgroundColor: Color(0xFF167B8B),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFAC6594),
                          child: Icon(
                            Icons.account_circle_rounded,
                            size: 30,
                            color: Colors.white,// Adjust the size based on the screen height
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenHeight * 0.02, // Adjust the width based on the screen height
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 120,top: 10), // Adjust the padding based on the screen height
                            child: Text(
                              'Konain',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            'konain786@gmail.com',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14), // Adjust the font size based on the screen height
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10, // Adjust the width based on the screen height
                      ),
                      TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_left,
                            color: Colors.white,
                            size: 15, // Adjust the size based on the screen height
                          ),
                          label: Text(
                            'Back',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18, // Adjust the font size based on the screen height
                                fontWeight: FontWeight.w700),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 25, // Adjust the height based on the screen height
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.029, // Adjust the font size based on the screen height
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    height: 8, // Adjust the height based on the screen height
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text('New Calculation',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: IconButton(onPressed: (){},
                                    icon: Icon(Icons.calculate,
                                      color: Colors.white,
                                      size: 26,
                                    )),
                              )
                            ]),
                        kDiv,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text('Change Password',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: IconButton(onPressed: (){},
                                    icon: Icon(Icons.password,
                                      color: Colors.white,
                                      size: 26,
                                    )),
                              )
                            ]),
                        kDiv,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('Edit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: IconButton(onPressed: (){
                                Navigator.pushNamed(context, EditProfile.id);
                                },
                                  icon: Icon(Icons.edit,
                                    color: Colors.white,
                                    size: 26,
                                  )),
                            )
                        ]),
                        kDiv,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Padding(
                                padding:const EdgeInsets.only(left: 15.0),
                                child: Text('Guidelines',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: IconButton(onPressed: (){},
                                    icon: Icon(Icons.map,
                                      color: Colors.white,
                                      size: 26,
                                    )),
                              )
                            ]),
                        kDiv,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text('LogOut',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: IconButton(onPressed: (){},
                                    icon: Icon(Icons.logout,
                                      color: Colors.white,
                                      size: 26,
                                    )),
                              )
                            ]),
                        kDiv,
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNav(),
          ),
        ),
    );
  }
}

