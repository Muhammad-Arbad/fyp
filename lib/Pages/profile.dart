import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor_application/Pages/tailorRegister.dart';
import 'package:tailor_application/Pages/templateModels.dart';
import 'package:tailor_application/SharedPreferences/userPreferences.dart';
import '../classes/profileBody.dart';
import '../functions/functions.dart';

class myProfile extends StatefulWidget {
  const myProfile({Key? key}) : super(key: key);

  @override
  _myProfileState createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //applicationSharedPreferences.init();
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        final isPotrate = orientation == Orientation.portrait;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
            ),
            body: ProfileBody(),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: ()async{
            //     await _auth.signOut();
            //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>tailorRegister()));
            //   },
            //   child: Icon(Icons.logout)
            // ),
            //body: listofmodels(),//Container(child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>listofmodels()));},child: Text("Template"),),),
            drawer: Drawer(
              child: Column(
                children: [
                  Expanded(flex: 1, child: profileImage()),
                  Expanded(flex: 2, child: profileSettings()),
                ],
              ),
            ),
          ),
        );
      });

  profileImage() {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(20),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              img != null
                  ? ClipOval(
                      child: Image.file(
                      img!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ))
                  : const CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.redAccent,
                    ),
              Positioned(
                  bottom: 0,
                  right: 4,
                  child: InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 150,
                              color: Colors.white,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ElevatedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.photo),
                                              SizedBox(width: 10,),
                                              Text("Select from Gallery")
                                            ],
                                          ),
                                        ),
                                        onPressed: (){
                                          Navigator.pop(context);
                                          takingOrSelectingImage(ImageSource.gallery);
                                        },
                                      ),
                                      ElevatedButton(
                                        child:  Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: const[
                                              Icon(Icons.camera_alt),
                                              SizedBox(width: 10,),
                                              Text("Take a Photo")
                                            ],
                                          ),
                                        ),
                                        onPressed: (){
                                          Navigator.pop(context);
                                          takingOrSelectingImage(ImageSource.camera);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: ClipOval(
                          child: Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                        ),
                      )))),
            ],
          ),
          Center(
              child: Text(
            "Name",
            style: TextStyle(fontSize: 20),
          )),
          Center(
              child: Text(
            "example@gmail.com",
            style: TextStyle(fontSize: 10),
          )),
        ],
      ),
    );
  }

  profileSettings() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          listofItems(this.context),
        ],
      ),
    );
  }

  File? img;
  Future takingOrSelectingImage(ImageSource imgSource) async {
    ImageSource imageSource = imgSource;
    try {
      final imagePath = await ImagePicker().pickImage(source: imageSource);
      if (imagePath == null) return;
      final tempImage = File(imagePath.path);
      // setState(() {
      //   this.img = tempImage;
      // });
      setState(() => this.img = tempImage);
    } on PlatformException catch (e) {
      print("Failed to get Image");
    }
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Analytics();
  }
}