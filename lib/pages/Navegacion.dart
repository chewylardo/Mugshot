

import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'MiBarista.dart';
import 'PerfilPersonal.dart';
import 'package:mugshot/models/ColorHelper.dart';
import 'Home.dart';

import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mugshot/models/Cafe.dart';
import 'dart:convert';

Future<List<Cafe>> cargarCafesDesdeJson() async {
  
  final String response = await rootBundle.loadString('assets/data/PrecargaCafe.json');
  final List<dynamic> data = json.decode(response);


  return data.map((json) => Cafe.fromJson(json)).toList();
}




class BottomBar extends StatefulWidget{
  const BottomBar({super.key});
   static Usuario mainUsuario = Usuario(
    nombre: 'Sergio',
    usuario: '@chewy45',
    rating: 5,
    descripcion: 'Me gusta el café con leche y los gatos \nbarista amateur \nfan de el cafe marely :D',
    pfp: 'assets/pngs/perro.png',
  );
  


  @override
  State<BottomBar> createState() => _BottomBar();
}


class _BottomBar extends State<BottomBar> {
  
 
  
  int myIndex = 0;

 
  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();

    widgetList = [
      const Home(),
      const MiBarista(),
      const PerfilPersonal(), 
    ];
  }
 
  @override
  Widget build(BuildContext context) {
    var scaffold6 = Scaffold(
      backgroundColor: ColorHelper.second,
      
      body:  Center(


       
         
       child: widgetList[myIndex],
       

      ),
    
      
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: myIndex, 
      backgroundColor: ColorHelper.main,
      selectedItemColor: Colors.white,
      unselectedItemColor : Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.coffee),
          label: 'Mi Barista',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Perfil',
        ),
      ],
      onTap: (index) {
        setState((){

            myIndex = index;

        });
      },
    ),
   
    
     
      
  
   
      
   
    );
    var scaffold5 = scaffold6;
    var scaffold4 = scaffold5;
    var scaffold3 = scaffold4;
    var scaffold2 = scaffold3;
    var scaffold = scaffold2;
    return scaffold;

  }
}









