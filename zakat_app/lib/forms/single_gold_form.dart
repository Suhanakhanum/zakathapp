import 'package:flutter/material.dart';
import 'package:zakat_app/display_column.dart';
import 'package:zakat_app/fields/distribute_plan_field.dart';
import 'package:zakat_app/fields/form_field_for_gold.dart';
import 'package:zakat_app/fields/form_total_amount_field.dart';
import 'package:zakat_app/fields/last_field_of_calculate_only.dart';
import 'package:zakat_app/fields/total_zakath_of_both_fields.dart';
import 'package:zakat_app/fields/zakath_for_now_field.dart';
import 'package:zakat_app/screens/distribute_plan_screen.dart';
import '../constants/constants.dart';

class SingleGoldForm extends StatefulWidget {
  const SingleGoldForm({super.key});

  @override
  State<SingleGoldForm> createState() => _SingleGoldFormState();
}

class _SingleGoldFormState extends State<SingleGoldForm> {
  TextEditingController caratController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController goldRateController = TextEditingController();
  TextEditingController zakathController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  bool showForm = false;
  double carat = 0.0;
  double grams = 0.0;
  double rate = 0.0;
  double totalAmount1 = 0.0;
  double totalAmount2 = 0.0;
  double zakathAmount1 = 0.0;
  double zakathAmount2 = 0.0;
  double zakath=0.0;
  bool isButtonEnabled=false;
  bool isButtonEnabled1=false;
  TextEditingController caratController1 = TextEditingController();
  TextEditingController gramsController1 = TextEditingController();
  TextEditingController goldRateController1 = TextEditingController();
  TextEditingController zakathController1 = TextEditingController();
  TextEditingController totalAmountController1 = TextEditingController();
  TextEditingController totalZakathFromBothController = TextEditingController();
  void calculateZakat() {
    carat = double.tryParse(caratController.text) ?? 0;
    grams = double.tryParse(gramsController.text) ?? 0;
    rate = double.tryParse(goldRateController.text) ?? 0;
    totalAmount1 = grams * rate;
    zakathAmount1 = totalAmount1 * 0.025;
    totalAmountController.text = totalAmount1.toStringAsFixed(2);
    zakathController.text = zakathAmount1.toStringAsFixed(2);
  }

  void calculateZakat1() {
    carat = double.tryParse(caratController1.text) ?? 0;
    grams = double.tryParse(gramsController1.text) ?? 0;
    rate = double.tryParse(goldRateController1.text) ?? 0;
    totalAmount2 = grams * rate;
    zakathAmount2 = totalAmount2 * 0.025;
    totalAmountController1.text = totalAmount2.toStringAsFixed(2);
    zakathController1.text = zakathAmount2.toStringAsFixed(2);
  }

  void totalZakathCalculation() {
    zakath = zakathAmount1 + zakathAmount2;
    totalZakathFromBothController.text = zakath.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
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
                          backgroundColor: isButtonEnabled? const Color(0xFF88047E) : const Color(0xFFADADAD),
                        ),
                        onPressed: isButtonEnabled? () {
                          calculateZakat();
                          totalZakathCalculation();
                        }:null,
                        child: Text('Calculate', style: barTextStyle)),
                  ),
                  Forms_total_amount_field(controller: totalAmountController,amt: totalAmount1,),
                  Zakath_for_now(controller: zakathController,zamt: zakathAmount1,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                      onPressed: isButtonEnabled? () {
                        setState(() {
                          showForm = !showForm;
                        });
                      }: null,
                      child: Text('Different Gold Carat', style: barTextStyle),
                      style: TextButton.styleFrom(
                          backgroundColor: isButtonEnabled ? const Color(0xFF88047E) : const Color(0xFFADADAD),
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
                                      backgroundColor: isButtonEnabled1? const Color(0xFF88047E) : const Color(0xFFADADAD),
                                    ),
                                    onPressed: isButtonEnabled1? () {
                                      calculateZakat1();
                                      totalZakathCalculation();
                                    }:null,
                                    child: Text('Calculate', style: barTextStyle)),
                              ),
                              Forms_total_amount_field(
                                controller: totalAmountController1,amt: totalAmount2,),
                              Zakath_for_now(controller: zakathController1, zamt: zakathAmount2)
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
        LastField(),
        DisplayColumn()
      ],
    );
  }
  @override
  void initState() {
    caratController.addListener(updateButtonState);
    gramsController.addListener(updateButtonState);
    goldRateController.addListener(updateButtonState);
    caratController1.addListener(updateButtonState1);
    gramsController1.addListener(updateButtonState1);
    goldRateController1.addListener(updateButtonState1);
    super.initState();
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = caratController.text.isNotEmpty &&
          gramsController.text.isNotEmpty &&
          goldRateController.text.isNotEmpty;
    });
  }

  void updateButtonState1() {
    setState(() {
      isButtonEnabled1 = caratController1.text.isNotEmpty &&
          gramsController1.text.isNotEmpty &&
          goldRateController1.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    caratController.dispose();
    gramsController.dispose();
    super.dispose();
  }
}