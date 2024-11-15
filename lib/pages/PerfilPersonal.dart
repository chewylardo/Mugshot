import 'package:flutter/material.dart';
import 'package:mugshot/models/Question.dart';
import 'package:mugshot/models/Usuario.dart';
import 'package:mugshot/pages/MyCafe.dart';
import 'Navegacion.dart';
import 'Opinion.dart';
import 'package:mugshot/models/ColorHelper.dart';
import 'CrearCafe.dart';

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
        title: Text(nombre, style: const TextStyle(color: Colors.white)),
        backgroundColor: ColorHelper.main,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              String jsonInput = await DefaultAssetBundle.of(context).loadString('assets/data/Usabilidad.json');
              final List<QuestionCategory> categories = parseJson(jsonInput);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpinionScreen(categories: categories),
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
  elevation: 0,  
  child: TextButton(
    style: TextButton.styleFrom(
      backgroundColor: ColorHelper.fourth,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), 
      shape: RoundedRectangleBorder( 
        borderRadius: BorderRadius.circular(8.0), 
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Mycafe(),
        ),
      );
    },
    child: const Text(
      'Ver Recetas',
      style: TextStyle(color: Colors.white),
    ),
  ),
),

const SizedBox(height: 10),

Material(
  elevation: 0, 
  child: TextButton(
    style: TextButton.styleFrom(
      backgroundColor: ColorHelper.fourth,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      shape: RoundedRectangleBorder( 
        borderRadius: BorderRadius.circular(8.0), 
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Crearcafe(miUsuario: BottomBar.mainUsuario),
        ),
      );
    },
    child: const Text(
      'Crear Cafe',
      style: TextStyle(color: Colors.white),
    ),
  ),
),

const SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}