import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:zakat_app/screens/accounts.dart';
import 'package:zakat_app/screens/sign_up_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String id='login_screen';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool isButtonEnabled = false;

  Future<void> setUserId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', id);
  }

  Future<void> verifyUser(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      var request = http.Request(
        'POST',
        Uri.parse('http://10.0.2.2:8081/verifyUsers/verifyByEmailAndPassword?email=$email&password=$password'),
      );

      http.StreamedResponse response = await request.send();
      print(response);
      print("before if");
      if (response.statusCode == 200) {
        print("after if");
        print(response.statusCode);
        var responseBody = await response.stream.bytesToString();
        print(responseBody);
        print("try to store the id in local storage");

        var responseData = json.decode(responseBody);

        var userId = responseData['data']['id'];
        print(userId);
        await setUserId(userId);


        Navigator.pushNamed(context, Accounts.id);
      } else {
        print('Error: ${response.reasonPhrase}'
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAC6594),
      body: SafeArea(
        top: true,
          right: true,
          bottom: true,
          left: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('LOG IN',style: optTxtStyle1,)),
                      SizedBox(height: 10,),
                      Text('To proceed further, please log in to your account.',style: optTxtStyle2,)
                    ],
                  ),
                  SizedBox(height: 30,),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset('images/Log in.png',
                          width: 180,
                          height: 180,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Container(
                      height: 70,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorHeight: 40,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey
                              )
                          ),
                          style: TextStyle(
                              fontSize: 19
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Container(
                      height: 70,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          cursorHeight: 40,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(
                              fontSize: 19
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                backgroundColor: isButtonEnabled ? Color(0xFF660E48) : Colors.grey,
                              ),
                              onPressed: isButtonEnabled
                                  ? () {
                                // print('Searching');
                                verifyUser(context);
                                // print('found');
                                // Navigator.pushNamed(context, Accounts.id);
                              } : null,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Login',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                                ),),
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    Navigator.pushNamed(context, SignUpScreen.id);
                                  });
                                },
                                child: Text('Sign up',style: TextStyle(
                                    color: Color(0xFFFDB7E5),
                                    fontSize: 12
                                ),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: (){
                                  setState(() {

                                  });
                                },
                                child: Text('Forgot Password',style: TextStyle(
                                    color: Color(0xFFFDB7E5),
                                    fontSize: 15
                                ),),
                              ),
                            ),
                          )
                        ],
                      )

                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _emailController.addListener(updateButtonState);
    _passwordController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
