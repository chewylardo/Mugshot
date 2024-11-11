import 'dart:io';
import 'Ingrediente.dart';
import 'Usuario.dart';
class Cafe {
  String nombre;
  String descripcion;
  List<Ingrediente> ingredientes;
  Usuario miCreador;
  File miIamagen;

  Cafe(this.nombre, this.descripcion, this.ingredientes,this.miCreador,this.miIamagen); 

  void agregarIngrediente(Ingrediente ingrediente) {
    ingredientes.add(ingrediente);
  }

  String ingredientesToString(){
       String listaDeIngredientes = '';

    if (this.ingredientes.isNotEmpty) {
      for (int i = 0; i < ingredientes.length; i++) {
        String nombre = ingredientes[i].nombre; // Ensure you're using `this.ingredientes`
        listaDeIngredientes += "- $nombre\n"; // Concatenate the ingredient name
      }
    }

    return listaDeIngredientes;
  }
}




