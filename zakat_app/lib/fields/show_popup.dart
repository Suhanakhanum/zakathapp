import 'package:flutter/material.dart';
import 'package:zakat_app/screens/accounts.dart';
import 'package:zakat_app/screens/distribute_plan_screen.dart';

class Popup extends StatefulWidget {
  const Popup({super.key});

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            color: Colors.white,
            height: 380, // Adjust the height as needed
            child: Column(
              children: [
                // AppBar
                AppBar(
                    toolbarHeight: 100,
                    automaticallyImplyLeading: false,
                    backgroundColor: Color(0xFF8B2B67),
                    title: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                            'images/SingleGoldForm.png'))
                ),
                // Body
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your calculation has been saved, to'
                        'distribute your zakat and track click on'
                        '\'Distribute zakat.' ,
                        style: TextStyle(fontSize: 14,
                            letterSpacing: 1.5
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFFFD3A84),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      6.0), // Adjust the radius as needed
                                ),
                              ),
                              onPressed: () {
                                // Handle button 1 action
                                Navigator.pushNamed(context, Accounts.id);
                              },
                              child: Text('Cancel',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF038690),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      6.0), // Adjust the radius as needed
                                ),
                              ),
                              onPressed: () {
                                // Handle button 2 action
                                Navigator.pushNamed(context, DistributePlan.id);
                              },
                              child: Text('Distribute Zakath',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14
                                ),),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}