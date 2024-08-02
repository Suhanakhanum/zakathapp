import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:zakat_app/forms/single_cash_form.dart';
import 'package:zakat_app/forms/single_gold_form.dart';
import 'package:zakat_app/forms/single_income_form.dart';
import 'package:zakat_app/forms/single_silver_form.dart';

class SingleCalculateOnlySwitch extends StatefulWidget  {

  @override
  State<SingleCalculateOnlySwitch> createState() => _SingleCalculateOnlySwitchState();
}

class _SingleCalculateOnlySwitchState extends State<SingleCalculateOnlySwitch>
    with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(child: Text('Gold',style: tabbuttonStyle,)),
              Tab(child: Text('Income',style: tabbuttonStyle,)),
              Tab(child: Text('Cash',style: tabbuttonStyle,)),
              Tab(child: Text('Silver',style: tabbuttonStyle,)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return SingleGoldForm();},
                        childCount:1,
                      )
                  )]),
            CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return SingleIncomeForm();},
                        childCount:1,
                      )
                  )]),
            CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return  SingleCashForm();},
                        childCount:1,
                      )
                  )]),
            CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return  SingleSilverForm();},
                        childCount:1,
                      )
                  )]),
          ],
        ),
      ),
    );
  }
  late TabController _nestedTabController;
  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _nestedTabController.dispose();
    super.dispose();
  }
}
