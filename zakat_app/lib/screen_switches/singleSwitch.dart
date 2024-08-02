import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zakat_app/display_column.dart';
import 'package:zakat_app/fields/form_field_for_gold.dart';
import 'package:zakat_app/fields/form_total_amount_field.dart';
import 'package:zakat_app/fields/show_popup.dart';
import 'package:zakat_app/fields/total_zakath_of_both_fields.dart';
import 'package:zakat_app/fields/zakath_for_now_field.dart';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SingleSwitch extends StatefulWidget  {

  @override
  State<SingleSwitch> createState() => _SingleSwitchState();
}

class _SingleSwitchState extends State<SingleSwitch>
    with SingleTickerProviderStateMixin{

  TextEditingController caratController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController goldRateController = TextEditingController();
  TextEditingController zakathController1 = TextEditingController();
  TextEditingController totalAmountController1 = TextEditingController();

  TextEditingController caratController1 = TextEditingController();
  TextEditingController gramsController1 = TextEditingController();
  TextEditingController goldRateController1 = TextEditingController();
  TextEditingController zakathController2 = TextEditingController();
  TextEditingController totalAmountController2 = TextEditingController();
  TextEditingController totalZakathFromBothController = TextEditingController();

  TextEditingController incomeController=TextEditingController();
  TextEditingController liabilityController1=TextEditingController();
  TextEditingController zakathController3=TextEditingController();

  TextEditingController cashController=TextEditingController();
  TextEditingController liabilityController2=TextEditingController();
  TextEditingController zakathController4=TextEditingController();

  TextEditingController silverGramsController=TextEditingController();
  TextEditingController silverRateController=TextEditingController();
  TextEditingController zakathController5=TextEditingController();
  TextEditingController totalAmountController3=TextEditingController();

  TextEditingController totalZakathController=TextEditingController();

  bool isButtonEnabled1=false;
  bool isButtonEnabled2=false;
  bool isButtonEnabled3=false;
  bool isButtonEnabled4=false;
  bool isButtonEnabled5=false;
  bool isButtonEnabled6=false;
  bool isButtonEnabled7=false;
  bool isButtonEnabled8=false;
  bool isButtonEnabled9=false;

  bool showForm = false;
  double carat = 0.0;
  double grams = 0.0;
  double rate = 0.0;
  double carat1 = 0.0;
  double grams1 = 0.0;
  double rate1 = 0.0;
  double totalAmount1 = 0.0;
  double totalAmount2 = 0.0;
  double totalAmount3 = 0.0;
  double zakathAmount1 = 0.0;
  double zakathAmount2 = 0.0;
  double zakath=0.0;
  double zakathAmount3=0.0;
  double zakathAmount4=0.0;
  double zakathAmount5=0.0;
  double Sgrams = 0.0;
  double Srate = 0.0;


  void calculateZakat1() {
    carat = double.tryParse(caratController.text) ?? 0;
    grams = double.tryParse(gramsController.text) ?? 0;
    rate = double.tryParse(goldRateController.text) ?? 0;
    totalAmount1 = grams * rate;
    zakathAmount1 = totalAmount1 * 0.025;
    totalAmountController1.text = totalAmount1.toStringAsFixed(2);
    zakathController1.text = zakathAmount1.toStringAsFixed(2);
    totalZakathOfAllTheAssets();
  }

  void calculateZakat2() {
    carat1 = double.tryParse(caratController1.text) ?? 0;
    grams1 = double.tryParse(gramsController1.text) ?? 0;
    rate1 = double.tryParse(goldRateController1.text) ?? 0;
    totalAmount2 = grams1 * rate1;
    zakathAmount2 = totalAmount2 * 0.025;
    totalAmountController2.text = totalAmount2.toStringAsFixed(2);
    zakathController2.text = zakathAmount2.toStringAsFixed(2);
    totalZakathOfAllTheAssets();
  }

  void totalZakathCalculation() {
    zakath = zakathAmount1 + zakathAmount2;
    totalZakathFromBothController.text = zakath.toStringAsFixed(2);
  }

  void calculateZakat3() {
    double income = double.tryParse(incomeController.text) ?? 0;
    double liability = double.tryParse(liabilityController1.text) ?? 0;
    double totalAmount =  income-liability;
    zakathAmount3=totalAmount*0.025;
    zakathController3.text = zakathAmount3.toStringAsFixed(2);
    totalZakathOfAllTheAssets();
  }

  void calculateZakat4() {
    double cash = double.tryParse(cashController.text) ?? 0;
    double liability = double.tryParse(liabilityController2.text) ?? 0;
    double totalAmount = cash-liability ;
    zakathAmount4=totalAmount*0.025;
    zakathController4.text = zakathAmount4.toStringAsFixed(2);
    totalZakathOfAllTheAssets();
  }

  void calculateZakat5() {
     Sgrams = double.tryParse(gramsController.text) ?? 0;
     Srate = double.tryParse(silverRateController.text) ?? 0;
    totalAmount3 =  Sgrams * Srate;
     zakathAmount5=totalAmount3*0.025;
    totalAmountController3.text=totalAmount3.toStringAsFixed(2);
    zakathController5.text = zakathAmount5.toStringAsFixed(2);
     totalZakathOfAllTheAssets();
  }

  void totalZakathOfAllTheAssets(){
    totalZakath = zakathAmount1 + zakathAmount2 +
        zakathAmount3 + zakathAmount4 +
        zakathAmount5;
    totalZakathController.text =totalZakath.toStringAsFixed(2);
  }

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

          caratController.text=carat1data.toString();
          gramsController.text=goldGram1.toString();
          // goldRateController.text=rate1data.toString();
          caratController1.text=carat2.toString();
          gramsController1.text=goldGram2.toString();
          // goldRateController1.text=rate2.toString();
          silverGramsController.text=silverGrams.toString();
          // silverRateController.text=price.toString();
          incomeController.text=totalIncome.toString();
          cashController.text=totalCash.toString();
          totalZakathController.text=totalZakath.toString();

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
      "gold_carat_type_one": caratController.text,
      "total_grams_of_gold_type_one":gramsController.text,
      "gold_price_type_one":goldRateController.text,
      "goldAmountOne":totalAmountController1.text,
      "goldZakathOne":zakathController1.text,
      "gold_carat_type_two":caratController1.text,
      "total_grams_of_gold_type_two":gramsController1.text,
      "gold_price_type_two":goldRateController1.text,
      "goldAmountTwo":totalAmountController2.text,
      "goldZakathTwo":zakathController2.text,
      "total_grams_of_silver":silverGramsController.text,
      "silver_price":silverRateController.text,
      "silverAmount":totalAmountController3.text,
      "silverZakath":zakathController5.text,
      "total_income":incomeController.text,
      "incomeLiability":liabilityController1.text,
      "incomeZakath":zakathController3.text,
      "total_cash":cashController.text,
      "cashLiability":liabilityController2.text,
      "cashZakath":zakathController4.text,
      "totalZakath":totalZakathController.text,
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(child: Text('Gold',style: tabbuttonStyle,)),
              Tab(child: Text('Income',style: tabbuttonStyle,)),
              Tab(child: Text('Cash',style: tabbuttonStyle,)),
              Tab(child: Text('Silver',style: tabbuttonStyle,)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFF8F8F8),
                                    border: Border.all(
                                        color: kPeachColor,
                                        width: 1
                                    )
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Form_field_for_gold(
                                            controller: caratController,
                                            hints: 'Which Carat of Gold'
                                        ),
                                        Form_field_for_gold(
                                            controller: gramsController,
                                            hints: 'How Many Grams'
                                        ),
                                        Form_field_for_gold(
                                            controller: goldRateController,
                                            hints: 'Today''s Gold rate'
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                shape: BeveledRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        6.0)
                                                ),
                                                backgroundColor: isButtonEnabled1? const Color(0xFF88047E) : const Color(0xFFADADAD),
                                              ),
                                              onPressed: isButtonEnabled1? () {
                                                calculateZakat1();
                                                totalZakathCalculation();
                                              }:null,
                                              child: Text('Calculate', style: barTextStyle)),
                                        ),
                                        Forms_total_amount_field(controller: totalAmountController1,amt: totalAmount1,),
                                        Zakath_for_now(controller: zakathController1,zamt: zakathAmount1,),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: TextButton(
                                            onPressed: isButtonEnabled1? () {
                                              setState(() {
                                                showForm = !showForm;
                                              });
                                            }: null,
                                            child: Text('Different Gold Carat', style: barTextStyle),
                                            style: TextButton.styleFrom(
                                                backgroundColor: isButtonEnabled1 ? const Color(0xFF88047E) : const Color(0xFFADADAD),
                                                shape: BeveledRectangleBorder(
                                                    borderRadius: BorderRadius.circular(6.0)
                                                )
                                            ),
                                          ),
                                        ),
                                        if(showForm)
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF8F8F8),
                                                border: Border.all(
                                                    color: kPeachColor,
                                                    width: 2
                                                )
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Form_field_for_gold(
                                                        controller: caratController1,
                                                        hints: 'Which Carat of Gold'
                                                    ),
                                                    Form_field_for_gold(
                                                        controller: gramsController1,
                                                        hints: 'How Many Grams'
                                                    ),
                                                    Form_field_for_gold(
                                                        controller: goldRateController1,
                                                        hints: 'Today''s Gold rate'
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: TextButton(
                                                          style: TextButton.styleFrom(
                                                            shape: BeveledRectangleBorder(
                                                                borderRadius: BorderRadius.circular(
                                                                    6.0)
                                                            ),
                                                            backgroundColor: isButtonEnabled2? const Color(0xFF88047E) : const Color(0xFFADADAD),
                                                          ),
                                                          onPressed: isButtonEnabled2? () {
                                                            calculateZakat2();
                                                            totalZakathCalculation();
                                                          }:null,
                                                          child: Text('Calculate', style: barTextStyle)),
                                                    ),
                                                    Forms_total_amount_field(
                                                      controller: totalAmountController2,amt: totalAmount2,),
                                                    Zakath_for_now(controller: zakathController2, zamt: zakathAmount2)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        Total_zakath_of_both_fields(controller: totalZakathFromBothController, tzamt: zakath)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: isButtonEnabled3? (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Popup();
                                        },
                                      );
                                    } :null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text('Save',style: barTextStyle,),
                                    ),
                                    style:TextButton.styleFrom(
                                        backgroundColor:isButtonEnabled2?Color(0xFF88047E) : Colors.grey,
                                        shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0)
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              DisplayColumn()
                            ],
                          );},
                        childCount:1,
                      )
                  )]),
            CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFF8F8F8),
                                    border: Border.all(
                                        color: kPeachColor,
                                        width: 1
                                    )
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Form_field_for_gold(
                                            controller: incomeController,
                                            hints: 'Enter your Income'
                                        ),
                                        Form_field_for_gold(
                                            controller: liabilityController1,
                                            hints: 'Liability'
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: TextButton(
                                            onPressed: isButtonEnabled4? (){
                                              calculateZakat3();
                                            }:null,
                                            child: Text('Calculate',style: barTextStyle),
                                            style:TextButton.styleFrom(
                                                backgroundColor: isButtonEnabled4 ? Color(0xFF88047E) : Colors.grey,
                                                shape: BeveledRectangleBorder(
                                                    borderRadius: BorderRadius.circular(6.0)
                                                )
                                            ),),
                                        ),
                                        Zakath_for_now(controller: zakathController3, zamt: zakathAmount3),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: isButtonEnabled5? (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Popup();
                                        },
                                      );
                                    } :null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text('Save',style: barTextStyle,),
                                    ),
                                    style:TextButton.styleFrom(
                                        backgroundColor:isButtonEnabled5?Color(0xFF88047E) : Colors.grey,
                                        shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0)
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              DisplayColumn()
                            ],
                          );},
                        childCount:1,
                      )
                  )]),
            CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return  Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFF8F8F8),
                                    border: Border.all(
                                        color: kPeachColor,
                                        width: 1
                                    )
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Form_field_for_gold(
                                            controller: cashController,
                                            hints: 'Enter Cash you have'
                                        ),
                                        Form_field_for_gold(
                                            controller: liabilityController2,
                                            hints: 'Liability'
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: TextButton(
                                            onPressed: isButtonEnabled6? (){
                                              calculateZakat4();
                                            }:null,
                                            child: Text('Calculate',style: barTextStyle),
                                            style:TextButton.styleFrom(
                                                backgroundColor: isButtonEnabled6 ? Color(0xFF88047E) : Colors.grey,
                                                shape: BeveledRectangleBorder(
                                                    borderRadius: BorderRadius.circular(6.0)
                                                )
                                            ),),
                                        ),
                                        Zakath_for_now(controller: zakathController4, zamt: zakathAmount4),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: isButtonEnabled7? (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Popup();
                                        },
                                      );
                                    } :null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text('Save',style: barTextStyle,),
                                    ),
                                    style:TextButton.styleFrom(
                                        backgroundColor:isButtonEnabled7?Color(0xFF88047E) : Colors.grey,
                                        shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0)
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              DisplayColumn()
                            ],
                          );},
                        childCount:1,
                      )
                  )]),
            CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return  Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFF8F8F8),
                                    border: Border.all(
                                        color: kPeachColor,
                                        width: 1
                                    )
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Form_field_for_gold(
                                            controller: silverGramsController,
                                            hints: 'How Many Grams'
                                        ),
                                        Form_field_for_gold(
                                            controller: silverRateController,
                                            hints: 'Today''s Silver rate'
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: TextButton(
                                            onPressed: isButtonEnabled8? (){
                                              calculateZakat5();
                                            }:null,
                                            child: Text('Calculate',style: barTextStyle),
                                            style:TextButton.styleFrom(
                                                backgroundColor: isButtonEnabled8 ? Color(0xFF88047E) : Colors.grey,
                                                shape: BeveledRectangleBorder(
                                                    borderRadius: BorderRadius.circular(6.0)
                                                )
                                            ),),
                                        ),
                                        Forms_total_amount_field(
                                          controller: totalAmountController3,amt: totalAmount3,),
                                        Zakath_for_now(controller: zakathController5, zamt: zakathAmount5)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: isButtonEnabled9? (){
                                      updateCalculation();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Popup();
                                        },
                                      );
                                    } :null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text('Save',style: barTextStyle,),
                                    ),
                                    style:TextButton.styleFrom(
                                        backgroundColor:isButtonEnabled9?Color(0xFF88047E) : Colors.grey,
                                        shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0)
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              DisplayColumn()
                            ],
                          );},
                        childCount:1,
                      )
                  )]),
          ],
        ),
      ),
    );
  }
  late TabController _nestedTabController;
  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 1, vsync: this);
    caratController.addListener(updateButtonState1);
    gramsController.addListener(updateButtonState1);
    goldRateController.addListener(updateButtonState1);
    caratController1.addListener(updateButtonState2);
    gramsController1.addListener(updateButtonState2);
    goldRateController1.addListener(updateButtonState2);
    zakathController1.addListener(updateButtonState3);
    zakathController2.addListener(updateButtonState3);
    incomeController.addListener(updateButtonState4);
    liabilityController1.addListener(updateButtonState4);
    zakathController3.addListener(updateButtonState5);
    cashController.addListener(updateButtonState6);
    liabilityController2.addListener(updateButtonState6);
    zakathController4.addListener(updateButtonState7);
    gramsController.addListener(updateButtonState8);
    silverRateController.addListener(updateButtonState8);
    zakathController5.addListener(updateButtonState9);
    fetchCalculation();
  }

  @override
  void dispose() {
    _nestedTabController.dispose();
    caratController.dispose();
    gramsController.dispose();
    incomeController.dispose();
    liabilityController1.dispose();
    cashController.dispose();
    liabilityController2.dispose();
    gramsController.dispose();
    silverRateController.dispose();
    super.dispose();
  }
