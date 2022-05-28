import 'package:flutter/material.dart';

import 'modelDetail.dart';

class libraryListOfModels extends StatefulWidget {
  const libraryListOfModels({Key? key}) : super(key: key);

  @override
  _libraryListOfModelsState createState() => _libraryListOfModelsState();
}

class _libraryListOfModelsState extends State<libraryListOfModels> {


  @override
  Widget build(BuildContext context)=>OrientationBuilder(builder: (context,orientation)
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Library"),),
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
                buildModel("Pant Coat","Stitching Price: 1200","assets/shalwarKamees.jpeg",2),
                buildModel("Pant Coat","Stitching Price: 1200","assets/pentCoat.jpeg",3),
                buildModel("Pant Coat","Stitching Price: 1200","assets/pentCoat.jpeg",4),
                buildModel("Pant Coat","Stitching Price: 1200","assets/shalwarKamees.jpeg",5),
                buildModel("Pant Coat","Stitching Price: 1200","assets/pentCoat.jpeg",6),
                buildModel("Pant Coat","Stitching Price: 1200","assets/pentCoat.jpeg",7),
                buildModel("Pant Coat","Stitching Price: 1200","assets/shalwarKamees.jpeg",8),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
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
            ],
          ),
        ),

      ),
    );
  }
}
