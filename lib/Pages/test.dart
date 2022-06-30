import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/Template.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(OurWidget: Container(
      child: Text("Test"),),
    appBarTitle: null,
      ScaffoldTemplateBottomSheet: null,
      floatingActionButton: null,
    );
  }
}
