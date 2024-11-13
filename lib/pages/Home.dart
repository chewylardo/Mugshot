import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'Info del Cafe.dart';
import 'CrearCafe.dart';
import 'Navegacion.dart';
import 'package:mugshot/models/ColorHelper.dart';



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

    return Scaffold(
      backgroundColor: ColorHelper.second,
      appBar: AppBar(
        backgroundColor: ColorHelper.main,
        title: Text(
          "Cafes de $nombre",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      
      body: mainUsuario.misCafes.isNotEmpty
          ? FutureBuilder<File?>(
              future: _loadProfileImage(mainUsuario.pfp),
              builder: (context, snapshot) {
                print("misCafes length inside FutureBuilder: ${mainUsuario.misCafes.length}"); 
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  final cafe = mainUsuario.misCafes.last; 
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                      child: const Text('Detalles de la Receta',
                                          style: TextStyle(color: Colors.white)),
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
                                color: likeStates[mainUsuario.misCafes.length - 1]
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                              label: Text(
                                'Like',
                                style: TextStyle(
                                    color: likeStates[mainUsuario.misCafes.length - 1]
                                        ? Colors.blue
                                        : Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  likeStates[mainUsuario.misCafes.length - 1] =
                                      !likeStates[mainUsuario.misCafes.length - 1];
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('No se encontró la imagen'));
                }
              },
            )
          : const Center(
              child: Text(
                'No existen cafes registrados',
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            ),

  
    );
  }
}
