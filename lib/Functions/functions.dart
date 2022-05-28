
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Classes/introClass.dart';
import 'package:tailor_application/Functions/PageRoutes.dart';
import 'package:tailor_application/Pages/API%20Data.dart';
import 'package:tailor_application/classes/pieChartData.dart';
import 'package:tailor_application/Pages/templateModels.dart';

listofItems(context) {
  return Column(
    children: [
      ListTile(
        leading: Icon(Icons.person),
        title: Text("My Profile"),
        onTap: () {
          Navigator.pop(context);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>GeneratePaper()));
        },
      ),
      const Divider(
        color: Colors.black,
      ),
      ListTile(
        leading: Icon(Icons.photo),
        title: Text("Select Template"),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>listofmodels()))  ;
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>GeneratePaper()));
        },
      ),
      const Divider(
        color: Colors.black,
      ),
      ListTile(
        leading: Icon(Icons.login),
        title: Text("Logout"),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      const Divider(
        color: Colors.black,
      ),
      ListTile(
        leading: Icon(Icons.remove_red_eye),
        title: Text("Api DATA"),
        onTap: () {
          Navigator.pop(context);
          NavigateToOtherScreen(context, ApiData());
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPapers()));
        },
      ),
    ],
  );
}


introScreenItems(int n,ScrollController scrollController){

  List<introductionClass> ScreensLsit = [
    introductionClass(introIcon: "assets/book.jpg",heading: "Heading1",paragraph: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    introductionClass(introIcon: "assets/book.jpg",heading: "Heading2",paragraph: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    introductionClass(introIcon: "assets/book.jpg",heading: "Heading3",paragraph: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
  ] ;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView(
      controller: scrollController,
      //child: Column(
        children: <Widget>[
          Image.asset(ScreensLsit[n].introIcon,fit: BoxFit.cover,),
          SizedBox(height: 5,),
          Text(ScreensLsit[n].heading,style: TextStyle(fontSize: 40),),
          SizedBox(height: 5,),
          Text(ScreensLsit[n].paragraph),
        ],
      //),
    ),
  );
}

bool isLandscape(context){
  return MediaQuery.of(context).orientation == Orientation.landscape;
}

List<measurments> getMeasurments() {

  final names = [
    'Arbad',
    'Tayyab',
    'Ahmad',
    'Faizan'
  ];

  // Stream<List<customerRegisterClass>> GetCustomerList() =>
  //     FirebaseFirestore.instance.collection("Customers").snapshots().map(
  //             (snapshot) => snapshot.docs
  //             .map((e) => customerRegisterClass.FromJason(e.data()))
  //             .toList());

  return List.generate(
    names.length,
        (index) => measurments(
      name: names[index],
    ),
  );
}