
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/template.dart';

listofItems(context) {
  return Column(
    children: [
      ListTile(
        leading: Icon(Icons.person),
        title: Text("My Profile"),
        onTap: () {
          Navigator.pop(context);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>GeneratePaper()));
        },
      ),
      const Divider(
        color: Colors.black,
      ),
      ListTile(
        leading: Icon(Icons.photo),
        title: Text("Select Template"),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>listofmodels()))  ;
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>GeneratePaper()));
        },
      ),
      const Divider(
        color: Colors.black,
      ),
      ListTile(
        leading: Icon(Icons.login),
        title: Text("Logout"),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      const Divider(
        color: Colors.black,
      ),
      ListTile(
        leading: Icon(Icons.remove_red_eye),
        title: Text("Change Password"),
        onTap: () {
          Navigator.pop(context);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPapers()));
        },
      ),
    ],
  );
}