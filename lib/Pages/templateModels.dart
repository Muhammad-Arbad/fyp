import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/SharedPreferences/userPreferences.dart';
import'modelDetail.dart';


class listofmodels extends StatefulWidget {
  const listofmodels({Key? key}) : super(key: key);

  @override
  _listofmodelsState createState() => _listofmodelsState();
}

class _listofmodelsState extends State<listofmodels> {

  List<String> s = [];//applicationSharedPreferences.getTemplateAddOrRemove()??["false","false","false","false","false","false","false","false","false"];
  String testing = "";
  //List<String>? isSwitch = applicationSharedPreferences.getTemplateAddOrRemove();


  @override
  void initState(){
    // TODO: implement initState
    applicationSharedPreferences.init();
    setState(() {
      this.s = applicationSharedPreferences.getTemplateAddOrRemove()??["false","false","false","false","false","false","false","false","false"];
      //print("InitState function = $s");
      print("set State initSteate is called");
    });
    print("before Super initSteate is called");
    super.initState();
    print("After Super initSteate is called");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("This is deactivate function");
  }

  @override
  Widget build(BuildContext context)=>OrientationBuilder(builder: (context,orientation)
  {
    return Scaffold(
      appBar: AppBar(title: Text("Select to your Library"),),
      body: ListView(
        children:<Widget> [
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.height - 50.0,
            child: GridView.count(
              crossAxisCount: orientation == Orientation.portrait?2:4,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              childAspectRatio: 0.7,
              children:<Widget> [
                buildModel("pentCoat","Stitching Price: 15000","assets/pentCoat.jpeg",0),
                buildModel("Coat","Stitching Price: 1200","assets/shalwarKamees.jpeg",1),
                buildModel("Shalwar Kameez","Stitching Price: 1200","assets/shalwarKamees.jpeg",2),
                buildModel("Shirt","Stitching Price: 1200","assets/pentCoat.jpeg",3),
                buildModel("Pant","Stitching Price: 1200","assets/pentCoat.jpeg",4),
                buildModel("Tie","Stitching Price: 1200","assets/shalwarKamees.jpeg",5),
                buildModel("Trouser","Stitching Price: 1200","assets/pentCoat.jpeg",6),
                buildModel("Taxido","Stitching Price: 1200","assets/pentCoat.jpeg",7),
                buildModel("Pajama","Stitching Price: 1200","assets/shalwarKamees.jpeg",8),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //CreateCustomer(name: "fsd", address: "fsd", phone: "03356727047", context: context);
          //createModal(name: "Coat", price: "7000", imgPath: "123");
        },
        child: Icon(Icons.add),
      ),
    );
  }
  );
  Widget buildModel(String name,String price, String imgPath,int index){
    return Padding(
      padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> modelDetail(
            imgpath: imgPath,
            name: name,
            price: price,
          )));
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
              //Hero(
                //tag: imgPath,
                //child:
                Container(
                  // height: 180,
                  // width: 150,
                  // decoration: BoxDecoration(
                  //
                  //   image: DecorationImage(
                  //     image: AssetImage(imgPath),
                  //       fit: BoxFit.contain
                  //   )
                  // ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(imgPath,fit: BoxFit.fill,height: 100.0, width: 100.0,),
                  ),
                ),
              //),
              SizedBox(height: 7,),
              Text(name,style: TextStyle(fontSize: 15,color: Colors.black87),),
              Text(price,style: TextStyle(fontSize: 15,color: Colors.orangeAccent),),
              Switch(value: s[index]=="true"?true:false, onChanged: (value){
                setState(() {
                  if(value==true){
                    s[index] = "true";
                    applicationSharedPreferences.setTemplateAddOrRemove(s);
                    createModal(name: name, price: price, imgPath: imgPath);
                  }
                  else{
                    s[index] = "false";
                    applicationSharedPreferences.setTemplateAddOrRemove(s);
                  }
                });
              }),
            ],
          ),
        ),

      ),
    );
  }

  Future createModal({required String name,required String price, required String imgPath}) async{
    final modelDoc = FirebaseFirestore.instance.collection("tailors").doc("1").collection("ModelDetails").doc(name);
    final newModel = AddModalToYourLibrary(name: name, price: price, imagePath: imgPath);
    final json = newModel.toJson();
    modelDoc.set(json);

  }
}


class AddModalToYourLibrary{

  final String name,price,imagePath;
  AddModalToYourLibrary({required this.name,required this.price,required this.imagePath});

  Map<String,dynamic> toJson()=>
      {'name':name,'price':price,'imagePath':imagePath};
}
