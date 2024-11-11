import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'Info del Cafe.dart';
import 'CrearCafe.dart';
import 'Navegacion.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:mugshot/models/Cafe.dart';
import 'package:mugshot/models/Ingrediente.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> likeStates = List.generate(5, (_) => false); 
  late Future<File> _imageFile;

  @override
  void initState() {
    super.initState();
    _imageFile = loadImageAsFile('assets/pngs/Café.png');
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
      appBar: AppBar(
        title: const Text('Cafes Recomendados de hoy'),
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

        
            Ingrediente ingrediente1 = Ingrediente('leche');
            Ingrediente ingrediente2 = Ingrediente('azucar');
            Ingrediente ingrediente3 = Ingrediente('crema');
            Ingrediente ingrediente4 = Ingrediente('Agua');
            Ingrediente ingrediente5 = Ingrediente('Cafe en tarro');

         
            List<Ingrediente> receta1 = [ingrediente4, ingrediente5];
            List<Ingrediente> receta2 = [ingrediente1, ingrediente5, ingrediente2];
            List<Ingrediente> receta3 = [ingrediente3, ingrediente5, ingrediente4];

       
            Usuario Usuario1 = Usuario(
              nombre: 'Barabara',
              usuario: '@Barbi430',
              rating: 4,
              descripcion: 'Quiero mucho a mi perrita \nfan del cafe en tarro',
              pfp: 'assets/pngs/Perro2.png',
            );
            Usuario Usuario2 = Usuario(
              nombre: 'Felipe',
              usuario: '@xXPipeXx',
              rating: 5,
              descripcion: 'odio el cafe con leche',
              pfp: 'assets/pngs/gato.png',
            );

      
            Cafe cafe1 = Cafe('cargado', 'solo es cafe con agua', receta1, Usuario2, imageFile);
            Cafe cafe2 = Cafe('nocturno', 'cafe para trabajar toda la noche en proyectos universitarios', receta2, Usuario1, imageFile);
            Cafe cafe3 = Cafe('suave', 'relajante expresion del arte enfocada en un cafe con sabores iconicos', receta3, Usuario1, imageFile);

            Usuario1.misCafes.add(cafe2);
            Usuario1.misCafes.add(cafe3);
            Usuario2.misCafes.add(cafe1);

            List<Cafe> homeCofee = Usuario2.misCafes + Usuario1.misCafes;

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
                                          builder: (context) => InfoCafe(cofee: homeCofee[index], usuario: homeCofee[index].miCreador),
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
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No se encontró la imagen'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Crearcafe(miUsuario: BottomBar.mainUsuario),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
