import 'package:flutter/material.dart';

class ScaffoldTemplate extends StatefulWidget {
  Widget? OurWidget,ScaffoldTemplateBottomSheet,appBarTitle,floatingActionButton;

  ScaffoldTemplate({Key? key,required this.appBarTitle,required this.OurWidget,required this.ScaffoldTemplateBottomSheet, this.floatingActionButton}) : super(key: key);

  //ScaffoldTemplate({required this.OurWidget});
  @override
  _ScaffoldTemplateState createState() => _ScaffoldTemplateState();
}

class _ScaffoldTemplateState extends State<ScaffoldTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:widget.appBarTitle!=null?AppBar(title: widget.appBarTitle):null,
      body: SafeArea(child:widget.OurWidget!),
      bottomSheet: widget.ScaffoldTemplateBottomSheet!=null?widget.ScaffoldTemplateBottomSheet:null,
      floatingActionButton:widget.floatingActionButton!=null?widget.floatingActionButton:null,
    );
  }
}
