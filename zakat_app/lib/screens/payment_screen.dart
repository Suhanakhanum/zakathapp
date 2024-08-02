import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:zakat_app/navs/bottom_nav.dart';
import 'package:http/http.dart' as http;
import 'package:zakat_app/screens/showHistoryScreen.dart';


class PaymentScreen extends StatefulWidget {
  static const String id='payemnt_screen';
  final int planId;

  const PaymentScreen({Key? key, required this.planId}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  TextEditingController amountController=TextEditingController();
  TextEditingController toController=TextEditingController();
  TextEditingController paymentController=TextEditingController();
  TextEditingController debitController=TextEditingController();
  bool isButtonEnabled=false;
  String year="";
  String plan_type="";
  int month=0;
  String purpose="";
  double amount=0.0;
  bool status=true;

  Future<void> fetchPlanById() async {
    int planId=widget.planId;
    print(planId);

    var request = http.Request('GET', Uri.parse('http://10.0.2.2:8081/getPlan/$planId'));
    print(request);


    http.StreamedResponse response = await request.send();
    print(response);

    print("before if");
    if (response.statusCode == 200) {
      print("inside if");
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      Map<String, dynamic> responseData = json.decode(responseBody);

      if (responseData.containsKey('data') && responseData['data'] != null) {
        print("Data found in response");
        dynamic data = responseData['data'];
        print("Data: $data");

        planId = data['id'];
        year = data['year'].toString();
        plan_type = data['plan_type'].toString();
        month = data['month'];
        purpose = data['purpose'].toString();
        amount = data['amount'];
        status = data['status'];

        setState(() {
          planId = planId;
          year = year;
          plan_type = plan_type;
          month = month;
          purpose = purpose;
          amount = amount;
          status = status;

          amountController.text = amount.toString();
          toController.text = purpose;
        });
      }
      else {
        print(response.reasonPhrase);
      }
    }}

  Future<void> savePayment() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('userId') ?? 0;
    print('The found id is: $id');

    var headers = {
      'Content-Type': 'application/json'
    };
    print(headers);
    int planId = widget.planId;
    print(planId);

    DateTime currentDate = DateTime.now();
    String formattedDate = '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';


    var request = http.Request('POST', Uri.parse('http://10.0.2.2:8081/history/$id/$planId'));
    request.body = json.encode({
      "date": formattedDate,
      "paid_amount": amountController.text,
      "paid_from": paymentController.text,
      "paid_to": toController.text,
      "debited_from": debitController.text,
      "paid_status" : true
    });
    print(request);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    print("before if");
    print(response.statusCode);
    if (response.statusCode == 201) {
      print("inside if");
      print(response.statusCode);
      print("Payment saved successfully");
      print(await response.stream.bytesToString());
    }
    else {
      print("Something went wrong");
      print(response.reasonPhrase);
    }
  }


  @override
  void initState() {
    amountController.addListener(updateStateButton);
    toController.addListener(updateStateButton);
    paymentController.addListener(updateStateButton);
    debitController.addListener(updateStateButton);
    fetchPlanById();
    super.initState();
  }

  void updateStateButton(){
    setState(() {
      isButtonEnabled = amountController.text.isNotEmpty &&
          toController.text.isNotEmpty &&
          paymentController.text.isNotEmpty &&
          debitController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    toController.dispose();
    paymentController.dispose();
    debitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int planId=widget.planId;
    return Scaffold(
      backgroundColor: Color(0xFFFFEBFE),
      appBar: AppBar(
        title: Text(
          'Payment',
          style: appTextStyle,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFAC6594),
        toolbarHeight: 100,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Payment Details For March',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF038690),
                          ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      kDiv2,
                      SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.centerLeft,
                          child: Text('Paid Amount',style: followTextStyle,)),
                      SizedBox(height: 10,),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPeachColor,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: -1.0,
                                blurRadius: 4.0
                            ),
                            BoxShadow(
                                color: Colors.white,
                                spreadRadius: -1.0,
                                blurRadius: 10.0
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                                hintText: 'Amount to pay',
                                hintStyle: TextStyle(
                                    fontSize: 12
                                )
                            ),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                        ),
                      ),
                      ),

                      SizedBox(height: 30,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Paid to',style: followTextStyle,)),
                      SizedBox(height: 10,),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPeachColor,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: -1.0,
                                blurRadius: 4.0
                            ),
                            BoxShadow(
                                color: Colors.white,
                                spreadRadius: -1.0,
                                blurRadius: 10.0
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: toController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Where you have planned to pay',
                                hintStyle: TextStyle(
                                    fontSize: 12
                                )
                            ),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Mode of Payment',style: followTextStyle,)),
                      SizedBox(height: 10,),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPeachColor,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: -1.0,
                                blurRadius: 4.0
                            ),
                            BoxShadow(
                                color: Colors.white,
                                spreadRadius: -1.0,
                                blurRadius: 10.0
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: paymentController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                              hintText: 'Transfer to account or cash',
                              hintStyle: TextStyle(
                                fontSize: 12
                              )
                            ),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Debited Account',style: followTextStyle,)),
                      SizedBox(height: 10,),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPeachColor,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: -1.0,
                                blurRadius: 4.0
                            ),
                            BoxShadow(
                                color: Colors.white,
                                spreadRadius: -1.0,
                                blurRadius: 10.0
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: debitController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Debited bank name if transfered to account',
                                hintStyle: TextStyle(
                                    fontSize: 12
                                )
                            ),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('You can edit the amount and place where you.',
                        style: TextStyle(
                          fontSize: 10,
                          color: kPeachColor
                        ),
                        ),
                      ),

                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: -1.0,
                                    blurRadius: 4.0
                                ),
                                BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: -1.0,
                                    blurRadius: 10.0
                                ),
                              ],
                            ),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)
                                    ),
                                  backgroundColor: isButtonEnabled? Color(0xFF88047E) : Color(0xFFADADAD),
                                ),
                                onPressed: isButtonEnabled? (){
                                  savePayment();
                                  print('Plan ID before navigation: $planId'); // Check if planId is defined
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShowHistory(planId: planId),
                                    ),
                                  );
                                } : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text('Save Payment',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),),
                                )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}

