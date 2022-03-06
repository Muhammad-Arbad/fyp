import 'package:flutter/material.dart';
import 'package:tailor_application/Login.dart';
import 'package:tailor_application/customerRegister.dart';
import 'package:tailor_application/sharedPreferences/userPreferences.dart';
import 'package:tailor_application/tailorRegister.dart';

enum enumSelect { tailor, customer, notselect }

class selectCustomerTailor extends StatefulWidget {
  @override
  State<selectCustomerTailor> createState() => _selectCustomerTailorState();
}

class _selectCustomerTailorState extends State<selectCustomerTailor> {
  enumSelect EnumSelect = enumSelect.notselect;

  List<Color> colr = [Colors.green, Colors.blueGrey];



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Select"+"$width"),
            InkWell(child: Icon(Icons.reset_tv),onTap: (){applicationSharedPreferences.setIntroVisibility(true);},)

          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          EnumSelect = enumSelect.tailor;
                        });
                      },
                      child: selection(
                        Icon(
                          Icons.cut,
                          size: 50,
                        ),
                        Text(
                          "Tailor",
                          style: TextStyle(fontSize: 30),
                        ),
                        EnumSelect == enumSelect.tailor ? colr[0] : colr[1],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          EnumSelect = enumSelect.customer;
                        });
                      },
                      child: selection(
                        Icon(Icons.person, size: 50),
                        Text(
                          "Customer",
                          style: TextStyle(fontSize: 30),
                        ),
                        EnumSelect == enumSelect.customer ? colr[0] : colr[1],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  changeScreen(EnumSelect);
                },
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  NavigateToLogin(EnumSelect);
                },
                child: const Text(
                 "Login",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeScreen(enumSelect enu) {
    if (enu == enumSelect.tailor) {
      //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
      Navigator.push(context, MaterialPageRoute(builder: (context) => tailorRegister()));
    } else if (enu == enumSelect.customer) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => customerRegister()));
    } else if (enu == enumSelect.notselect) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Please Select any option"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
      print(enu);
    }
  }

  void NavigateToLogin(enumSelect enu) {
    if (enu == enumSelect.tailor) {
      //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login("Tailor")));
    } else if (enu == enumSelect.customer) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login("Customer")));
    } else if (enu == enumSelect.notselect) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Please Select any option"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
      print(enu);
    }
  }
}

class selection extends StatelessWidget {
  Widget text, icon;
  Color colr;

  selection(this.icon, this.text, this.colr);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration:
      BoxDecoration(color: colr, borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          text,
        ],
      ),
    );
  }
}
