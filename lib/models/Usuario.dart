
import 'package:mugshot/models/Cafe.dart';


class Usuario {
  String nombre;
  String usuario;
  int rating;
  String descripcion;
  String pfp;
  List<Cafe> misCafes; 
  List<Cafe> misFavoritos;

  Usuario({required this.nombre,required this.usuario,this.rating = 0, this.descripcion = '',this.pfp = '',List<Cafe>? misCafes, List<Cafe>? misFavoritos, })  : misCafes = misCafes ?? [], misFavoritos = misFavoritos ?? []; 


  void agregarCafe(Cafe cafe) {
    
    misCafes.add(cafe);
  }

  void agregarFavorito(Cafe cafe) {

    misFavoritos.add(cafe); 
  }

}