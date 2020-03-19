import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget{
  final File image;

  ProfileCard({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: image==null?FloatingActionButton(child:Icon(Icons.add_circle_outline,color: Colors.white),backgroundColor: Colors.black,onPressed: (){},heroTag: "btn2",):Image.file(image)
    );
  }

}