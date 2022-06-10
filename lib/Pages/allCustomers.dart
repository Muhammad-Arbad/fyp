import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Functions/PageRoutes.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:tailor_application/Pages/customerDetails.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';

class AllCustomers extends StatefulWidget {
  const AllCustomers({Key? key}) : super(key: key);

  @override
  _AllCustomersState createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  bool itemSelected = false;
  
  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      appBarTitle: Text("All Customers"),
      OurWidget: Container(
        color: Colors.black,
        child: StreamBuilder<List<customerRegisterClass>>(
            stream: GetCustomerList(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
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
      ),
      ScaffoldTemplateBottomSheet: null,
      floatingActionButton: null,
    );
  }

  Widget CustomerContainer(customerRegisterClass customer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          NavigateToOtherScreen(context, CustomerDetails(customer));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.all(30),
              color: Colors.white,
              child: Column(
                children: [
                  Row(children:[
                    Expanded(child:Row(children:[
                      Icon(Icons.person),
                      Text(customer.c_name)])),
                    Expanded(child: Row(children:[
                      Icon(Icons.phone),
                      Text(customer.c_phone)]),)

                  ]),

                ],
              ),
            ),
          ),
        ),
    );
  }
}



Widget modalDetailContainer(modelDetailFromFirebase naap) {
  return ListView(
      children: [
        for(int i=0; i<naap.detail.length;i++)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.all(30),
              color: Colors.black12,
              child: Row(
                children: [
                  Expanded(child: Text(naap.detail[i])),
                  Expanded(child: TextFormField(
                      keyboardType: TextInputType.number,
                  ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
  );
}
