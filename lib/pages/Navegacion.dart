import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'Home.dart';
import 'PerfilPersonal.dart';
import 'Tienda.dart';






class BottomBar extends StatefulWidget{
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  
  static Usuario mainUsuario = Usuario(
    nombre: 'Sergio',
    usuario: '@chewy45',
    rating: 5,
    descripcion: 'Me gusta el café con leche y los gatos \n barista amateur \n fan de el cafe marely',
    pfp: 'assets/pngs/perro.png',
  );
  
  int myIndex = 0;

 
  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();

    widgetList = [
      MyHomePage(mainUsuario: mainUsuario,),
      const Tienda(),
      PerfilPersonal(miUsuario: mainUsuario), 
    ];
  }
 
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









