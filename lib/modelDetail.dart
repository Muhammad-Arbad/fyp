import 'package:flutter/material.dart';


class modelDetail extends StatelessWidget {
  final imgpath,name,price;
  modelDetail({this.imgpath,this.name,this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Model Detail"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 15,),
          Hero(
            tag: imgpath,
            child: Container(
              padding: EdgeInsets.all(20),
              height:200,
              width: 150,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(imgpath,fit: BoxFit.fill,height: 140.0,
                  width: 140.0,),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(child: Text(name,style: const TextStyle(fontSize: 23,color: Colors.black87),)),
          Center(child: Text(price,style: TextStyle(fontSize: 15,color: Colors.orangeAccent),))
        ],
      ),
    );
  }
}