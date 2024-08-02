import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:zakat_app/screens/login_screen.dart';
import 'package:zakat_app/screens/sign_up_screen_two.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  static const String id = 'sign_up_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool isButtonEnabled = false;

  Future<void> createUser() async {
    var headers = {'Content-Type': 'application/json'};
    var request =
    http.Request('POST', Uri.parse('http://10.0.2.2:8081/saveUsers'));
    request.body = json.encode({
      "username": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text
    });
    print(request.body);
    log('try to save user');
    request.headers.addAll(headers);
    print(request.headers);

    http.StreamedResponse response = await request.send();
    print(response);
    print("before if");
    if (response.statusCode == 201) {
      print("inside if");
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      print('Response Body: $responseBody');
      Map<String, dynamic> responseData = json.decode(responseBody);

      int? id;

      if (responseData.containsKey('data')) {
        print("data present");
        Map<String, dynamic> data = responseData['data'];

        if (data.containsKey('id')) {
          id = data['id'];
          print('Stored user ID: $id');
        } else {
          print('Error: Key "id" not found in the "data" object');
        }
      } else {
        print('Error: Key "data" not found in the response');
      }

      if (id != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', id);
        await prefs.setString('username', _nameController.text);
        await prefs.setString('email', _emailController.text);
        await prefs.setString('password', _passwordController.text);

        print('Stored user ID: $id');

        print('Response received. Status Code: ${response.statusCode}');
        print('Response body:');
        print(responseBody); // Use the stored response body here
      } else {
        print('Error: User ID not found in the response');
      }
    }
  }

  // Future<void> createUser() async {
  //   // Request internet permission
  //   final PermissionStatus status = await Permission.phone.request();
  //
  //   if (status.isGranted) {
  //     // Permission granted, proceed with making the HTTP request
  //     var headers = {'Content-Type': 'application/json'};
  //     var request =
  //     http.Request('POST', Uri.parse('http://10.0.2.2:8081/saveUsers'));
  //     request.body = json.encode({
  //       "username": _nameController.text,
  //       "email": _emailController.text,
  //       "password": _passwordController.text
  //     });
  //     print(request.body);
  //     log('try to save user');
  //     request.headers.addAll(headers);
  //     print(request.headers);
  //
  //     http.StreamedResponse response = await request.send();
  //     print(response);
  //     print("before if");
  //     if (response.statusCode == 201) {
  //       print("inside if");
  //       print(response.statusCode);
  //       String responseBody = await response.stream.bytesToString();
  //       print('Response Body: $responseBody');
  //       Map<String, dynamic> responseData = json.decode(responseBody);
  //
  //       int? id;
  //
  //       if (responseData.containsKey('data')) {
  //         print("data present");
  //         Map<String, dynamic> data = responseData['data'];
  //
  //         if (data.containsKey('id')) {
  //           id = data['id'];
  //           print('Stored user ID: $id');
  //         } else {
  //           print('Error: Key "id" not found in the "data" object');
  //         }
  //       } else {
  //         print('Error: Key "data" not found in the response');
  //       }
  //
  //       if (id != null) {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setInt('userId', id);
  //         await prefs.setString('username', _nameController.text);
  //         await prefs.setString('email', _emailController.text);
  //         await prefs.setString('password', _passwordController.text);
  //
  //         print('Stored user ID: $id');
  //
  //         print('Response received. Status Code: ${response.statusCode}');
  //         print('Response body:');
  //         print(responseBody); // Use the stored response body here
  //       } else {
  //         print('Error: User ID not found in the response');
  //       }
  //     }
  //   } else if (status.isDenied) {
  //     // Permission denied, show a message or UI to inform the user
  //     print('Internet permission denied');
  //   } else if (status.isPermanentlyDenied) {
  //     // Permission permanently denied, navigate to app settings
  //     openAppSettings();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF65A2AC),
      body: SafeArea(
        left: true,
        right: true,
        top: true,
        bottom: true,
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
                      child: Text(
                        'SIGN UP',
                        style: optTxtStyle1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Continue to create an account.',
                          style: optTxtStyle2,
                        ),
                        Text(
                          'Step 1/2',
                          style: optTxtStyle2,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Image.asset(
                      'images/Sign up.png',
                      width: 230,
                      height: 230,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: 70,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _nameController,
                            cursorHeight: 40,
                            decoration: InputDecoration(
                              hintText: 'Enter your Name',
                              border: InputBorder.none,
                              hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
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
                              hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
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
                              hintStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible =
                                    !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Create a Strong password',
                          style: optTxtStyle2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: isButtonEnabled
                                ? Color(0xFF10545F)
                                : Colors.grey,
                          ),
                          onPressed: isButtonEnabled
                              ? () async {
                            await createUser();
                            Navigator.pushNamed(
                              context,
                              SignUpScreenTwo.id,
                            );
                          }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Next',
                              style: optTxtStyle2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pushNamed(context, LoginPage.id);
                            });
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: Color(0xFFB2F3FD),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(updateButtonState);
    _emailController.addListener(updateButtonState);
    _passwordController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
