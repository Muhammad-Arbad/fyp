import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:http/http.dart' as http;

class ApiData extends StatefulWidget {
  const ApiData({Key? key}) : super(key: key);

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {
  @override
  Widget build(BuildContext context) {
    // return ScaffoldTemplate(appBarTitle:Text("API Data"),
    //     OurWidget: Container(),
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: () {
    //         getData();
    //       },
    //       child: Icon(Icons.add),
    //     ),
    //     ScaffoldTemplateBottomSheet: null);
    return Scaffold(
      appBar: AppBar(title: Text("Api Data"),),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }

  void getData() async{
    final uri = Uri.parse("https://apex.oracle.com/pls/apex/orants/acc/vtypes");
    final response = await http.get(uri);
    if(response.statusCode ==200){
      final data = jsonDecode(response.body);
      print(data['items'][1]['vr_id']);
      print(data);
    }
  }
}
