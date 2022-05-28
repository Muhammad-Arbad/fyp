import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';

class AllCustomers extends StatefulWidget {
  const AllCustomers({Key? key}) : super(key: key);

  @override
  _AllCustomersState createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      appBarTitle: Text("All Customers"),
      OurWidget: StreamBuilder<List<customerRegisterClass>>(
          stream: GetCustomerList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              //print(GetCustomerList().isEmpty);
              return Text("Error ${snapshot.error}");
            } else if (snapshot.hasData) {
              final customers = snapshot.data!;
              return ListView(
                children: customers.map(CustomerContainer).toList(),
              );
            } else
              return Center(
                child: CircularProgressIndicator()
              );
          }),
      ScaffoldTemplateBottomSheet: null,
      floatingActionButton: null,
    );
  }
}

Widget CustomerContainer(customerRegisterClass customer) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(30),
        color: Colors.black12,
        child: Row(
          children: [
            Text(customer.c_name),
          ],
        ),
      ),
    ),
  );
}

Widget modalDetailContainer(modelDetailFromFirebase customer) {
  return ListView(
    children: [
      for(int i=0; i<customer.detail.length;i++)
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(30),
            color: Colors.black12,
            child: Row(
              children: [
                Expanded(child: Text(customer.detail[i])),
                Expanded(child: TextFormField(
                  //controller: _controller,
                    keyboardType: TextInputType.number,
                )
                )
                //listItem(customer),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

// String listItem(modelDetailFromFirebase customer) {
//   customer.detail.forEach((element) {
//     return element;});
// }
// Widget CustomerContainer(customerRegisterClass customer)=>ListTile(
//   leading: Text(customer.c_name),
// );

