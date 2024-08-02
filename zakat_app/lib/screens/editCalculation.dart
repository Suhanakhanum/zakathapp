import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:zakat_app/navs/bottom_nav.dart';

class EditCalculation extends StatefulWidget {
 static const String id ='editCalculation';

  @override
  State<EditCalculation> createState() => _EditCalculationState();
}

class _EditCalculationState extends State<EditCalculation> {

  TextEditingController caratController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController caratController1 = TextEditingController();
  TextEditingController gramsController1 = TextEditingController();
  TextEditingController silverGramsController = TextEditingController();
  TextEditingController incomeController = TextEditingController();
  TextEditingController cashController = TextEditingController();
  TextEditingController amountController=TextEditingController();
  TextEditingController zakathController=TextEditingController();
  TextEditingController yearController=TextEditingController();

  bool showForm = false;

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
  var zakath ;
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
        carat2 =data['gold_carat_type_two'].toString();
        goldGram2 =data['total_grams_of_gold_type_two'].toString();
        rate2 =data['gold_price_type_two'].toString();
        silverGrams =data['total_grams_of_silver'].toString();
        price = data['silver_price'].toString();
        totalIncome = data['total_income'].toString();
        totalCash = data['total_cash'].toString();
        zakath = data['zakath'].toString();
        year = data['year'].toString();


        setState(() {
          calculationId = calculationId;
          carat1 = carat1;
          goldGram1 = goldGram1;
          rate1 =rate1;
          carat2 =carat2;
          goldGram2 =goldGram2;
          rate2 =rate2;
          silverGrams =silverGrams;
          price = price;
          totalIncome =totalIncome;
          totalCash = totalCash;
          zakath = zakath;
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

          caratController.text=carat1;
          gramsController.text=goldGram1;
          caratController1.text=carat2;
          gramsController1.text=goldGram2;
          silverGramsController.text=silverGrams;
          incomeController.text=totalIncome;
          cashController.text=totalCash;

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
      "gold_carat_type_one": caratController.text,
      "total_grams_of_gold_type_one": gramsController.text,
      "gold_carat_type_two": caratController1.text,
      "total_grams_of_gold_type_two": gramsController1.text,
      "total_grams_of_silver": gramsController1.text,
      "total_grams_of_silver": silverGramsController.text,
      "total_income": incomeController.text,
      "total_cash": cashController.text,
      "year":currentYear

    });
    print(request.body);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    print("before if");
    if (response.statusCode == 202) {
      print("inside if");
      print(response.statusCode);
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  void initState() {
    super.initState();
    fetchCalculation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF65A2AC),
      body: SafeArea(
          child: CustomScrollView(
          slivers: [
          SliverList(
          delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
      return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0,bottom: 20),
              child: Column(
                children: [
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
                                backgroundColor: Color(0xFFA96391)

                              ),
                              onPressed:
                                  () {
                                setState(() {
                                  showForm = !showForm;
                                });
                              },
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
                                updateCalculation();
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
          );
      },
            childCount: 1,
          ),
          ),
          ],
          )
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
