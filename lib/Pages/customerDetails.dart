import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/profile.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';
import 'Template.dart';

class CustomerDetails extends StatefulWidget {
  CustomerRegisterClass customer;
  CustomerDetails(this.customer);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  bool enable = false;

  String name = "";
  String phone = "";
  String address = "";


  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      appBarTitle: const Text("Custromer Detail"),
      OurWidget: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(flex: 1, child: Text("Name")),
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      onChanged: (text){
                        text==null?name=widget.customer.cName:name=text;
                      },
                      //controller: nameControllar,
                      initialValue: widget.customer.cName,
                      enabled: enable,
                    )),
              ],
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Text("Phone")),
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      onChanged: (text){
                        text==null?phone=widget.customer.cPhone:name=text;
                      },
                      initialValue: widget.customer.cPhone,
                      enabled: false,
                    )),
              ],
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Text("Address")),
                Expanded(
                    flex: 2,
                    child: TextFormField(
                      onChanged: (text){
                        text==null?address=widget.customer.cAddress:name=text;
                      },
                      initialValue: widget.customer.cAddress,
                      enabled: enable,
                    )),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          print(widget.customer.cName+widget.customer.cPhone+widget.customer.cAddress);
                          name = widget.customer.cName;
                          phone = widget.customer.cPhone;
                          address = widget.customer.cAddress;
                          enable = true;
                        });
                      },
                      child: Text("Edit")),
                ),
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () {
                          setState(() {
                            //print(name+phone+address);
                            updateFirebaseData(name,phone,address);
                            enable = false;
                          });
                        },
                        child: Text("Save")))
              ],
            )
          ],
        ),
      ),
      ScaffoldTemplateBottomSheet: null,
    );
  }

  void updateFirebaseData(String name,String phone,String address) {
    print(widget.customer.cPhone);
    final customerDoc;
    final ownCustomerDoc;
    ownCustomerDoc = FirebaseFirestore.instance.collection("tailors").doc(user?.phoneNumber).collection("OwnCustomers").doc(widget.customer.cPhone);
    customerDoc = FirebaseFirestore.instance.collection("Customers").doc(widget.customer.cPhone);
    customerDoc.update({
      'name':name,
      'address':address,
      'phone':phone,
    });
    ownCustomerDoc.update({
      'name':name,
      'address':address,
      'phone':phone,
    });
  }
}