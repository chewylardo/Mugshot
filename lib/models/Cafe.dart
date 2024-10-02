import 'Ingrediente.dart';

class Cafe {
  String nombre;
  List<Ingrediente> ingredientes; 

  
  Cafe(this.nombre, List<Ingrediente> ingredientes)
      : ingredientes = List.from(ingredientes);

  void agregarIngrediente(Ingrediente ingrediente) {
    ingredientes.add(ingrediente); 
  }
}