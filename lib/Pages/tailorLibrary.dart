import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/customerAdmeasurment.dart';
import 'package:tailor_application/Pages/registerCustomer.dart';
import 'package:tailor_application/Pages/templateModels.dart';
import '../Functions/PageRoutes.dart';
class libraryListOfModels extends StatefulWidget {
  const libraryListOfModels({Key? key}) : super(key: key);

  @override
  _libraryListOfModelsState createState() => _libraryListOfModelsState();
}

class _libraryListOfModelsState extends State<libraryListOfModels> {

  late AddModalToYourLibrary modalVariable;


  @override
  Widget build(BuildContext context)=>OrientationBuilder(builder: (context,orientation)
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Library"),),
      body:StreamBuilder<List<AddModalToYourLibrary>>(
          stream: getModelList(),
          builder: (context,snapshot){
            if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            } else if (snapshot.hasData) {
              final listModel = snapshot.data!;
              return ListView(
                children: listModel.map(buildModel).toList(),
              );
            } else
              return Center(
                child: Text("No Record Found"),
                //child: CircularProgressIndicator()
              );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
  );
  Widget buildModel(AddModalToYourLibrary model){
    modalVariable = model;
    return Padding(
      padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
      child: InkWell(
        onTap: (){
          ShowDialogBox();
        },
        child: Container(
          height: 380,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              )
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(model.imagePath,fit: BoxFit.fill,height: 100.0, width: 100.0,),
                ),
              ),
              SizedBox(height: 7,),
              Text(model.name,style: TextStyle(fontSize: 15,color: Colors.black87),),
              Text(model.price,style: TextStyle(fontSize: 15,color: Colors.orangeAccent),),
            ],
          ),
        ),

      ),
    );
  }

  Widget CustomerContainer(customerRegisterClass customer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          NavigateToOtherScreen(context, CustomerAdmeasurment(imgpath: modalVariable.imagePath,name: modalVariable.name,price: modalVariable.price,));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(30),
            color: Colors.black12,
            child: Column(
              children: [
                Row(children:[
                    Icon(Icons.person),
                    Text(customer.c_name)]),
                Divider(
                  color: Colors.black,
                ),
                Row(children:[
                    Icon(Icons.phone),
                    Text(customer.c_phone)]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void ShowDialogBox() {
    showDialog(
        context: this.context,
        builder: (context)=> AlertDialog(
          title: Text("Select Customer"),
          content: Container(
            width: 200,
            //height: 300,
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
        )
    );
  }
}
