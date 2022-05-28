import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Functions/PageRoutes.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:tailor_application/Pages/introduction.dart';
import 'package:tailor_application/Pages/profile.dart';
import 'package:tailor_application/Pages/selectCustomerTailor.dart';
import 'package:tailor_application/widgets/characterEidget.dart';
import '../sharedPreferences/userPreferences.dart';

bool? checkForIntroScreen, isLoading = true;
String CustomerOrTailor = "";
FirebaseAuth? _auth;
User? _user;

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  final String title = "Tailor";

  @override
  void initState() {
    print("checkForIntroScreen");
    // TODO: implement initState
    applicationSharedPreferences.init();
    applicationSharedPreferences.setIntroVisibility(true);
    //applicationSharedPreferences.setCustomerOrTailor("");
    _auth = FirebaseAuth.instance;
    _user = _auth?.currentUser;
    print("Current User = $_user");
    isLoading = false;
    CustomerOrTailor = applicationSharedPreferences.getCustomerOrTailor() ?? "";
    print("CustomerOrTailor = $CustomerOrTailor");
    checkForIntroScreen = applicationSharedPreferences.getIntroVisibility();
    print("Intro Screen = ");
    print(applicationSharedPreferences.getIntroVisibility());

    gotoIntroductionScreen();
    super.initState();
  }

  gotoIntroductionScreen() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (checkForIntroScreen != false)
      NavigateToOtherScreenByReplace(context, introduction());
    else if (CustomerOrTailor == "" && checkForIntroScreen == false)
      NavigateToOtherScreenByReplace(context, selectCustomerTailor());
    else if (CustomerOrTailor == "tailor" &&
        checkForIntroScreen == false &&
        _user != null)
      NavigateToOtherScreenByReplace(context, myProfile());
    // else if (CustomerOrTailor == "tailor" &&
    //     checkForIntroScreen == false &&
    //     _user == null) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => myProfile()));
    // } else {
    //   print("Else part");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      OurWidget: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cut,
                size: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: title
                    .split("")
                    .map((char) => characterWrapWidget(
                          char: char,
                        ))
                    .toList(),
              ),
              //Text("Tailor Application",style: TextStyle(fontSize: 30),),
            ],
          ),
        ),
      ),
      appBarTitle: null,
      ScaffoldTemplateBottomSheet: null,
      //floatingActionButton: null,
    );
  }
}
