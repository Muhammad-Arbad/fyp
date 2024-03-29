import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:tailor_application/Pages/Login.dart';
// import 'package:tailor_application/Pages/templateModels.dart';
// import 'package:tailor_application/Pages/test.dart';
// import 'package:tailor_application/Chart/chart.dart';
// import 'package:tailor_application/Pages/customerRegister.dart';
// import 'package:tailor_application/Pages/introduction.dart';
import 'package:tailor_application/Pages/profile.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';
import 'package:tailor_application/Preferences/userPreferences.dart';
// import 'package:tailor_application/Pages/selectCustomerTailor.dart';
import '../Pages/splashScreen.dart';
// import 'package:tailor_application/Pages/splashScreen.dart';
// import 'package:tailor_application/Pages/tailorRegister.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await ApplicationSharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home:Splash(),
      //home: introduction(),
      //home: selectCustomerTailor(),
      //home: customerRegister()
      //home: tailorRegister()
      //home: LoginCustomer()
      home: MyProfile(),
      //home: PieChartPage(),
      //home: test(),
      //home: listofmodels(),
      //home: RegisterCustomer(),
      //theme: ThemeData(
      //brightness: Brightness.dark// ),
        themeMode: ThemeMode.dark,
    );
  }
}
