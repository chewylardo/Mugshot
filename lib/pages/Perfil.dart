import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'package:mugshot/models/ColorHelper.dart';
//import 'package:flutter_svg/flutter_svg.dart';






class Perfil extends StatelessWidget {
  Perfil({super.key,  required this.miUsuario});
  final Usuario miUsuario;
  
  


  @override
  Widget build(BuildContext context) {
    
    final String nombre = miUsuario.nombre;
    final String usuario = miUsuario.usuario;
    final int rating = miUsuario.rating;
    final String descripcion = miUsuario.descripcion;
    final String pfp = miUsuario.pfp;

   return Scaffold(
    backgroundColor: ColorHelper.second,
    appBar: AppBar(
       backgroundColor: ColorHelper.main,
      title: Text(nombre,style:const TextStyle(color: Colors.white),),
    ),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            pfp,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 20),
          Text(
            'Información sobre $nombre',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            'Usuario: $usuario',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Rating: $rating',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            descripcion,
            style: const TextStyle(fontSize: 18),
          ),


            



        ],
      ),
    ),
  );
 }
}