
import 'package:mugshot/models/Cafe.dart';


class Usuario {
  String nombre;
  String usuario;
  int rating;
  String descripcion;
  String pfp;
  List<Cafe> misCafes; 
  


  Usuario({required this.nombre,required this.usuario,this.rating = 0, this.descripcion = '',this.pfp = '',List<Cafe>? misCafes, List<Cafe>? misFavoritos, })  : misCafes = misCafes ?? [];


  void agregarCafe(Cafe cafe) {
    
    misCafes.add(cafe);
  }

  

}