import 'package:flutter/material.dart';

class MyCustomeButton extends StatelessWidget {

  Text ButtonText;
  Icon btnIcon;
  Widget OnPressFunction;

  MyCustomeButton({required this.ButtonText,required this.OnPressFunction,required this.btnIcon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){OnPressFunction;}, child: Row(
      children: [
        btnIcon,
        SizedBox(width: 10,),
        ButtonText,
      ],
    ));
  }
}
