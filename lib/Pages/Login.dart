import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_application/Pages/profile.dart';

class Login extends StatefulWidget {
  String type;
  Login(this.type);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final phoneControllar = TextEditingController();
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
              controller: phoneControllar,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  hintText: 'PhoneNumber',
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
            SizedBox(height: 50,child: ElevatedButton( onPressed: () async {
              // try {
              //   UserCredential userCredential = (await FirebaseAuth.instance.signInWithPhoneNumber(
              //       phoneControllar.text,
              //       [RecaptchaVerifier? verifier?],
              //   ));
              //   User? user = userCredential.user;
              //   if(user != null)
              //     {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const myProfile(),
              //         ),
              //       );
              //     }
              //
              // } on FirebaseAuthException catch (e) {
              //   if (e.code == 'user-not-found') {
              //     print('No user found for that email.');
              //   } else if (e.code == 'wrong-password') {
              //     print('Wrong password provided for that user.');
              //   }
              // }
              // User? user = FirebaseAuth.instance.currentUser;
              // if (user != null){
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const myProfile(),
              //     ),
              //   );
              // }
            },
                child: Text("Login",))),
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
