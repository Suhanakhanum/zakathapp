import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat_app/navs/bottom_nav.dart';
import 'package:zakat_app/screens/distribute_plan_screen.dart';
import 'package:zakat_app/screens/editCalculation.dart';
import 'package:zakat_app/screens/paymentEntry.dart';
import 'package:zakat_app/screens/single_calculate_page.dart';
import '../constants/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;

class Accounts extends StatefulWidget {
  static const String id='accounts';

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  bool _isExpanded = false;
  bool isDistributionDone = false;
  bool isCalculationDone=false;
  bool isExpanded=false;

  int id=0;
  int calculationId=0;
  var carat1;
  var goldGram1 ;
  var rate1 ;
  var carat2 ;
  var goldGram2 ;
  var rate2 ;
  var silverGrams ;
  var price ;
  var totalIncome;
  var totalCash ;
  double totalZakath=0 ;
  var year;
  var goldAmount1;
  var goldAmount2;
  var silverAmount;
  var goldZakath1;
  var goldZakath2;
  var silverZakath;
  var incomeZakath;
  var cashZakath;

  String date='';
  double paidAmount=0.0;
  String paidFrom='';
  String paidTo='';
  String debitedFrom='';
  int historyId=0;
  bool paid_status=true;


  int planId=0;
  String plan_type="";
  int month=0;
  String purpose="";
  double amount=0.0;
  bool status=true;

  double totalPayment = 0.0;

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
        carat1 = data['gold_carat_type_one'].toString();
        goldGram1 = data['total_grams_of_gold_type_one'].toString();
        rate1 =data['gold_price_type_one'].toString();
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
          carat1 = carat1;
          goldGram1 = goldGram1;
          rate1 =rate1;
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

