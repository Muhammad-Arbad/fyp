import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tailor_application/Functions/PageRoutes.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:tailor_application/Pages/profile.dart';
import 'package:tailor_application/Preferences/userPreferences.dart';


enum selectPage { phoneNumber, OTPPage }

class tailorRegister extends StatefulWidget {
  const tailorRegister({Key? key}) : super(key: key);

  @override
  _tailorRegisterState createState() => _tailorRegisterState();
}

class _tailorRegisterState extends State<tailorRegister> {
  bool showLoading = false;
  String tailor_id = "";
  String verificationId = "";
  selectPage SelectPage = selectPage.phoneNumber;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final phoneNumberController = TextEditingController();
  final otpNumberController = TextEditingController();
  final usernameControllar = TextEditingController();
  final passswordControllar = TextEditingController();
  final addressControllar = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        ApplicationSharedPreferences.setCustomerOrTailor("tailor");
        tailor_id = _auth.currentUser!.uid;
        setTailorInformation(
            username: usernameControllar.text,
            password: passswordControllar.text,
            address: addressControllar.text,
            phone: phoneNumberController.text);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>myProfile()));
      }
    } on FirebaseAuthException catch (e) {
      // TODO
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  FocusNode myFocusNode = new FocusNode();

  MobileVerificationNumber(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.person,
            size: 200,
          ),
          TextFormField(
              controller: usernameControllar,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
                prefixIcon: Icon(Icons.person),
              )),
          SizedBox(
            height: 5,
          ),
          TextFormField(
              controller: passswordControllar,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
                prefixIcon: Icon(Icons.remove_red_eye),
              )),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: addressControllar,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Address',
              prefixIcon: Icon(Icons.location_on),
            ),
            onTap: () {
              getCurrentLocation();
            },
            //focusNode:
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: phoneNumberController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Phone Number',
              prefixIcon: Icon(Icons.call),
            ),
            //keyboardType: TextInputType.number,
            // inputFormatters: <TextInputFormatter>[
            //   FilteringTextInputFormatter.digitsOnly
            // ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      showLoading = true;
                    });
                    await _auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });
                        //signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      verificationFailed: (varificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        _scaffoldKey.currentState?.showSnackBar(SnackBar(
                            content:
                                Text(varificationFailed.message.toString())));
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showLoading = false;
                          SelectPage = selectPage.OTPPage;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                    );
                  },
                  child: Text(
                    "Register",
                  ))),
        ],
      ),
    );
  }

  OtpVerificationPage(context) {
    return Container(
      child: Column(
        children: [
          Spacer(),
          TextFormField(
            controller: otpNumberController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'OTP',
              prefixIcon: Icon(Icons.numbers),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          TextButton(onPressed: () {}, child: Text("Resend Code")),
          ElevatedButton(
              onPressed: () {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: otpNumberController.text);
                signInWithPhoneAuthCredential(phoneAuthCredential);
                if(_auth.currentUser != null){
                  NavigateToOtherScreen(context, MyProfile());
                }
              },
              child: Text("Varify"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
        appBarTitle: Text("Tailor Registration"),
        OurWidget:
            //resizeToAvoidBottomInset: false,
            Container(
          padding: EdgeInsets.all(30),
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SelectPage == selectPage.phoneNumber
                  ? MobileVerificationNumber(context)
                  : OtpVerificationPage(context),
        ),
        ScaffoldTemplateBottomSheet: null,
      floatingActionButton: null,
    );
  }

  void setTailorInformation({
    required String username,
    required String password,
    required String address,
    required String phone,
  }) async {
    final tailorInformation =
        FirebaseFirestore.instance.collection("tailors").doc(phone);
    final json = {
      'username': username,
      'password': password,
      'address': address,
      'phone_number': phone
    };
    await tailorInformation.set(json);

    NavigateToOtherScreenByReplace(context,
        MyProfile());
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(applicationSharedPreferences.getCustomerOrTailor().toString())));
  }



  getCurrentLocation() async {
    //LocationPermission permission = await Geolocator.requestPermission();
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      //throw Exception('Error');
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,timeLimit: Duration(seconds: 5));
      addressControllar.text = position.latitude.toString();
      //print(position.latitude);
    }
    //return await Geolocator.getCurrentPosition();
  }
}
