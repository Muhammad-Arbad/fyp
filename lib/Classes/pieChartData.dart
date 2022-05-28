import 'package:flutter/material.dart';


class PieData{

  static List<Data> data =[
    Data(name: "Red", percent: 50, color: Colors.red),
    Data(name: "Green", percent: 20, color: Colors.green),
    Data(name: "Blue", percent: 15, color: Colors.blue),
    Data(name: "Orange", percent: 15, color: Colors.amber),
  ];
}

class Data{

  final String name;
  final double percent;
  final Color color;

  Data({required this.name,required this.percent,required this.color});
}