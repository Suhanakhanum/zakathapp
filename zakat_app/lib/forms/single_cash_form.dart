import 'package:flutter/material.dart';
import 'package:zakat_app/display_column.dart';
import 'package:zakat_app/fields/distribute_plan_field.dart';
import 'package:zakat_app/fields/form_field_for_gold.dart';
import 'package:zakat_app/fields/last_field_of_calculate_only.dart';
import 'package:zakat_app/fields/zakath_for_now_field.dart';
import 'package:zakat_app/screens/distribute_plan_screen.dart';
import '../constants/constants.dart';

class SingleCashForm extends StatefulWidget {
  const SingleCashForm({super.key});

  @override
  State<SingleCashForm> createState() => _SingleCashFormState();
}

class _SingleCashFormState extends State<SingleCashForm> {
  TextEditingController cashController=TextEditingController();
  TextEditingController liabilityController=TextEditingController();
  TextEditingController zakathController=TextEditingController();
  double zakathAmount=0.0;
  bool isButtonEnabled=false;
  void calculateZakat() {
    double cash = double.tryParse(cashController.text) ?? 0;
    double liability = double.tryParse(liabilityController.text) ?? 0;
    double totalAmount = cash-liability ;
    zakathAmount=totalAmount*0.025;
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
                      controller: cashController,
                      hints: 'Enter Cash you have'
                  ),
                  Form_field_for_gold(
                      controller: liabilityController,
                      hints: 'Liability'
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
                  Zakath_for_now(controller: zakathController, zamt: zakathAmount),
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
    cashController.addListener(updateButtonState);
    liabilityController.addListener(updateButtonState);
    super.initState();
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = cashController.text.isNotEmpty&&liabilityController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    cashController.dispose();
    liabilityController.dispose();
    super.dispose();
  }
}