          print('ID: $calculationId');
          print('carat: $carat1');
          print('gram: $goldGram1');
          print('rate: $rate1');
          print('carat: $carat2');
          print('gram: $goldGram2');
          print('rate: $rate2');
          print('silver gram: $silverGrams');
          print('price: $price');
          print('income: $totalIncome');
          print('cash: $totalCash');


        });
      } else {
        print('Data is missing in the response');
      }
    } else {
      print('Failed to fetch user data: ${response.reasonPhrase}');
    }
  }

  Future<void> updateCalculation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('userId') ?? 0;
    print('The Found Id is : $id');

    var headers = {
      'Content-Type': 'application/json'
    };
    print(headers);

    var request = http.Request('PUT', Uri.parse('http://10.0.2.2:8081/updateCalculation/$id'));
    print(request);

    int currentYear=DateTime.now().year;
    request.body = json.encode({
      "id": calculationId,
      "gold_carat_type_one": carat1,
      "total_grams_of_gold_type_one":goldGram1,
      "gold_price_type_one":rate1,
      "goldAmountOne":goldAmount1,
      "goldZakathOne":goldZakath1,
      "gold_carat_type_two":carat2,
      "total_grams_of_gold_type_two":goldGram2,
      "gold_price_type_two":rate2,
      "goldAmountTwo":goldAmount2,
      "goldZakathTwo":goldZakath2,
      "total_grams_of_silver":silverGrams,
      "silverAmount":silverAmount,
      "silverZakath":silverZakath,
      "total_income":totalIncome,
      "incomeZakath":incomeZakath,
      "total_cash":totalCash,
      "cashZakath":cashZakath,
      "totalZakath":totalZakath,
      "year":currentYear
    });
    print(request.body);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    print("before if");
    print(response.statusCode);
    if (response.statusCode == 202) {
      print("inside if");
      print(response.statusCode);
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<void> deleteCalculation() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    print(headers);

    var request = http.Request('DELETE', Uri.parse('http://10.0.2.2:8081/deleteCalculation/$calculationId'));
    print(request);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    print("before if");
    if (response.statusCode == 200) {
      print("inside if");
      print(response.statusCode);
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  // Future<List<int>> fetchThePlans() async {
  //   print("Inside fetchPlan");
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int id = prefs.getInt('userId') ?? 0;
  //   print("Found Id is : $id");
  //
  //   var headers = {
  //     'Content-Type': 'application/json'
  //   };
  //   print(headers);
  //   int currentYear = DateTime.now().year;
  //
  //   var request = http.Request('GET', Uri.parse('http://10.0.2.2:8081/getPlans/$id/$currentYear'));
  //   print(request);
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   print(response);
  //
  //   print("before if");
  //   if (response.statusCode == 200) {
  //     print("after if");
  //     print(response.statusCode);
  //     String responseBody = await response.stream.bytesToString();
  //     print(responseBody);
  //
  //     // Parse the response body
  //     List<dynamic> planData = json.decode(responseBody)['data'];
  //     print("Plan Data: $planData");
  //
  //     // Extract plan IDs
  //     List<int> planIds = planData.map<int>((plan) => plan['id'] as int).toList();
  //     print("Plan IDs: $planIds");
  //
  //     return planIds;
  //   } else {
  //     print(response.reasonPhrase);
  //     return [];
  //   }
  // }

  List<PaymentEntry> paymentHistory = [];

  Future<void> fetchHistory(int userId, int planId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('userId') ?? 0;
    print('The Found Id is : $id');

    var headers = {
      'Content-Type': 'application/json'
    };
    print(headers);
    var request = http.Request('GET', Uri.parse('http://10.0.2.2:8081/getHistory/$id/$planId'));
    print(request);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    print("before if");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("inside if");
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> responseData = json.decode(responseBody);

      if (responseData.containsKey('data')) {
        List<dynamic> data = responseData['data'];
        // Parse response and add payment entries to paymentHistory list
        paymentHistory.addAll(data.map((entry) => PaymentEntry(
            date: entry['date'] ?? '',
            paidAmount: double.parse(entry['paid_amount']?.toString() ?? '0.0'),
            paidFrom: entry['paid_from'] ?? '',
            paidTo: entry['paid_to'] ?? '',
            debitedFrom: entry['debited_from'] ?? '',
            paid_status: entry['paid_status'] ?? true,
            planId: int.parse(entry['plan_id'] ?.toString() ?? '0')
        )));
      } else {
        print('Data is missing in the response');
      }
    } else {
      print('Failed to fetch payment history: ${response.reasonPhrase}');
    }
  }

  void updateTotalPayment() {
    double paymentSum = paymentHistory.fold(0, (previousValue, element) => previousValue + element.paidAmount);
    setState(() {
      totalPayment = paymentSum;
      calculatePending();
    });
  }

  Future<void> fetchPlanAndHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('userId') ?? 0;

    var headers = {'Content-Type': 'application/json'};
    int currentYear = DateTime.now().year;
    var request = http.Request('GET', Uri.parse('http://10.0.2.2:8081/getPlans/$id/$currentYear'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    List<int> fetchedPlanIds = [];

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      List<dynamic> planData = json.decode(responseBody)['data'];
      fetchedPlanIds = planData.map<int>((plan) => plan['id'] as int).toList();

      for (int planId in fetchedPlanIds) {
        await fetchHistory(id, planId);
      }

      updateTotalPayment();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<List<int>> fetchThePlans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('userId') ?? 0;
    print("Found Id is : $id");

    var headers = {
      'Content-Type': 'application/json'
    };

    int currentYear = DateTime.now().year;

    var request = http.Request('GET', Uri.parse('http://10.0.2.2:8081/getPlans/$id/$currentYear'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    List<int> fetchedPlanIds = [];

    if (response.statusCode == 200) {
      print("after if");
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      print(responseBody);

      // Parse the response body
      List<dynamic> planData = json.decode(responseBody)['data'];
      print("Plan Data: $planData");

      // Extract plan IDs
      fetchedPlanIds = planData.map<int>((plan) => plan['id'] as int).toList();
      print("Plan IDs: $fetchedPlanIds");
    } else {
      print(response.reasonPhrase);
    }

    return fetchedPlanIds;
  }

  double pendingAmount = 0.0.roundToDouble();

  void calculatePending(){
    pendingAmount = totalZakath - totalPayment;
  }

  @override
  void initState() {
    super.initState();
    fetchCalculation();
    updateCalculation();
    fetchThePlans();
    fetchHistory(id,planId);
    fetchPlanAndHistory();
    calculatePending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBEDFA),
      appBar: AppBar(
        title: Text(
          'Account',
          style: appTextStyle,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFAC6594),
        toolbarHeight: 100,
      ),
      body: GestureDetector(
        onTap: (){
          setState(() {
            _isExpanded=!_isExpanded;
          });
        },
        child: Stack(
          children: [
            Visibility(
              visible: _isExpanded,
              child: Center(
                child: Image.asset(
                  'images/Account.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (     BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });},
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kPeachColor,
                                      width: 1.5
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
                              child: Column(
                                children: [
                                Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ExpandablePanel(
                                header: Text(
                                'Ramadan Tips',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kPeachColor,
                                    fontSize: 15
                                  ),
                                ),
                                collapsed: Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting'
                                      'industry. Lorem Ipsum has been the industry''s standard dummy text'
                                      'ever since the 1500s, when an unknown printer took a galley of type'
                                      'and scrambled it to make a type specimen book.',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12
                                  ),
                                ),
                                expanded: Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting'
                                      'industry. Lorem Ipsum has been the industry''s standard dummy text'
                                      'ever since the 1500s, when an unknown printer took a galley of type'
                                      'and scrambled it to make a type specimen book.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('Ramadan day - 1', style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kPeachColor,
                                    fontSize: 15
                                ),),
                              ),
                            )
                                ],
                              ),
                            )
                            ),
                          SizedBox(height: 30,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: kPeachColor
                              )
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Zakath Calculation',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900,
                                          color: kPeachColor
                                        ),
                                      ),
                                    ),
                                    FloatingActionButton.small(onPressed: () {
                                      setState(() {
                                        _isExpanded = !_isExpanded; // Toggle expansion state
                                      });
                                    },
                                      child: Icon(
                                        _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down, // Change icon based on expansion state
                                        size: 30,
                                        color: Colors.white,
                                      ),

                                      backgroundColor: kPeachColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20,),
                                if(_isExpanded)
                                  Column(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Gold',style: comTextStyle,),
                                                Text('Carat',style: followTextStyle,),
                                                Text('Grams',style: followTextStyle,),
                                                Text('Amount',style: followTextStyle,),
                                                Text('Zakath',style: followTextStyle,),
                                              ],
                                            ),
                                          ),
                                          kDiv2,
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(''),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 30),
                                                  child: Text('$carat1 carat ',style: belowTextStyle,),
                                                ),
                                                Text('$goldGram1',style: belowTextStyle,),
                                                Text('$goldAmount1',style: belowTextStyle,),
                                                Text('$goldZakath1',style: belowTextStyle,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Gold',style: comTextStyle,),
                                                Text('Carat',style: followTextStyle,),
                                                Text('Grams',style: followTextStyle,),
                                                Text('Amount',style: followTextStyle,),
                                                Text('Zakath',style: followTextStyle,),
                                              ],
                                            ),
                                          ),
                                          kDiv2,
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(''),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 30),
                                                  child: Text('$carat2 carat ',style: belowTextStyle,),
                                                ),
                                                Text('$goldGram2',style: belowTextStyle,),
                                                Text('$goldAmount2',style: belowTextStyle,),
                                                Text('$goldZakath2',style: belowTextStyle,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Silver',style: comTextStyle,),
                                            Text('Grams',style: followTextStyle,),
                                            Text('Amount',style: followTextStyle,),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 40.0),
                                              child: Text('Zakath',style: followTextStyle,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      kDiv2,
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(''),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 40),
                                              child: Text('$silverGrams ',style: belowTextStyle,),
                                            ),
                                            Text('$silverAmount',style: belowTextStyle,),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 45.0),
                                              child: Text('$silverZakath',style: belowTextStyle,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Income',style: comTextStyle,),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Text('Amount',style: followTextStyle,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 90),
                                                  child: Text('Zakath',style: followTextStyle,),
                                                ),
                                              ],
                                            ),
                                          ),
                                          kDiv2,
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(''),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 30),
                                                  child: Text('$totalIncome ',style: belowTextStyle,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 100.0),
                                                  child: Text('$incomeZakath',style: belowTextStyle,),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Cash',style: comTextStyle,),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Text('Amount',style: followTextStyle,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 90),
                                                  child: Text('Zakath',style: followTextStyle,),
                                                ),
                                              ],
                                            ),
                                          ),
                                          kDiv2,
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(''),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 30),
                                                  child: Text('$totalCash ',style: belowTextStyle,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 100.0),
                                                  child: Text('$cashZakath',style: belowTextStyle,),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 40,),
                                    ],
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
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
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Total Zakath',style: TextStyle(
                                                color: kPeachColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),),
                                              SizedBox(width: 10,),
                                              Text(totalZakath.toString(),
                                                style: TextStyle(
                                                  color: kPeachColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 25,),
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
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Paid Zakath',style: TextStyle(
                                                  color: kPeachColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              SizedBox(width: 10,),
                                              StatefulBuilder(
                                                builder: (context, setState) {
                                                  return Text(
                                                    totalPayment.toString(), // Display totalPayment
                                                    style: TextStyle(
                                                      color: kPeachColor,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 25,),
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
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Pending Zakath',style: TextStyle(
                                                  color: kPeachColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              SizedBox(width: 10,),
                                              Text(pendingAmount.toStringAsFixed(2),style: TextStyle(
                                                  color: kPeachColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 25,),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: _isExpanded,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: Color(0xFF88047E)
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
                                                      backgroundColor: Color(0xFF88047E),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(2),
                                                      )
                                                  ),
                                                  onPressed:(){
                                                      Navigator.pushNamed(context, DistributePlan.id);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Text(
                                                      isDistributionDone ? 'Edit Distribute' : 'Distribute Zakath',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 1.0),
                                              child: Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Color(0xFF88047E)
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
                                                        backgroundColor: Color(0xFF88047E),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(2)
                                                        )
                                                    ),
                                                    onPressed:(){
                                                      if(isCalculationDone){

                                                      }
                                                      else{
                                                        Navigator.pushNamed(context, SingleCalculatePage.id);
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Text(
                                                        isCalculationDone? 'Edit Calculation' : 'Calculate Zakath',
                                                        style: TextStyle(
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
                                      ),
                                      SizedBox(height: 25,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color(0xFFAC6594)
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
                                                      backgroundColor: Color(0xFFAC6594),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(2)
                                                      )
                                                  ),
                                                  onPressed:(){
                                                    Navigator.pushNamed(context, EditCalculation.id);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Text('Edit',style: TextStyle(
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
                                      SizedBox(height: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: Color(0xFFFD3A84)
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
                                                      backgroundColor: Color(0xFFFD3A84),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(2)
                                                      )
                                                  ),
                                                  onPressed:(){
                                                    deleteCalculation();
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Text('Delete',style: TextStyle(
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
                                SizedBox(height: 2,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                    },
                    childCount: 1
                  )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}