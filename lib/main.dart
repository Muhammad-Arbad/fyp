import 'package:flutter/material.dart';
import 'package:tailor_application/Login.dart';
import 'package:tailor_application/customerRegister.dart';
import 'package:tailor_application/introduction.dart';
import 'package:tailor_application/profile.dart';
import 'package:tailor_application/selectCustomerTailor.dart';
import 'package:tailor_application/sharedPreferences/userPreferences.dart';
import 'package:tailor_application/splashScreen.dart';
import 'package:tailor_application/tailorRegister.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await applicationSharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:splash(),
      //home: introduction(),
        //home: selectCustomerTailor(),
        //home: customerRegister()
        //home: tailorRegister()
        //home: LoginCustomer()
        //home: myProfile()
    );
  }
}
