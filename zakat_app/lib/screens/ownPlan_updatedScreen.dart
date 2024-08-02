import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:zakat_app/screens/payment_screen.dart';

class OwnPlanUpdatedScreen extends StatefulWidget {
  static const String id = 'ownPlan_updatedScreen';

  @override
  State<OwnPlanUpdatedScreen> createState() => _OwnPlanUpdatedScreenState();
}

class _OwnPlanUpdatedScreenState extends State<OwnPlanUpdatedScreen> {
  List<dynamic> planDetails = [];
  int pid = 0;
  String year = "";
  String plan_type = "";
  int month = 0;
  String purpose = "";
  double amount = 0.0;
  bool status = true;

  String date = '';
  double paidAmount = 0.0;
  String paidFrom = '';
  String paidTo = '';
  String debitedFrom = '';
  int hId = 0;
  bool paid_status = false;

  int id=0;
  int calculationId=0;
  var carat1data;
  var goldGram1 ;
  var rate1data ;
  var carat2 ;
  var goldGram2 ;
  var rate2 ;
  var silverGrams ;
  var price ;
  var totalIncome;
  var totalCash ;
  double totalZakath =0 ;
  var pyear;
  var goldAmount1;
  var goldAmount2;
  var silverAmount;
  var incomeAmount;
  var cashAmount;
  var goldZakath1;
  var goldZakath2;
  var silverZakath;
  var incomeZakath;
  var cashZakath;
  TextEditingController totalZakathController = TextEditingController();

