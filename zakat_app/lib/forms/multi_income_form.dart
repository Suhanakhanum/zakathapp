import 'package:flutter/material.dart';
import 'package:zakat_app/fields/form_field_for_gold.dart';
import 'package:zakat_app/fields/zakath_for_now_field.dart';
import '../constants/constants.dart';

class MultiIncomeForm extends StatefulWidget {
  const MultiIncomeForm({super.key});

  @override
  State<MultiIncomeForm> createState() => _MultiIncomeFormState();
}

class _MultiIncomeFormState extends State<MultiIncomeForm> {
  TextEditingController incomeController=TextEditingController();
  TextEditingController liabilityController=TextEditingController();
  TextEditingController zakathController=TextEditingController();
  bool isButtonEnabled=false;
  double zakathAmount=0.0;
  void calculateZakat() {
    double income = double.tryParse(incomeController.text) ?? 0;
    double liability = double.tryParse(liabilityController.text) ?? 0;
    double totalAmount =  income-liability;
    zakathAmount=totalAmount*0.025;
    zakathController.text = zakathAmount.toStringAsFixed(2);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF8F8F8),
          border: Border.all(
              color: kPeachColor,
              width: 1
          )
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Income',style: TextStyle(
                        fontSize: 21.0,
                        color: kPeachColor,
                        fontWeight: FontWeight.w900
                    ),),
                    Text('Total:0000',style: TextStyle(
                      fontSize: 14.0,
                      color: kPeachColor,
                    ),)
                  ],
                ),
              ),
              kDiv,
              Form_field_for_gold(
                  controller: incomeController,
                  hints: 'Enter your Income'
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
                  child: Text('Calculate',style: barTextStyle,),
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
    );
  }
  @override
  void initState() {
    incomeController.addListener(updateButtonState);
    liabilityController.addListener(updateButtonState);
    super.initState();
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = incomeController.text.isNotEmpty&&liabilityController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    incomeController.dispose();
    liabilityController.dispose();
    super.dispose();
  }
}