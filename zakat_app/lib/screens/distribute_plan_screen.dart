import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zakat_app/screens/autoPlan_updatedScreen.dart';
import 'package:zakat_app/screens/auto_plan_screen.dart';
import 'package:zakat_app/navs/bottom_nav.dart';
import 'package:zakat_app/screens/ownPlan_updatedScreen.dart';
import 'package:zakat_app/screens/own_plan_screen.dart';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DistributePlan extends StatefulWidget {
  static const String id = 'distribute_plan';

  @override
  State<DistributePlan> createState() => _DistributePlanState();
}

class _DistributePlanState extends State<DistributePlan> {

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
  var year;
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

  int pid=0;
  String pyear="";
  String plan_type="";
  int month=0;
  String purpose="";
  double amount=0.0;
  bool status=true;

  TextEditingController totalZakathController = TextEditingController();

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
        year = data['year'].toString();


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
          year = year;

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

  Future<void> fetchPlans() async {
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
      print("inside if");
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
      Map<String, dynamic> responseData = json.decode(responseBody);

      if (responseData.containsKey('data')) {
        print("Data found in response");
        dynamic data = responseData['data'];

        pid=data['id'];
        pyear=data['year'].toString();
        plan_type=data['plan_type'];
        month=data['month'];
        purpose=data['purpose'];
        amount=data['amount'];
        status=data['status'];


        setState(() {

          year=year;
          plan_type=plan_type;
          month=month;
          purpose=purpose;
          amount=amount;
          status=status;

          print('Id: $id');
          print('year: $year');
          print('plan_type: $plan_type');
          print('month: $month');
          print('purpose: $purpose');
          print('amount: $amount');
          print('status: $status');

        });
      } else {
        print('Data is missing in the response');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCalculation();
    fetchPlans();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double borderWidth = 2.0; // Set your desired border width

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Distribute Plan',
          style: appTextStyle,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFAC6594),
        toolbarHeight: screenHeight * 0.1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.1,
              width: screenWidth,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: Color(0xFFFFEBFE),
                  borderRadius: BorderRadius.circular(screenWidth * 0.012),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Color(0xFF88047E),
                    width: borderWidth,
                  ),
                ),
                child: Text(
                  'MY TOTAL ZAKAT IS $totalZakath',
                  style: TextStyle(
                    color: kPeachColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFF8F8F8),
                      side: BorderSide(width: screenWidth * 0.002, color: kPeachColor),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      ),
                    ),
                    onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AutoPlanScreen.id,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Auto Plan',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: screenHeight * 0.027,
                              color: kPeachColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.01),
                            child: Text(
                              'You can choose the month according to your convenience, the money will be distributed equally',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: screenHeight * 0.022,
                                color: kPeachColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: kDivider),
                Text(
                  'OR',
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.normal,
                    color: kPeachColor,
                  ),
                ),
                Expanded(child: kDivider),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFF8F8F8),
                      side: BorderSide(width: screenWidth * 0.002, color: kPeachColor),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      ),
                    ),
                    onPressed: () {
                        Navigator.pushNamed(
                          context,
                          OwnPlanScreen.id,
                        );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Own Plan',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: screenHeight * 0.027,
                              color: kPeachColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.01),
                            child: Text(
                              'You can choose the month and currency',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: screenHeight * 0.022,
                                color: kPeachColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
