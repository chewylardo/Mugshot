import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'package:mugshot/pages/EditarCafe.dart';

import 'Info del Cafe.dart';

import 'Navegacion.dart';
import 'package:mugshot/models/ColorHelper.dart';
import 'package:mugshot/models/Cafe.dart';

List<Cafe> mainCafe(Usuario miCreador) {
  
  miCreador.misCafes.sort((a, b) => b.vecesPreparada.compareTo(a.vecesPreparada));

  List<Cafe> ordenados = miCreador.misCafes.take(3).toList();

  return ordenados;
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  List<bool> likeStates = List.generate(5, (_) => false);
  
  Future<File?> _loadProfileImage(String imagePath) async {
    if (imagePath.isNotEmpty) {
      return File(imagePath);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Usuario mainUsuario = BottomBar.mainUsuario;
    final String nombre = mainUsuario.nombre;

    print("misCafes length: ${mainUsuario.misCafes.length}");

    List<Cafe> cafesOrdenados = mainCafe(mainUsuario); 

    return Scaffold(
      backgroundColor: ColorHelper.second,
      appBar: AppBar(
        backgroundColor: ColorHelper.main,
        title: Text(
          "Cafes de $nombre",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: cafesOrdenados.isNotEmpty
          ? ListView.builder(
              itemCount: cafesOrdenados.length,
              itemBuilder: (context, index) {
                final cafe = cafesOrdenados[index];

                return FutureBuilder<File?>(
                  future: _loadProfileImage(cafe.miIamagen.path),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(snapshot.data!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      cafe.nombre,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      cafe.descripcion,
                                      style: const TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child: const Text(
                                            'Detalles de la Receta',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => InfoCafe(
                                                  cofee: cafe,
                                                  usuario: cafe.miCreador,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.thumb_up,
                                    color: likeStates[index]
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                  label: Text(
                                    'Like',
                                    style: TextStyle(
                                        color: likeStates[index]
                                            ? Colors.blue
                                            : Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      likeStates[index] = !likeStates[index];
                                    });
                                  },
                                ),
                              ),
                           
                              Positioned(
                                top: 16,
                                right: 16,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditarCafeScreen(
                                        
                                          cafe: cafe,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: Text('No se encontró la imagen\nVaya a crear recetas \nen su perfil'));
                    }
                  },
                );
              },
            )
          : const Center(
              child: Text(
                'No existen cafes registrados.\nVaya a crear recetas \nen su perfil.',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
    );
  }
}

