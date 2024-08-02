import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat_app/auto_child1.dart';
import 'package:zakat_app/navs/bottom_nav.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:zakat_app/screens/monthData.dart';
import 'package:http/http.dart' as http;
import 'package:zakat_app/screens/ownPlan_updatedScreen.dart';
import 'package:zakat_app/screens/payment_screen.dart';

class OwnPlanScreen extends StatefulWidget {
  static const String id = 'own_plan_screen';

  @override
  State<OwnPlanScreen> createState() => _OwnPlanScreenState();
}

class _OwnPlanScreenState extends State<OwnPlanScreen> {
  List<MonthData> filledMonthDataList = [];
  int numberOfMonths = 0;
  late double screenWidth;
  late double screenHeight;
  bool isButtonEnabled=false;
  double tempAmount = 0.0;
  TextEditingController monthController=TextEditingController();
  final List<TextEditingController> _fieldControllers = [];
  final List<TextEditingController> _fieldControllersTwo = [];
  DateTime now = DateTime.now();
  int currentMonth = DateTime.now().month;
  List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July',
    'August', 'September', 'October', 'November', 'December'
  ];

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
          tempAmount=totalZakath;

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


  Future<void> savePlans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('userId') ?? 0;
    print("Found Id is : $id");

    int currentYear = DateTime.now().year;

    var headers = {
      'Content-Type': 'application/json'
    };
    print(headers);

    for(int i = 0; i < numberOfMonths; i++) {
      var request = http.Request('POST', Uri.parse('http://10.0.2.2:8081/plans/$id'));
      print(request);

      TextEditingController controller = _fieldControllers[i];
      TextEditingController controller2 = _fieldControllersTwo[i]; // Assuming _amountFieldControllers is a list of controllers for amount fields
      int currentMonthIndex = DateTime.now().month - 1;
      int monthIndex = (currentMonthIndex + i) % 12;
      double amount1 = double.tryParse(controller2.text) ?? 0.0;


      request.body = json.encode({
        "year": currentYear,
        "plan_type": "Own Plan",
        "month": monthIndex +1,
        "purpose": controller.text,
        "amount": amount1,
        "status": true
      });
      print("Request body: ${request.body}");
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response);

      print("Response status code: ${response.statusCode}");
      if (response.statusCode == 201) {
        print("Plans Saved Successfully");
        print(await response.stream.bytesToString());
      }
      else {
        print('Failed to save plan: ${response.reasonPhrase}');
        print(await response.stream.bytesToString());
      }
    }
  }


  double totalDeduction=0.0;
  @override
  void initState() {
    monthController.addListener(updateButtonState);
    super.initState();
    fetchCalculation();
  }
  void updateButtonState() {
    setState(() {
      isButtonEnabled= monthController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    monthController.dispose();
    super.dispose();
  }
  void updateAmount() {
    setState(() {
      totalDeduction = 0.0; // Reset total deduction
      for (TextEditingController controller in _fieldControllersTwo) {
        if (controller.text.isNotEmpty) {
          totalDeduction += double.parse(controller.text);
        }
      }
      tempAmount = totalZakath - totalDeduction;
    });
  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Own Plan',
          style: appTextStyle,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFAC6594),
        toolbarHeight: screenHeight * 0.1,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: textInOutShadow,
                          height: 80,
                          width: 450,
                          margin: EdgeInsets.only(left: 10.0, right: 10.0,top: 25.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFEBFE),
                              borderRadius: BorderRadius.circular(6.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: kPeachColor,
                                  width: 1
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text('MY TOTAL ZAKAT IS $totalZakath',
                                style: TextStyle(
                                    color: kPeachColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(screenWidth * 0.02, screenHeight * 0.03, screenWidth * 0.02, screenHeight * 0.01),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Months',
                                style: TextStyle(
                                  color: kPeachColor,
                                  fontSize: screenHeight * 0.025,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: kPeachColor,
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: -1.0,
                                          blurRadius: 5.0
                                      ),
                                      BoxShadow(
                                          color: Colors.white,
                                          spreadRadius: -1.0,
                                          blurRadius: 5.0
                                      ),]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: TextField(
                                    controller: monthController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '0',
                                      hintStyle: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontSize: 23
                                    ),
                                    cursorHeight: 15,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        numberOfMonths = int.tryParse(value) ?? 0;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
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
                                fontSize: screenHeight * 0.025,
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
                              '${tempAmount}',
                              style: TextStyle(
                                fontSize: screenHeight * 0.025,
                                color: Color(0xFF038690),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                          child: Text('deduction will happen while adding the money')),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    if (numberOfMonths > 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            numberOfMonths,
                                (index) {
                              int monthIndex = (currentMonth + index-1) % 12;
                              String monthName = monthNames[monthIndex];
                              TextEditingController newController= TextEditingController();
                              _fieldControllers.add(newController);
                              TextEditingController newControllerTwo=TextEditingController();
                              _fieldControllersTwo.add(newControllerTwo);
                              return Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(screenWidth * 0.02),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '$monthName',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: kPeachColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                style: BorderStyle.solid,
                                                color: Color(0xFFFFEBFE),
                                                width: 2.5
                                            )
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 4,right: 4),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 65,
                                                width: 250,
                                                child: Container(
                                                  decoration: textOutShadow,
                                                  child: TextField(
                                                    controller: _fieldControllers[index],
                                                    decoration: InputDecoration(
                                                        hintText: 'Where are u Planning to donate',
                                                        hintStyle: TextStyle(
                                                            color: kPeachColor,
                                                            fontSize: 14
                                                        ),
                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide.none,
                                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                                        )
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 65,
                                                width: 100,
                                                child: Container(
                                                  decoration: textOutShadow,
                                                  child: TextField(
                                                    onChanged: (value){
                                                      updateAmount();
                                                    },
                                                    controller: _fieldControllersTwo[index],
                                                    decoration: InputDecoration(
                                                        hintText: '0000',
                                                        hintStyle: TextStyle(
                                                            color: kPeachColor
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius: BorderRadius.all(Radius.circular(6))
                                                        )
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.02),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.1),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.01),
                            ),
                            backgroundColor: isButtonEnabled?Color(0xFF88047E):Color(0xFFADADAD),
                          ),
                          onPressed: isButtonEnabled? (){
                            savePlans();
                            Navigator.pushNamed(context, OwnPlanUpdatedScreen.id);
                          }:null,
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.015),
                            child: Text(
                              'Save Plan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.025,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.005, right: screenWidth * 0.005),
                          child: Container(
                            child: Text(
                              note,
                              style: TextStyle(
                                color: kPeachColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        )
                      ],
                    )
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}