import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'Info del Cafe.dart';
import 'CrearCafe.dart';
import 'Navegacion.dart';
import 'package:mugshot/models/ColorHelper.dart';

class Mycafe extends StatefulWidget {
  const Mycafe({super.key});

  @override
  State<Mycafe> createState() => _Mycafe();
}

class _Mycafe extends State<Mycafe> {
  List<bool> likeStates = List.generate(5, (_) => false);

  Future<File?> _loadCafeImage(String imagePath) async {
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
          ? ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: mainUsuario.misCafes.length,
              itemBuilder: (context, index) {
                final cafe = mainUsuario.misCafes[index];
                return FutureBuilder<File?>(
                  future: _loadCafeImage(cafe.miIamagen.path), 
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
                                    color: likeStates[index] ? Colors.blue : Colors.white,
                                  ),
                                  label: Text(
                                    'Like',
                                    style: TextStyle(
                                        color: likeStates[index] ? Colors.blue : Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      likeStates[index] = !likeStates[index];
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
                );
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
