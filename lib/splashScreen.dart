import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_application/introduction.dart';
import 'package:tailor_application/selectCustomerTailor.dart';
import 'sharedPreferences/userPreferences.dart';

bool? checkForIntroScreen ;

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {


  @override
  void initState() {
    // TODO: implement initState
    //applicationSharedPreferences.setIntroVisibility(true);
    checkForIntroScreen = applicationSharedPreferences.getIntroVisibility();
    print(checkForIntroScreen);
    gotoIntroductionScreen();
    super.initState();
  }

  gotoIntroductionScreen()async{
    await Future.delayed(Duration(milliseconds: 1000));
    if(checkForIntroScreen != false)
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>introduction()));
    else
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>selectCustomerTailor()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body:Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cut,size: 100,),
            Text("Tailor Application",style: TextStyle(fontSize: 50),)
          ],
        ),
      ),
    ) ,));
  }
}
