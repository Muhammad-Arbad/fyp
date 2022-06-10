import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:http/http.dart' as http;

import '../Classes/introClass.dart';
import '../Functions/functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ApiData extends StatefulWidget {
  const ApiData({Key? key}) : super(key: key);

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {
  int row = 2;
  int col = 2;
  List<measurments> Parent = [];
  List<String> child = [];
  List<List<int>> i = [];
  List a = List.filled(3, List.filled(3, 0));

  //var twodlist = List.generate(row, (index) =>  List(col) ,growable: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(a[0][0]);
    Parent = getMeasurments();
    Future<int> count = customerCount();
  }

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
      //body: Container(),
      appBar: AppBar(title: Text("This is WebView"),),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     final newRec = FirebaseFirestore.instance.collection("tailors").doc("2");
      //     newRec.set({'name':'Arbad'});
      //   },
      // ),
      body: WebView(
        initialUrl: 'https://planetsid.com/',
      ),
      //body: Container(),
    );
    //Scaffold(
    //   appBar: AppBar(title: Text("Api Data"),),
    //   body: Container(
    //     child: Padding(
    //       padding: EdgeInsets.all(20),
    //       child: ReorderableListView.builder(
    //         itemCount: Parent.length,
    //         onReorder: (oldIndex,newIndex)=>setState(() {
    //           final index = newIndex >oldIndex ? newIndex-1:newIndex;
    //           final m = Parent.removeAt(oldIndex);
    //           Parent.insert(index,m);
    //         }),
    //         itemBuilder:(context,index){
    //           final meas = Parent[index];
    //           return listItems(index,meas);
    //         },
    //       ),
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: (){},
    //     child: Icon(Icons.add),
    //   ),
    // );
  }

  void getData() async {
    final uri = Uri.parse("https://apex.oracle.com/pls/apex/orants/acc/vtypes");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['items'][1]['vr_id']);
      print(data);
    }
  }

  Future<int> customerCount() async{
    //final count = FirebaseFirestore.instance.collection("Customers").snapshots().map((event) => event);
    // final count = FirebaseFirestore.instance.collection("Customers").doc();
    // List<DocumentSnapshot> documents = count
    // print(count);
    final query = FirebaseFirestore.instance.collection("Customers");
    final snapshot = await query.get();
    final count = snapshot.size;
    return count;
  }
}

Widget listItems(int index, measurments m) => ListTile(
      key: ValueKey(m),
      title: Text(m.name),
    );
