import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';
import '../Classes/introClass.dart';
import 'Template.dart';
import 'allCustomers.dart';
import 'package:toast/toast.dart';

class CustomerAdmeasurment extends StatefulWidget {
  final imgpath,name,price;
  CustomerRegisterClass customerDetails;
  CustomerAdmeasurment({Key? key, this.imgpath,this.name,this.price,required this.customerDetails}) : super(key: key);

  @override
  State<CustomerAdmeasurment> createState() => _CustomerAdmeasurmentState();
}
dynamic data = 0;
DateTime dateTimeNow = DateTime.now();


class _CustomerAdmeasurmentState extends State<CustomerAdmeasurment> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return ScaffoldTemplate(
      appBarTitle: const Text("Admeasurment"),
      OurWidget: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Hero(
                  tag: widget.imgpath,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    // height:200,
                    // width: 150,
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(widget.imgpath,fit: BoxFit.fill,height: 140.0,
                        width: 140.0,),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Text(widget.name,style: const TextStyle(fontSize: 20,color: Colors.black87),),
                    Text(widget.price,style: TextStyle(fontSize: 15,color: Colors.orangeAccent),),
                    Text(widget.customerDetails.cName),
                    Text(widget.customerDetails.cPhone)
                  ],
                ),
              ],
            ),

          ),
          SizedBox(height: 10,),
          Expanded(
            flex: 3,
            child: FutureBuilder<ModelDetailFromFirebase?>(
              future: GetModalDetailList(widget.name),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  //final data = snapshot.data!;
                  data = snapshot.data;
                  return modalDetailContainer(data);
                }
                else{
                  data = 0;
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      ScaffoldTemplateBottomSheet: null,
      //floatingActionButton: Center(child: Icon(Icons.add),),
      //FloatingActionButton(
      // onPressed: (){
      //   showDialog(context: context, builder: (context){
      //     //final meas = Measurments[index]
      //     return AlertDialog(
      //       content: TextFormField(
      //         controller: newMeasurmentControllar,
      //           final m = measurments(name: name);
      //           Measurments.add(m);
      //           onFieldSubmitted:(_),
      //       ),
      //     );
      //   },);
      // },
      floatingActionButton: FloatingActionButton(
        child: const Text("Save1"),
        onPressed: ()async{
          //Future<int> nextOrderDetailNumber = countMaxOrderNumber();
          var nextDate = await pikDate();
          while(nextDate!.difference(dateTimeNow).inDays <0 && nextDate!=null && nextDate!=dateTimeNow){
            Toast.show("Previous Date not Allowed",duration: Toast.lengthLong,gravity: Toast.top);
            nextDate = await pikDate();
          }

          final d = nextDate.difference(dateTimeNow).inDays;
          Toast.show("Total days Left = $d",duration: Toast.lengthLong,gravity: Toast.top);
          //print(nextOrderDetailNumber);
          // final jsonCustoemrNaap = customerKaNaapAddKro(data);
          // final custoemrNaap = FirebaseFirestore.instance.collection("Customers").doc(widget.customerDetails.cPhone).collection("naap").doc(widget.name);
          // await custoemrNaap.set(jsonCustoemrNaap);
          //print(customerNaap);

        },
      ),

    );
  }

  Future<DateTime?> pikDate() {
    return showDatePicker(
        context: context,
        initialDate: dateTimeNow,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        fieldLabelText: "Select Delivery Date",
    );
  }

  Future<int> countMaxOrderNumber() async{
    final query =  FirebaseFirestore.instance.collection("Customers").doc(widget.customerDetails.cPhone).collection("naap").doc("Orders").collection("Details");
    final doc = await query.get();
    int count = doc.size;
    return count;
  }
}

Widget listItems(int index, measurments m) =>ListTile(
  key: ValueKey(m),
  title: Text(m.name),
);