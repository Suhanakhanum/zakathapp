import 'package:flutter/material.dart';
import 'package:zakat_app/screens/accounts.dart';
import 'package:zakat_app/screens/autoPlan_updatedScreen.dart';
import 'package:zakat_app/screens/auto_plan_screen.dart';
import 'package:zakat_app/screens/calculate_only_screen.dart';
import 'package:zakat_app/screens/distribute_plan_screen.dart';
import 'package:zakat_app/screens/editCalculation.dart';
import 'package:zakat_app/screens/editProfileScreen.dart';
import 'package:zakat_app/screens/first_screen.dart';
import 'package:zakat_app/screens/login_screen.dart';
import 'package:zakat_app/screens/options_screen.dart';
import 'package:zakat_app/screens/ownPlan_updatedScreen.dart';
import 'package:zakat_app/screens/own_plan_screen.dart';
import 'package:zakat_app/screens/payment_screen.dart';
import 'package:zakat_app/screens/showHistoryScreen.dart';
import 'package:zakat_app/screens/sign_up_screen.dart';
import 'package:zakat_app/screens/sign_up_screen_two.dart';
import 'package:zakat_app/screens/single_calculate_page.dart';
import 'package:zakat_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
      routes: {
        FirstScreen.id: (context) => FirstScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        OptionScreen.id: (context) => OptionScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        SignUpScreenTwo.id: (context) => SignUpScreenTwo(),
        CalculateOnly.id: (context) => CalculateOnly(),
        LoginPage.id: (context) => LoginPage(),
        Accounts.id: (context) => Accounts(),
        SingleCalculatePage.id: (context) => SingleCalculatePage(),
        DistributePlan.id: (context) => DistributePlan(),
        AutoPlanScreen.id: (context) => AutoPlanScreen(),
        OwnPlanScreen.id: (context) => OwnPlanScreen(),
        PaymentScreen.id: (context) => PaymentScreen(planId: 0,),
        ShowHistory.id: (context) => ShowHistory(planId: 0,),
        EditCalculation.id: (context) => EditCalculation(),
        EditProfile.id: (context) => EditProfile(),
        AutoPlanUpdatedScreen.id: (context) => AutoPlanUpdatedScreen(),
        OwnPlanUpdatedScreen.id: (context) => OwnPlanUpdatedScreen()
      },

    );
  }
}