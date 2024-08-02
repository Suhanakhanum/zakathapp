import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zakat_app/constants/constants.dart';
import 'package:zakat_app/navs/bottom_nav.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat_app/screens/paymentEntry.dart';

class ShowHistory extends StatefulWidget {
  static const String id = 'showHistoryScreen';

  final int planId;

  const ShowHistory({Key? key, required this.planId}) : super(key: key);

  @override
  State<ShowHistory> createState() => _ShowHistoryState();
}

class _ShowHistoryState extends State<ShowHistory> {
  String date='';
  double paidAmount=0.0;
  String paidFrom='';
  String paidTo='';
  String debitedFrom='';
  int historyId=0;
  bool paid_status=true;

  List<PaymentEntry> paymentHistory = [];

  Future<void> fetchHistory() async {
    int planId = widget.planId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('userId') ?? 0;

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://10.0.2.2:8081/getHistory/$id/$planId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> responseData = json.decode(responseBody);

      if (responseData.containsKey('data')) {
        List<dynamic> data = responseData['data'];
        setState(() {
          // Clear existing payment history
          paymentHistory.clear();
          // Parse response and add payment entries to paymentHistory list
          paymentHistory.addAll(data.map((entry) => PaymentEntry(
            date: entry['date'] ?? '',
            paidAmount: double.parse(entry['paid_amount']?.toString() ?? '0.0'),
            paidFrom: entry['paid_from'] ?? '',
            paidTo: entry['paid_to'] ?? '',
            debitedFrom: entry['debited_from'] ?? '',
            paid_status: entry['paid_status'] ?? true,
            planId: entry['plan_id'] ?? 0
          )).toList());
        });
      } else {
        print('Data is missing in the response');
      }
    } else {
      print('Failed to fetch payment history: ${response.reasonPhrase}');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBEDFA),
      appBar: AppBar(
        title: Text(
          'History',
          style: appTextStyle,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFAC6594),
        toolbarHeight: 100,
      ),
      body: ListView.builder(
        itemCount: paymentHistory.length,
        itemBuilder: (context, index) {
          final payment = paymentHistory[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 255,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Color(0xFFAC6594),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: -1.0,
                    blurRadius: 4.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: -1.0,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color(0xFFAC6594),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Date : ${payment.date}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Paid Amount: ${payment.paidAmount}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFAC6594),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Paid From: ${payment.paidFrom}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFAC6594),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Paid To: ${payment.paidTo}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFAC6594),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Debited From: ${payment.debitedFrom}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFAC6594),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNav(),
    );
  }


}