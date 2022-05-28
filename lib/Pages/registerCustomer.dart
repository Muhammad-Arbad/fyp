import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:tailor_application/functions/PageRoutes.dart';
import 'package:tailor_application/Pages/templateModels.dart';
import 'package:telephony/telephony.dart';

final Telephony telephony = Telephony.instance;

class RegisterCustomer extends StatefulWidget {
  const RegisterCustomer({Key? key}) : super(key: key);

  @override
  _RegisterCustomerState createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  final nameControllar = TextEditingController();
  final addressControllar = TextEditingController();
  final phoneNumberControllar = TextEditingController();
  final idControllar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      appBarTitle: Text("Register Customer"),
      OurWidget: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person,
                size: 200,
              ),
              TextFormField(
                  controller: nameControllar,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  )),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: addressControllar,
                  //obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address',
                    prefixIcon: Icon(Icons.location_on),
                  )),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: phoneNumberControllar,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone Numher',
                    prefixIcon: Icon(Icons.call),
                  )),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        CreateCustomer(
                            name: nameControllar.text,
                            address: addressControllar.text,
                            phone: phoneNumberControllar.text,
                            context: context);
                      },
                      child: Text(
                        "Register",
                      ))),
            ],
          ),
        ),
      ),
      ScaffoldTemplateBottomSheet: null,
      floatingActionButton: null,
    );
  }
}

Stream<List<customerRegisterClass>> GetCustomerList() =>
    FirebaseFirestore.instance.collection("Customers").snapshots().map(
        (snapshot) => snapshot.docs
            .map((e) => customerRegisterClass.FromJason(e.data()))
            .toList());

Future<modelDetailFromFirebase?> GetModalDetailList(String name) async {
  final modelDocument =
      FirebaseFirestore.instance.collection("ModelDetails").doc(name);
  final snapshot = await modelDocument.get();
  if (snapshot.exists) {
    return modelDetailFromFirebase.FromJason(snapshot.data()!);
  }
}

Future CreateCustomer(
    {required String name,
    required String address,
    required String phone,
    required BuildContext context}) async {
  final customerDoc =
      FirebaseFirestore.instance.collection("Customers").doc(phone);
  final newCustomer = customerRegisterClass(c_name: name, c_address: address, c_phone: phone);
  final json = newCustomer.toJson();
  final textSuccess = "Customer Registered Successfully";
  final textError = "Customer Registered Successfully";
  final snackBarSuccess = SnackBar(content: Text(textSuccess));
  final snackBarError = SnackBar(content: Text(textError));

  await customerDoc.set(json).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
    final SmsSendStatusListener listener = (SendStatus status) {
      print(status);
    };
    telephony.sendSms(
        to: phone,
        message:
            "Now you are registered as customer and you will receive order sms soon. Thanks!",
        statusListener: listener);
    NavigateToOtherScreenByReplace(context, listofmodels());
  }).catchError(() {
    ScaffoldMessenger.of(context).showSnackBar(snackBarError);
  });

  //Future.delayed(Duration(milliseconds: 1000));
}

class customerRegisterClass {
  final String c_name, c_address, c_phone;

  customerRegisterClass(
      {required this.c_name, required this.c_address, required this.c_phone});

  Map<String, dynamic> toJson() =>
      {'name': c_name, 'address': c_address, 'phone': c_phone};

  static customerRegisterClass FromJason(Map<String, dynamic> json) {
    print(json);
    return customerRegisterClass(
        c_name: json['name'],
        c_address: json['address'],
        c_phone: json['phone']);
  }
}

class modelDetailFromFirebase {
  //final String bazu,gala,length;
  List detail = [];

  //modelDetailFromFirebase( {required this.bazu,required this.gala,required this.length});
  modelDetailFromFirebase({required this.detail});

  // Map<String, dynamic> toJson() =>
  //     {'bazu': bazu, 'gala': gala, 'length': length};

  static modelDetailFromFirebase FromJason(Map<String, dynamic> json) {
    int size = json.length;
    print("Size = $size");
    List details = [];
    json.forEach((key, value) {
      print("For key = $key value = $value");
      details.add(key);
    });

    print(details);
    return modelDetailFromFirebase(detail: details);
    // return modelDetailFromFirebase(
    //   bazu:json['bazu'], gala: json['gala'], length:json['length'],
    //   //bazu:json[1], gala: json[2], length:json[3],
    //   // detail.add(json['bazu']),
    //   // detail.add(json['gala']),
    //   // detail.add(json['length']),
    // );
  }
}