  Future<void> fetchThePlans() async {
    print("Inside fetchPlan");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('userId') ?? 0;
    print("Found Id is : $id");

    var headers = {
      'Content-Type': 'application/json'
    };
    print(headers);
    int currentYear = DateTime.now().year;

    var request = http.Request('GET', Uri.parse('http://10.0.2.2:8081/getPlans/$id/$currentYear'));
    print(request);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    print("before if");
    if (response.statusCode == 200) {
      print("after if");
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      print(responseBody);

      // Parse the response body
      List<dynamic> planData = json.decode(responseBody)['data'];
      print("Plan Data: $planData");

      setState(() {
        // Update planDetails with fetched plan data
        planDetails = planData;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> fetchHistory() async {
    print("Entered Fetch History Function");
    int planId = pid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('userId') ?? 0;

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'GET', Uri.parse('http://10.0.2.2:8081/getHistory/$id/$planId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> responseData = json.decode(responseBody);

      if (responseData.containsKey('data')) {
        List<dynamic> data = responseData['data'];
        setState(() {
          hId = hId;
          paidAmount = paidAmount;
          paidFrom = paidFrom;
          paidTo = paidTo;
          debitedFrom = debitedFrom;
          paid_status = paid_status;

          print(hId);
          print(paidAmount);
          print(paidFrom);
          print(paidTo);
          print(debitedFrom);
          print(paid_status);
        });
      } else {
        print('Data is missing in the response');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> updateHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('userId') ?? 0;
    print("Found Id is : $id");
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT', Uri.parse('http://10.0.2.2:8081/updateHistory/$id/$pid'));
    request.body = json.encode({
      "id": hId,
      "date": date,
      "paid_amount": paidAmount,
      "paid_from": paidFrom,
      "paid_to": paidTo,
      "debited_from": debitedFrom,
      "paid_status": true
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 202) {
      print(response.statusCode);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> fetchCalculation() async {
    print("This is fetch Calculation block");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('userId') ?? 0;
    print('The Found Id is : $id');

    var headers = {'Content-Type': 'application/json'};
    print(headers);
    var request = http.Request(
        'GET',
        Uri.parse('http://10.0.2.2:8081/getCalculations/$id'));
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
        dynamic data = responseData['data'][0];
        print("Data: $data");

        calculationId = data['id'];
        carat1data = data['gold_carat_type_one'].toString();
        goldGram1 = data['total_grams_of_gold_type_one'].toString();
        rate1data =data['gold_price_type_one'].toString();
        goldAmount1=data['goldAmountOne'].toString();
        goldZakath1=data['goldZakathOne'].toString();
        carat2 =data['gold_carat_type_two'].toString();
        goldGram2 =data['total_grams_of_gold_type_two'].toString();
        rate2 =data['gold_price_type_two'].toString();
        goldAmount2=data['goldAmountTwo'].toString();
        goldZakath2=data['goldZakathTwo'].toString();
        silverGrams =data['total_grams_of_silver'].toString();
        price = data['silver_price'].toString();
        silverAmount=data['silverAmount'].toString();
        silverZakath=data['silverZakath'].toString();
        totalIncome = data['total_income'].toString();
        incomeZakath=data['incomeZakath'].toString();
        totalCash = data['total_cash'].toString();
        cashZakath=data['cashZakath'].toString();
        totalZakath = data['totalZakath'];
        pyear = data['year'].toString();


        setState(() {
          calculationId = calculationId;
          carat1data = carat1data;
          goldGram1 = goldGram1;
          rate1data =rate1data;
          goldAmount1=goldAmount1;
          goldZakath1=goldZakath1;
          carat2 =carat2;
          goldGram2 =goldGram2;
          rate2 =rate2;
          goldAmount2=goldAmount2;
          goldZakath2=goldZakath2;
          silverGrams =silverGrams;
          price = price;
          silverAmount=silverAmount;
          silverZakath=silverZakath;
          totalIncome =totalIncome;
          incomeZakath=incomeZakath;
          totalCash = totalCash;
          cashZakath=cashZakath;
          totalZakath = totalZakath;
          pyear = year;

          totalZakathController.text=totalZakath.toString();

          print('ID: $calculationId');
        });

      } else {
        print('Data is missing in the response');
      }
    } else {
      print('Failed to fetch user data: ${response.reasonPhrase}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchThePlans();
    fetchCalculation();
    fetchHistory();
    updateHistory();
  }
  
  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    print('Plan details length: ${planDetails.length}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Distributed Own Plan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFAC6594),
        toolbarHeight: 100,
      ),
      body: Column(
        children: [
          Container(
            decoration: textInOutShadow,
            height: 80,
            width: 450,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0),
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFFFFEBFE),
                borderRadius: BorderRadius.circular(6.0),
                shape: BoxShape.rectangle,
                border: Border.all(color: kPeachColor, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  'MY TOTAL ZAKAT IS ',
                  style: TextStyle(
                      color: kPeachColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Go with plan',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF038690),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '0000',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF038690),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: planDetails.length,
              itemBuilder: (context, index) {
                var plan = planDetails[index];
                int planId = plan['id'];
                String year = plan['year'].toString();
                String planType = plan['plan_type'].toString();
                int monthIndex = plan['month'] - 1; // Adjust index since months start from 1
                String monthName = monthNames[monthIndex];
                String purpose = plan['purpose'].toString();
                double amount = plan['amount'];
                bool status = plan['status'];

                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      monthName,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SingleChildScrollView(
                        // scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: paid_status
                                      ? Color(0xFF94AC65)
                                      : Color(0xFFAC6594),
                                  border: Border.all(
                                    width: 1.5,
                                    color: paid_status
                                        ? Color(0xFF94AC65)
                                        : Color(0xFFAC6594),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: -5.0,
                                        blurRadius: 10.0),
                                    BoxShadow(
                                      color: Colors.white,
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ' $purpose',
                                      style: planTextStyle,
                                    ),
                                    Text(
                                      ' $amount',
                                      style: planTextStyle,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              side: BorderSide(
                                                  color: Color(0xFF3CA90D)),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          planId = plan['id'];
                                          print(planId); // Define planId here
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentScreen(planId: planId),
                                            ),
                                          );
                                          print(planId);
                                        },
                                        child: Text(
                                          'Pay',
                                          style: TextStyle(
                                            color: Color(0xFF3CA90D),
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