//Gold
  void updateButtonState1() {
    setState(() {
      isButtonEnabled1 = caratController.text.isNotEmpty &&
          gramsController.text.isNotEmpty &&
          goldRateController.text.isNotEmpty;
    });
  }

  void updateButtonState2() {
    setState(() {
      isButtonEnabled2 = caratController1.text.isNotEmpty &&
          gramsController1.text.isNotEmpty &&
          goldRateController1.text.isNotEmpty;
    });
  }

  void updateButtonState3() {
    setState(() {
      isButtonEnabled3 = zakathController1.text.isNotEmpty
          || zakathController2.text.isNotEmpty;
    });
  }

  //Income
  void updateButtonState4() {
    setState(() {
      isButtonEnabled4 = incomeController.text.isNotEmpty&&liabilityController1.text.isNotEmpty;
    });
  }
  void updateButtonState5() {
    setState(() {
      isButtonEnabled5 = zakathController3.text.isNotEmpty;
    });
  }

  //Cash
  void updateButtonState6() {
    setState(() {
      isButtonEnabled6 = cashController.text.isNotEmpty&&liabilityController2.text.isNotEmpty;
    });
  }

  void updateButtonState7() {
    setState(() {
      isButtonEnabled7 = zakathController4.text.isNotEmpty;
    });
  }

  //Silver
  void updateButtonState8() {
    setState(() {
      isButtonEnabled8 = silverGramsController.text.isNotEmpty&&
          silverRateController.text.isNotEmpty;
    });
  }
  void updateButtonState9() {
    setState(() {
      isButtonEnabled9 = zakathController5.text.isNotEmpty;
    });
  }
}
