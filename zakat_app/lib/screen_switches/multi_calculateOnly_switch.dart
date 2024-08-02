import 'package:flutter/material.dart';
import 'package:zakat_app/fields/distribute_plan_field.dart';
import 'package:zakat_app/fields/last_field_of_calculate_only.dart';
import 'package:zakat_app/screens/distribute_plan_screen.dart';
import '../constants/constants.dart';
import '../forms/multi_gold_form.dart';
import '../forms/multi_income_form.dart';
import '../forms/multi_cash_form.dart';
import '../forms/multi_silver_form.dart';

class MultiCalculateOnlySwitch extends StatefulWidget {
  const MultiCalculateOnlySwitch({super.key});

  @override
  State<MultiCalculateOnlySwitch> createState() => _MultiCalculateOnlySwitchState();
}

class _MultiCalculateOnlySwitchState extends State<MultiCalculateOnlySwitch> {
  TextEditingController zakathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                MultiGoldForm(),
                                SizedBox(height: 5,),
                                Text(
                                    'Note: It applies if you have 75 grams of gold or more'),
                                SizedBox(height: 150,),
                                MultiIncomeForm(),
                                SizedBox(height: 5,),
                                Text(
                                    'Note: It applies if you have 5 Lakhs income or more'),
                                SizedBox(height: 150,),
                                MultiCashForm(),
                                SizedBox(height: 5,),
                                Text(
                                    'Note: It applies if you have 15 Lakhs income or more'),
                                SizedBox(height: 150,),
                                MultiSilverForm(),
                                SizedBox(height: 5,),
                                Text(
                                    'Note: It applies if you have 100 grams of silver or more'),
                                SizedBox(height: 70,),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 35, right: 35),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .stretch,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF0F78A1),
                                                  border: Border.all(
                                                      color: kPeachColor,
                                                      width: 1
                                                  )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    4.0),
                                                child: TextField(
                                                  controller: zakathController,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    hintText: 'Your Zakat for now is',
                                                    hintStyle: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white70
                                                    ),
                                                  ),),
                                              )),
                                        ),
                                        SizedBox(height: 10,),
                                        LastField()
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1,
              )
          )
        ]
    );
  }
}