import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';
import '../Classes/introClass.dart';
import 'Template.dart';
import 'allCustomers.dart';

class CustomerAdmeasurment extends StatefulWidget {
  final imgpath,name,price;
  CustomerAdmeasurment({this.imgpath,this.name,this.price});

  @override
  State<CustomerAdmeasurment> createState() => _CustomerAdmeasurmentState();
}

class _CustomerAdmeasurmentState extends State<CustomerAdmeasurment> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      appBarTitle: Text("Admeasurment"),
      OurWidget: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Hero(
                  tag: widget.imgpath,
                  child: Container(
                    padding: EdgeInsets.all(20),
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
                  children: [
                    Text(widget.name,style: const TextStyle(fontSize: 20,color: Colors.black87),),
                    Text(widget.price,style: TextStyle(fontSize: 15,color: Colors.orangeAccent),)
                  ],
                )
              ],
            ),),
          SizedBox(height: 10,),
          Expanded(
            flex: 3,
            child: FutureBuilder<modelDetailFromFirebase?>(
              future: GetModalDetailList(widget.name),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  final data = snapshot.data!;
                  return modalDetailContainer(data);
                }
                else{
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

    );
  }
}

Widget listItems(int index, measurments m) =>ListTile(
  key: ValueKey(m),
  title: Text(m.name),
);