import 'package:flutter/material.dart';
import 'package:zakat_app/display_column.dart';
import 'package:zakat_app/fields/distribute_plan_field.dart';
import 'package:zakat_app/fields/form_field_for_gold.dart';
import 'package:zakat_app/fields/form_total_amount_field.dart';
import 'package:zakat_app/fields/last_field_of_calculate_only.dart';
import 'package:zakat_app/fields/zakath_for_now_field.dart';
import 'package:zakat_app/screens/distribute_plan_screen.dart';
import '../constants/constants.dart';

class SingleSilverForm extends StatefulWidget {
  const SingleSilverForm({super.key});

  @override
  State<SingleSilverForm> createState() => _SingleSilverFormState();
}

class _SingleSilverFormState extends State<SingleSilverForm> {
  TextEditingController gramsController=TextEditingController();
  TextEditingController silverRateController=TextEditingController();
  TextEditingController zakathController=TextEditingController();
  TextEditingController totalAmountController=TextEditingController();
  bool isButtonEnabled=false;
  double totalAmount = 0.0;
  double zakathAmount=0.0;
  void calculateZakat() {
    double grams = double.tryParse(gramsController.text) ?? 0;
    double rate = double.tryParse(silverRateController.text) ?? 0;
    double totalAmount =  grams * rate;
    double zakathAmount=totalAmount*0.025;
    totalAmountController.text=totalAmount.toStringAsFixed(2);
    zakathController.text = zakathAmount.toStringAsFixed(2);
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
                      controller: gramsController,
                      hints: 'How Many Grams'
                  ),
                  Form_field_for_gold(
                      controller: silverRateController,
                      hints: 'Today''s Silver rate'
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                      onPressed: isButtonEnabled? (){
                        calculateZakat();
                      }:null,
                      child: Text('Calculate',style: barTextStyle),
                      style:TextButton.styleFrom(
                          backgroundColor: isButtonEnabled ? Color(0xFF88047E) : Colors.grey,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0)
                          )
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: textInOutShadow,
                      child: TextField(
                        controller: totalAmountController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Your Total Amount',
                          hintStyle: TextStyle(
                              fontSize: 20,
                            color: Color(0xFF0F78A1)
                          ),
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          )
                      ),),
                    ),
                  ),
                  Forms_total_amount_field(
                    controller: totalAmountController,amt: totalAmount,),
                  Zakath_for_now(controller: zakathController, zamt: zakathAmount)
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
    gramsController.addListener(updateButtonState);
    silverRateController.addListener(updateButtonState);
    super.initState();
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = gramsController.text.isNotEmpty&&
          silverRateController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    gramsController.dispose();
    silverRateController.dispose();
    super.dispose();
  }
}