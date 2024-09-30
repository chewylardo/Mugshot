import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'Home.dart';
import 'Info del Cafe.dart';
import 'Perfil.dart';
import 'Tienda.dart';






class BottomBar extends StatefulWidget{
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {

  int myIndex = 0;

    List<Widget> widgetList = const[
    MyHomePage(),
    Sobre(),
    Sobre(),

  ];
 
  @override
  Widget build(BuildContext context) {
    var scaffold6 = Scaffold(
      
      body:  Center(


       
         
       child: widgetList[myIndex],
       

      ),
    
      
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: myIndex, 
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Tienda',
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









