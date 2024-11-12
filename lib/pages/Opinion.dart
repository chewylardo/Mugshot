import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'Info del Cafe.dart';
import 'CrearCafe.dart';
import 'Navegacion.dart';
import 'package:mugshot/models/ColorHelper.dart';


class Opinion extends StatelessWidget {

  
  


  @override
  Widget build(BuildContext context) {

   return Scaffold(
    backgroundColor: ColorHelper.second,
    appBar: AppBar(
      backgroundColor: ColorHelper.main,
      title: Text('Opinion',style:const TextStyle(color: Colors.white)),
    ),
       
  );
 }
}
