import 'package:flutter/material.dart';
import 'package:tailor_application/profile.dart';

class Login extends StatefulWidget {
  String type;
  Login(this.type);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Login "+widget.type),),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.person,size: 200,),
            TextFormField(
                onChanged: (value) {
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  hintText: 'Username',
                  prefixIcon: Icon(Icons.person),
                )),
            SizedBox(height: 5,),
            TextFormField(
                onChanged: (value) {
                },
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.remove_red_eye),
                )),
            SizedBox(height: 10,),
            SizedBox(height: 50,child: ElevatedButton( onPressed: (){NavigateToNextScreen();}, child: Text("Login",))),

          ],
        ),
      ),
    );
  }

  NavigateToNextScreen(){
    if(widget.type == "Tailor")
      {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>myProfile()));
      }
  }
}
