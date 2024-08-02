import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:zakat_app/screens/accounts.dart';
import 'package:zakat_app/screens/single_calculate_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreenTwo extends StatefulWidget {
  static const String id = 'sign_up_screen_two';

  @override
  State<SignUpScreenTwo> createState() => _SignUpScreenTwoState();
}

class _SignUpScreenTwoState extends State<SignUpScreenTwo> {
  TextEditingController caratController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController caratController1 = TextEditingController();
  TextEditingController gramsController1 = TextEditingController();
  TextEditingController silverGramsController = TextEditingController();
  TextEditingController incomeController = TextEditingController();
  TextEditingController cashController = TextEditingController();
  TextEditingController amountContoller=TextEditingController();
  TextEditingController zakathContoller=TextEditingController();
  TextEditingController yearContoller=TextEditingController();
  bool isButtonEnabled = false;
  bool isButtonEnabled1 = false;

  bool showForm = false;

  Future<void> createCalculation(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt('userId') ?? 0; // Use 'userId' instead of 'id'
      print('The found id is: $id');

      var headers = {'Content-Type': 'application/json'};
      print(headers);

      var request = http.Request(
          'POST', Uri.parse('http://10.0.2.2:8081/calculate/$id'));
      print(request);
      int currentYear=DateTime.now().year;
      request.body = json.encode({
       "gold_carat_type_one": caratController.text,
       "total_grams_of_gold_type_one":gramsController.text,
       "gold_price_type_one":0,
       "goldAmountOne":0,
       "goldZakathOne":0,
       "gold_carat_type_two":caratController1.text,
       "total_grams_of_gold_type_two":gramsController1.text,
       "gold_price_type_two":0,
       "goldAmountTwo":0,
       "goldZakathTwo":0,
       "total_grams_of_silver":silverGramsController.text,
       "silver_price":0,
       "silverAmount":0,
       "silverZakath":0,
       "total_income":incomeController.text,
       "incomeLiability":0,
       "incomeZakath":0,
       "total_cash":cashController.text,
       "cashLiability":0,
       "cashZakath":0,
       "totalZakath":0,
       "year":currentYear
      });

      print(request.body);

      log('Sending calculation request');

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response);
      log('Response received: $response');

      print("before if");
      print(response.statusCode);
      if (response.statusCode == 201) {
        print("inside if ");
        print('Calculation saved successfully');
        setState(() {
          _showPopup();
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    caratController.addListener(updateButtonState);
    gramsController.addListener(updateButtonState);
    caratController.addListener(updateButtonState1);
    gramsController.addListener(updateButtonState1);
    caratController1.addListener(updateButtonState1);
    gramsController1.addListener(updateButtonState1);
    silverGramsController.addListener(updateButtonState1);
    incomeController.addListener(updateButtonState1);
    cashController.addListener(updateButtonState1);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          caratController.text.isNotEmpty && gramsController.text.isNotEmpty;
    });
  }

  void updateButtonState1() {
    setState(() {
      isButtonEnabled1 = (caratController.text.isNotEmpty &&
              gramsController.text.isNotEmpty) ||
          (caratController1.text.isNotEmpty &&
              gramsController1.text.isNotEmpty) ||
          silverGramsController.text.isNotEmpty ||
          incomeController.text.isNotEmpty ||
          cashController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    caratController.dispose();
    gramsController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF65A2AC),
      body: SafeArea(
          left: true,
          right: true,
          top: true,
          bottom: true,
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
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
                                )),
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
                                  'Step 2/2',
                                  style: optTxtStyle2,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Gold',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                height: 70,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: caratController,
                                    keyboardType: TextInputType.number,
                                    cursorHeight: 40,
                                    decoration: InputDecoration(
                                        hintText: 'Which Carat Of Gold',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: Colors.grey)),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                height: 70,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: gramsController,
                                    keyboardType: TextInputType.number,
                                    cursorHeight: 40,
                                    decoration: InputDecoration(
                                        hintText: 'Total Grams',
                                        suffixText: 'grams',
                                        suffixStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: Colors.grey)),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: isButtonEnabled
                                          ? Color(0xFFA96391)
                                          : Color(0xFFADADAD),
                                    ),
                                    onPressed: isButtonEnabled
                                        ? () {
                                            setState(() {
                                              showForm = !showForm;
                                            });
                                          }
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'To Add Different Carat',
                                        style: optTxtStyle2,
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (showForm)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      height: 70,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                          controller: caratController1,
                                          keyboardType: TextInputType.number,
                                          cursorHeight: 40,
                                          decoration: InputDecoration(
                                              hintText: 'Which Carat Of Gold',
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey)),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      height: 70,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                          controller: gramsController1,
                                          keyboardType: TextInputType.number,
                                          cursorHeight: 40,
                                          decoration: InputDecoration(
                                              hintText: 'Total Grams',
                                              suffixText: 'grams',
                                              suffixStyle: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey)),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        kDiv,
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Silver',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                height: 70,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: silverGramsController,
                                    keyboardType: TextInputType.number,
                                    cursorHeight: 40,
                                    decoration: InputDecoration(
                                        hintText: 'Total Grams',
                                        suffixText: 'grams',
                                        suffixStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: Colors.grey)),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        kDiv,
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Income',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                height: 70,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: incomeController,
                                    keyboardType: TextInputType.number,
                                    cursorHeight: 40,
                                    decoration: InputDecoration(
                                        hintText: 'Total Amount',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: Colors.grey)),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        kDiv,
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Cash',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                height: 70,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: cashController,
                                    keyboardType: TextInputType.number,
                                    cursorHeight: 40,
                                    decoration: InputDecoration(
                                        hintText: 'Total Amount',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: Colors.grey)),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: isButtonEnabled1
                                          ? Color(0xFF10545F)
                                          : Color(0xFFADADAD),
                                    ),
                                    onPressed: isButtonEnabled1
                                        ? () {
                                            createCalculation(context);
                                          }
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Create an Account',
                                        style: optTxtStyle2,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ))
            ],
          )),
    );
  }

  // Function to show the popup
  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                color: Colors.white,
                height: 380, // Adjust the height as needed
                child: Column(
                  children: [
                    // AppBar
                    AppBar(
                        toolbarHeight: 120,
                        automaticallyImplyLeading: false,
                        backgroundColor: Color(0xFF038690),
                        title: Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                                'images/Sign up with filled fields an opoup.png'))),
                    // Body
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Account has been created successfully,'
                            'to calculate your zakat click on'
                            '\'Calculate zakat'
                            '\''
                            'button.',
                            style: TextStyle(fontSize: 18, letterSpacing: 1.5),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFFFD3A84),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          6.0), // Adjust the radius as needed
                                    ),
                                  ),
                                  onPressed: () {
                                    // Handle button 1 action
                                    Navigator.pushNamed(context, Accounts.id);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFF038690),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          6.0), // Adjust the radius as needed
                                    ),
                                  ),
                                  onPressed: () {
                                    // Handle button 2 action
                                    Navigator.pushNamed(
                                        context, SingleCalculatePage.id);
                                  },
                                  child: Text(
                                    'Calculate Zakath',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
