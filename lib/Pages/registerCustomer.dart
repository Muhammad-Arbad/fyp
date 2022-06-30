import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Decoration/textFormField.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:tailor_application/Pages/profile.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      appBarTitle: const Text("Register Customer"),
      OurWidget: Container(
        decoration: BoxDecoration(
            color: Color(0xff99b9ff),
            borderRadius: BorderRadius.all(Radius.circular(40))),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person,
                  size: 200,
                ),
                TextFormFieldCustomerBuilt(
                  controller: nameControllar,
                  icoon: Icons.person,
                  hintTxt: 'Name',
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormFieldCustomerBuilt(
                  controller: addressControllar,
                  icoon: Icons.location_on,
                  hintTxt: 'Address',
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormFieldCustomerBuilt(
                  controller: phoneNumberControllar,
                  icoon: Icons.call,
                  hintTxt: 'Phone Numher',
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.black, width: 2)),
                          //minimumSize: Size(150, 50), //////// HERE
                        ),
                        onPressed: () {
                          createCustomer(
                              name: nameControllar.text,
                              address: addressControllar.text,
                              phone: phoneNumberControllar.text,
                              context: context);
                        },
                        child: const Text(
                          "Register",
                        ))),
              ],
            ),
          ),
        ),
      ),
      ScaffoldTemplateBottomSheet: null,
      floatingActionButton: null,
    );
  }
}

Stream<List<CustomerRegisterClass>> GetCustomerList() {
  //customersPhone=[];
  // var chunks = [];
  // FirebaseFirestore.instance
  //     .collection('tailors').doc("+923356727047").collection("OwnCustomers")
  //     .get()
  //     .then((QuerySnapshot querySnapshot) {
  //   querySnapshot.docs.forEach((doc) {
  //     customersPhone.add(doc["phone"]);
  //     print(doc["phone"]);
  //   });
  // });
  // for (var i = 0; i < customersPhone.length; i += 10) {
  //   chunks.add(customersPhone.sublist(
  //       i, i + 10 > customersPhone.length ? customersPhone.length : i + 10));
  //   print(chunks);
  // }
  //
  //   return FirebaseFirestore.instance.collection("Customers").where("phone",whereIn: [chunks]).snapshots().map(
  //           (snapshot) => snapshot.docs
  //           .map((e) => CustomerRegisterClass.fromJason(e.data()))
  //           .toList());
  //return FirebaseFirestore.instance.collection("Customers").snapshots().map(
  return FirebaseFirestore.instance
      .collection("tailors")
      .doc(user?.phoneNumber)
      .collection("OwnCustomers")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((e) => CustomerRegisterClass.fromJason(e.data()))
          .toList());
}

// Stream<List> GetOwnCustomers(){
//   return FirebaseFirestore.instance.collection("tailors").doc("+923356727047").collection("OwnCustomers")
//       .snapshots()
//       .map((event) => event.docs
//       .map((e) =>CustomerRegisterClass.listOfPhoneNumbers(e.data()))
//       .toList());
// }

// Stream<List<CustomerRegisterClass>> GetCustomerList() =>
//     FirebaseFirestore.instance.collection("Customers").snapshots().map(
//             (snapshot) => snapshot.docs
//             .map((e) => CustomerRegisterClass.fromJason(e.data()))
//             .toList());

Future<ModelDetailFromFirebase?> GetModalDetailList(String name) async {
  final modelDocument =
      FirebaseFirestore.instance.collection("ModelDetails").doc(name);
  final snapshot = await modelDocument.get();
  if (snapshot.exists) {
    return ModelDetailFromFirebase.fromJason(snapshot.data()!);
  }
}

Future createCustomer(
    {required String name,
    required String address,
    required String phone,
    required BuildContext context}) async {
  final customerDoc =
      FirebaseFirestore.instance.collection("Customers").doc(phone);
  final ownCustomer = FirebaseFirestore.instance
      .collection("tailors")
      .doc(user?.phoneNumber)
      .collection("OwnCustomers")
      .doc(phone)
      .set({"phone": phone, "name": name, "address": address});
  final newCustomer =
      CustomerRegisterClass(cName: name, cAddress: address, cPhone: phone);
  final json = newCustomer.toJson();
  const textSuccess = "Customer Registered Successfully";
  const textError = "Customer Registered Error";
  const snackBarSuccess = SnackBar(content: Text(textSuccess));
  const snackBarError = SnackBar(content: Text(textError));

  await customerDoc.set(json).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
    final SmsSendStatusListener listener = (SendStatus status) {
      print(status);
    };
    telephony.sendSms(
        to: phone,
        message:
            "You are registered as customer and you will receive order sms soon. Download this app from google play store",
        statusListener: listener);
    NavigateToOtherScreenByReplace(context, listofmodels());
  }).catchError(() {
    ScaffoldMessenger.of(context).showSnackBar(snackBarError);
  });
}

class CustomerRegisterClass {
  final String cName, cAddress, cPhone;

  CustomerRegisterClass(
      {required this.cName, required this.cAddress, required this.cPhone});

  Map<String, dynamic> toJson() =>
      {'name': cName, 'address': cAddress, 'phone': cPhone};

  static CustomerRegisterClass fromJason(Map<String, dynamic> json) {
    print("Functions");
    return CustomerRegisterClass(
        cName: json['name'], cAddress: json['address'], cPhone: json['phone']);
  }

  static List listOfPhoneNumbers(Map<String, dynamic> json) {
    return json['phone'];
    // print("listOfPhoneNumbers");
    // final phones = [];
    // json.forEach((key, value) {
    //   phones.add(value);
    // });
    // print("Arbad");
    // return phones;
  }
}

class ModelDetailFromFirebase {
  List detail = [];

  ModelDetailFromFirebase({required this.detail});

  static ModelDetailFromFirebase fromJason(Map<String, dynamic> json) {
    List details = [];
    json.forEach((key, value) {
      details.add(key);
    });
    return ModelDetailFromFirebase(detail: details);
  }

  Map<String, dynamic> toJson(ModelDetailFromFirebase m, List naapDetails) => {
        for (int i = 0; i < m.detail.length; i++)
          m.detail[i].toString(): naapDetails[i]
      };
}
