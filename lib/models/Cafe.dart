import 'dart:io';


class Cafe {
  String nombre;
  String descripcion;
  List<String> ingredientes;
  String miCreador;
  File miIamagen;
  List<String> pasos;
  String fechaRegistro;
  int duracion;
  String porductosAsociados;
  int vecesPreparada;
  int soyPrecargado;
  

  Cafe({required this.nombre,required this.descripcion,required this.ingredientes,required this.miCreador,required this.miIamagen,required this.pasos,required this.fechaRegistro,required this.duracion,required this.vecesPreparada,required this.porductosAsociados,required this.soyPrecargado});

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

   factory Cafe.fromJson(Map<String, dynamic> json) {
    return Cafe(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      ingredientes: List<String>.from(json['ingredientes']),
      miCreador: json['miCreador'],
      miIamagen: File(json['miIamagen']),
      pasos: List<String>.from(json['pasos']),
      fechaRegistro: json['fechaRegistro'],
      duracion: json['duracion'],
      vecesPreparada: json['vecesPreparada'],
      porductosAsociados: json['porductosAsociados'],
      soyPrecargado: json['soyPrecargado']
    );
  }







  
}




