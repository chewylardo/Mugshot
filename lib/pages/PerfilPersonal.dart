import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'Info del Cafe.dart';

class PerfilPersonal extends StatelessWidget {
  const PerfilPersonal({super.key, required this.miUsuario});

  final Usuario miUsuario;

  @override
  Widget build(BuildContext context) {
    final String nombre = miUsuario.nombre;
    final String usuario = miUsuario.usuario;
    final int rating = miUsuario.rating;
    final String descripcion = miUsuario.descripcion;
    final String pfp = miUsuario.pfp;

    return Scaffold(
      appBar: AppBar(
        title: Text(nombre),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                'Descripción: $descripcion',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 20,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InfoCafe(),
                      ),
                    );
                  },
                  child: const Text('Ver Recetas', style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 10),
              Material(
                elevation: 4,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InfoCafe(),
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