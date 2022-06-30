import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Functions/PageRoutes.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:tailor_application/Pages/introduction.dart';
import 'package:tailor_application/Pages/profile.dart';
import 'package:tailor_application/Pages/selectCustomerTailor.dart';
import 'package:tailor_application/Preferences/userPreferences.dart';
import 'package:tailor_application/widgets/characterEidget.dart';

bool? checkForIntroScreen, isLoading = true;
String customerOrTailor = "";
FirebaseAuth? _auth;
User? _user;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final String title = "Tailor";

  @override
  void initState() {
    print("checkForIntroScreen");
    // TODO: implement initState
    //applicationSharedPreferences.init();
    //applicationSharedPreferences.setIntroVisibility(true);
    //applicationSharedPreferences.setCustomerOrTailor("");
    _auth = FirebaseAuth.instance;
    _user = _auth?.currentUser;
    print("Current User = $_user");
    isLoading = false;
    customerOrTailor = ApplicationSharedPreferences.getCustomerOrTailor() ?? "";
    print("CustomerOrTailor = $customerOrTailor");
    checkForIntroScreen = ApplicationSharedPreferences.getIntroVisibility()??true;
    print("Intro Screen = ");
    print(ApplicationSharedPreferences.getIntroVisibility());

    gotoIntroductionScreen();
    super.initState();
  }

  gotoIntroductionScreen() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (checkForIntroScreen != false)
      NavigateToOtherScreenByReplace(context, introduction());
    else if (customerOrTailor == "" && checkForIntroScreen == false)
      NavigateToOtherScreenByReplace(context, selectCustomerTailor());
    else if (_user != null)
      NavigateToOtherScreenByReplace(context, MyProfile());
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
            ],
          ),
        ),
      ),
      appBarTitle: null,
      ScaffoldTemplateBottomSheet: null,
    );
  }
}
