import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class tailorRegister extends StatefulWidget {
  const tailorRegister({Key? key}) : super(key: key);

  @override
  _tailorRegisterState createState() => _tailorRegisterState();
}

class _tailorRegisterState extends State<tailorRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text(""),),
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
            SizedBox(height: 5,),
            TextFormField(
                onChanged: (value) {
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  hintText: 'Address',
                  prefixIcon: Icon(Icons.location_on),
                )),
            SizedBox(height: 5,),
            TextFormField(
              onChanged: (value) {
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                ),
                hintText: 'Phone Number',
                prefixIcon: Icon(Icons.call),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),

            SizedBox(height: 10,),
            SizedBox(height: 50,child: ElevatedButton( onPressed: (){}, child: Text("Register",))),

          ],
        ),
      ),
    );
  }
}
