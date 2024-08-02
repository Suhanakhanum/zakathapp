import 'package:flutter/material.dart';
import 'package:zakat_app/fields/form_field_for_gold.dart';
import 'package:zakat_app/fields/form_total_amount_field.dart';
import 'package:zakat_app/fields/zakath_for_now_field.dart';
import '../constants/constants.dart';

class MultiSilverForm extends StatefulWidget {
  const MultiSilverForm({super.key});

  @override
  State<MultiSilverForm> createState() => _MultiSilverFormState();
}

class _MultiSilverFormState extends State<MultiSilverForm> {
  TextEditingController gramsController=TextEditingController();
  TextEditingController silverRateController=TextEditingController();
  TextEditingController zakathController=TextEditingController();
  TextEditingController totalAmountController=TextEditingController();
  bool isButtonEnabled=false;
  double totalAmount = 0.0;
  double zakathAmount= 0.0;
  void calculateZakat() {
    double grams = double.tryParse(gramsController.text) ?? 0;
    double rate = double.tryParse(silverRateController.text) ?? 0;
    totalAmount =  grams * rate;
    zakathAmount=totalAmount*0.025;
    totalAmountController.text=totalAmount.toStringAsFixed(2);
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
                    Text('Silver',style: TextStyle(
                        fontSize: 21.0,
                        color: kPeachColor,
                        fontWeight: FontWeight.bold
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
                  onPressed: isButtonEnabled?(){
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
              Forms_total_amount_field(
                controller: totalAmountController,amt: totalAmount,),
              Zakath_for_now(controller: zakathController, zamt: zakathAmount)
            ],
          ),
        ),
      ),
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