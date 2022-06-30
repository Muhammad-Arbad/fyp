import 'package:flutter/material.dart';



NavigateToOtherScreen(context,Widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Widget));
}

NavigateToOtherScreenByReplace(context,Widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Widget));
}