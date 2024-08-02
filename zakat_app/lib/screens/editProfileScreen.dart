import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:zakat_app/navs/bottom_nav.dart';

class EditProfile extends StatefulWidget {
  static const String id ='editProfileScreen';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  String password ='';
  String username = '';
  String email = '';
  int id =0;

  Future<void> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('userId') ?? 0;
    print('The found id is: $id');

    var headers = {'Content-Type': 'application/json'};
    print(headers);
    var request = http.Request(
      'GET',
      Uri.parse('http://10.0.2.2:8081/fetchUsers/$id'),
    );
    print(request);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    print("before if");
    if (response.statusCode == 200) {
      print("inside if");
      print("trying to print the response body");
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      Map<String, dynamic> responseData = json.decode(responseBody);

      if (responseData.containsKey('data')) {
        print("Data found in response");
        dynamic data = responseData['data'];
        print("Data: $data");

        id = data['id'];
        username = data['username'];
        email = data['email'];
        password =data['password'];


        setState(() {
          id = id;
          username = username;
          email = email;
          password = password;

          print('ID: $id');
          print('Name: $username');
          print('Email: $email');
          print('Password: $password');

          _nameController.text = username;
          _emailController.text = email;
        });
      } else {
        print('Data is missing in the response');
      }
    } else {
      print('Failed to fetch user data: ${response.reasonPhrase}');
    }
  }

  Future<void> updateUser() async {
    if (_passwordController.text != password) {
      print('Entered password does not match the fetched password.');
      return;
    }

    var headers = {
      'Content-Type': 'application/json'
    };
    print(headers);
    var request = http.Request('PUT', Uri.parse('http://10.0.2.2:8081/updateUsers'));
    print(request);

    request.body = json.encode({
      "id": id,
      "username": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text
    });
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    print("before if");
    if (response.statusCode == 202) {
      print("after if");
      print(response.statusCode);
      print("User Updated Successfully");
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF65A2AC),
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: appTextStyle,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF10545F),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2
                              )
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Profile Picture',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                      height: 30,
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
                      height: 30,
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
                              hintText: 'Your Current Password',
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
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Color(0xFF10545F)
                              ),
                            ),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFF10545F),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)
                                    )
                                ),
                                onPressed:(){
                                  updateUser();

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text('Update',style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),),
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
