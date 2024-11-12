import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'package:mugshot/pages/MyCafe.dart';
import 'Info del Cafe.dart';
import 'Favorites.dart';
import 'MyCafe.dart';
import 'Navegacion.dart';
import 'Opinion.dart';
import 'package:mugshot/models/ColorHelper.dart';

class PerfilPersonal extends StatelessWidget {
  const PerfilPersonal({super.key});

  @override
  Widget build(BuildContext context) {
    final Usuario miUsuario = BottomBar.mainUsuario;
    final String nombre = miUsuario.nombre;
    final String usuario = miUsuario.usuario;
    final int rating = miUsuario.rating;
    final String descripcion = miUsuario.descripcion;
    final String pfp = miUsuario.pfp;

    return Scaffold(
      backgroundColor: ColorHelper.second,
      appBar: AppBar(
        
        title: Text(nombre,style:const TextStyle(color: Colors.white),),
        backgroundColor: ColorHelper.main,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  Opinion(),
                      ),
                    );
                  },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color: ColorHelper.third,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
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
                        '$descripcion',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 20,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Mycafe(),
                      ),
                    );
                  },
                  child: const Text('Ver Recetas', style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Material(
                elevation: 4,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Favorites(),
                      ),
                    );
                  },
                  child: const Text('Ver Favoritos', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


