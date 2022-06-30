import 'dart:math';
import 'package:flutter/material.dart';

class characterWrapWidget extends StatelessWidget {

  final String char ;
  characterWrapWidget({required this.char});

  //final char = 'T';
  @override
  Widget build(BuildContext context) {
    final size = 36.0;
    return Container(
      width: size,
      height: size,
      color: Colors.black38,
      transform: rotateEachBox(),
      child: FittedBox(child: Text(char),
      fit: BoxFit.contain,
      ),
    );
  }

  Matrix4 rotateEachBox(){

    final List<double> angles = [-pi/16, pi/16, -pi/8, pi/8];
    final anglesZ = angles[Random(1278732 + char.codeUnitAt(0)).nextInt(angles.length)];

    return Matrix4.identity()..rotateZ(anglesZ);

  }

}
