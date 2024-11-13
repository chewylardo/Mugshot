import 'dart:io';
import 'Usuario.dart';
class Cafe {
  String nombre;
  String descripcion;
  List<String> ingredientes;
  Usuario miCreador;
  File miIamagen;
  List<String> pasos;
  //fecha de registro
  //Duracion
  //Porductos asociados
  //veces preparada
  

  Cafe(this.nombre, this.descripcion, this.ingredientes,this.miCreador,this.miIamagen,this.pasos); 

  void agregarIngrediente(String ingrediente) {
    ingredientes.add(ingrediente);
  }

  String ingredientesToString(){
       String listaDeIngredientes = '';

    if (this.ingredientes.isNotEmpty) {
      for (int i = 0; i < ingredientes.length; i++) {
        String nombre = ingredientes[i]; 
        listaDeIngredientes += "- $nombre\n";
      }
    }

    return listaDeIngredientes;
  }
}




