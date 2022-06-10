import 'package:flutter/material.dart';
import 'package:tailor_application/Classes/introClass.dart';
import 'package:tailor_application/Functions/functions.dart';
import 'package:tailor_application/Pages/Template.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';
import 'allCustomers.dart';



class modelDetail extends StatefulWidget {
  final imgpath,name,price;
  modelDetail({this.imgpath,this.name,this.price});

  @override
  State<modelDetail> createState() => _modelDetailState();
}

class _modelDetailState extends State<modelDetail> {
  List<measurments> Measurments = [];
  final newMeasurmentControllar = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Measurments = getMeasurments();
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      appBarTitle: Text("Model Details"),
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
                    //Center(child:
                    Text(widget.name,style: const TextStyle(fontSize: 20,color: Colors.black87),),
                    //),
                    //Center(child:
                    Text(widget.price,style: TextStyle(fontSize: 15,color: Colors.orangeAccent),)
        //),
                  ],
              )
            ],
          ),),
        SizedBox(height: 10,),
        Expanded(
            flex: 3,
            // child: ReorderableListView.builder(
            //   itemCount: Measurments.length,
            //   onReorder: (oldIndex,newIndex)=>setState(() {
            //     final index = newIndex >oldIndex ? newIndex-1:newIndex;
            //     final m = Measurments.removeAt(oldIndex);
            //     Measurments.insert(index,m);
            //   }),
            //   itemBuilder:(context,index){
            //     final meas = Measurments[index];
            //     return listItems(index,meas);
            //   },
            // ),
          child: FutureBuilder<modelDetailFromFirebase?>(
            future: GetModalDetailList(widget.name),
            //stream: FirebaseFirestore.instance.collection("collectionPath").doc("").snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                final data = snapshot.data!;
                //return modalDetailContainer(data);
                // return ListView(
                //   children: data.map(modalDetailContainer).toList(),
                // );
                return modalDetailContainer(data);
              }
              else{
                //print("snapshot.data");
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