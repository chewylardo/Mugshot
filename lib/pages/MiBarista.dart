import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'package:mugshot/pages/EditarCafe.dart';
import 'package:path_provider/path_provider.dart';
import 'Info del Cafe.dart';
import 'CrearCafe.dart';
import 'Navegacion.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:mugshot/models/Cafe.dart';
import 'package:mugshot/models/ColorHelper.dart';


class MiBarista extends StatefulWidget {
  const MiBarista({super.key});

  @override
  State<MiBarista> createState() => _MiBarista();
}

class _MiBarista extends State<MiBarista> {
  List<bool> likeStates = List.generate(5, (_) => false); 
  late Future<File> _imageFile;
  late Future<List<Cafe>> _cafesFuture;

  @override
  void initState() {
    super.initState();
    _imageFile = loadImageAsFile('assets/pngs/Café.png');
    _cafesFuture = cargarCafesDesdeJson();  
  }

  Future<File> loadImageAsFile(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final Directory tempDir = await getTemporaryDirectory();
    final File tempFile = File('${tempDir.path}/temp_image.png');
    await tempFile.writeAsBytes(bytes);
    return tempFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.second,
      appBar: AppBar(
        backgroundColor: ColorHelper.main,
        title: const Text(
          'Cafes Recomendados de hoy',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<File>(
        future: _imageFile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final File imageFile = snapshot.data!;

         
            return FutureBuilder<List<Cafe>>(
              future: _cafesFuture,
              builder: (context, cafeSnapshot) {
                if (cafeSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (cafeSnapshot.hasError) {
                  return Center(child: Text('Error al cargar los cafés: ${cafeSnapshot.error}'));
                } else if (!cafeSnapshot.hasData || cafeSnapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay cafés disponibles'));
                } else {
                  List<Cafe> homeCofee = cafeSnapshot.data!;

                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: homeCofee.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(imageFile),
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
                                      homeCofee[index].nombre,
                                      style: const TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      homeCofee[index].descripcion,
                                      style: const TextStyle(fontSize: 11, color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child: const Text('Detalles de la Receta', style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => InfoCafe(
                                                  cofee: homeCofee[index],
                                                  usuario: homeCofee[index].miCreador,
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
                                  label: Text('Like', style: TextStyle(color: likeStates[index] ? Colors.blue : Colors.white)),
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
                                        
                                          cafe: homeCofee[index],
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
                    },
                  );
                }
              },
            );
          } else {
            return const Center(child: Text('No se encontró la imagen'));
          }
        },
      ),
    );
  }
}
