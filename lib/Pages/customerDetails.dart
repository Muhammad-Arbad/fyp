import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';
import 'Template.dart';

class CustomerDetails extends StatefulWidget {
  customerRegisterClass customer;
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
                        text==null?name=widget.customer.c_name:name=text;
                      },
                      //controller: nameControllar,
                      initialValue: widget.customer.c_name,
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
                        text==null?phone=widget.customer.c_phone:name=text;
                      },
                      initialValue: widget.customer.c_phone,
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
                        text==null?address=widget.customer.c_address:name=text;
                      },
                      initialValue: widget.customer.c_address,
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
                          print(widget.customer.c_name+widget.customer.c_phone+widget.customer.c_address);
                          name = widget.customer.c_name;
                          phone = widget.customer.c_phone;
                          address = widget.customer.c_address;
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
                            print(name+phone+address);
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
    print(widget.customer.c_phone);
    final customerDoc;
    customerDoc = FirebaseFirestore.instance.collection("Customers").doc(widget.customer.c_phone);
    customerDoc.update({
      'name':name,
      'address':address,
      'phone':phone,
    });
  }
}