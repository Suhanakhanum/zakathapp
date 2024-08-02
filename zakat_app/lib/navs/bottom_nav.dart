import 'package:flutter/material.dart';
import 'package:zakat_app/screens/accounts.dart';
import 'package:zakat_app/screens/distribute_plan_screen.dart';
import 'package:zakat_app/screens/payment_screen.dart';
import 'package:zakat_app/screens/showHistoryScreen.dart';
import 'package:zakat_app/screens/show_bottom_sheet.dart';
import '../constants/constants.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SingleChildScrollView(
        child: Container(
          height: 110,
          child: BottomNavigationBar(
            elevation: 20.0,
            showSelectedLabels: true,
            showUnselectedLabels: true,

            selectedLabelStyle: TextStyle(fontSize: 16,
                fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 16,
                fontWeight: FontWeight.bold,),

            selectedItemColor: Color(0xFFAC6594),
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
              if (index == 3) {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom
                        ),
                        child: ShowBottomSheet(),
                      ),
                    )
                );
              }
              if(index==1){
                Navigator.pushNamed(context, DistributePlan.id);
              }
              if(index==2){
                Navigator.pushNamed(context, ShowHistory.id);
              }
              if(index==0){
                Navigator.pushNamed(context, Accounts.id);
              }
            },
            items: [
              BottomNavigationBarItem(
                icon:Image.asset('images/home.webp',
                height: 35,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('images/distribute.webp',
                  height: 35,),
                label: 'Distribute Plan',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('images/paid.webp',
                  height: 35,),
                label: 'Paid History',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('images/menu.webp',
                  height: 35,),
                label: 'Menu',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
