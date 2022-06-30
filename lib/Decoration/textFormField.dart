import 'package:flutter/material.dart';


class TextFormFieldCustomerBuilt extends StatefulWidget {
  TextFormFieldCustomerBuilt({Key? key,required this.controller,required this.hintTxt,required this.icoon});
  TextEditingController controller;
  String hintTxt;
  IconData icoon;
  //final formKey = GlobalKey<FormState>();
  @override
  State<TextFormFieldCustomerBuilt> createState() => _TextFormFieldCustomerBuiltState();
}

class _TextFormFieldCustomerBuiltState extends State<TextFormFieldCustomerBuilt> {
  @override
  Widget build(BuildContext context) {
     return Form(
       autovalidateMode: AutovalidateMode.onUserInteraction,
      //key: widget.formKey,
       child: TextFormField(
         validator: (value){
           if(value!.isEmpty){
             return "Field should not be null";
           }
           else
             {
               return null;
             }
         },
          controller: widget.controller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Colors.amber,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            hintText: widget.hintTxt,
            prefixIcon: Icon(widget.icoon),
          )
    ),
     );
  }
}
