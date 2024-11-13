import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
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
      backgroundColor: ColorHelper.second,
      appBar: AppBar(
         backgroundColor: ColorHelper.main,
        title: const Text('Cafes Recomendados de hoy',style:const TextStyle(color: Colors.white),),
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

        
            String ingrediente1 = 'leche';
            String ingrediente2 = 'azucar';
            String ingrediente3 = 'crema';
            String ingrediente4 = 'Agua';
            String ingrediente5 = 'Cafe en tarro';

         
            List<String> receta1 = [ingrediente4, ingrediente5];
            List<String> receta2 = [ingrediente1, ingrediente5, ingrediente2];
            List<String> receta3 = [ingrediente3, ingrediente5, ingrediente4];

       
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

            List<String> pasos = ['-primer paso\n','-segundo paso\n','-tercer paso\n'];
            Cafe cafe1 = Cafe('cargado', 'solo es cafe con agua', receta1, Usuario2, imageFile,pasos);
            Cafe cafe2 = Cafe('nocturno', 'cafe para trabajar toda la noche en proyectos universitarios', receta2, Usuario1, imageFile,pasos);
            Cafe cafe3 = Cafe('suave', 'relajante expresion del arte enfocada en un cafe con sabores iconicos', receta3, Usuario1, imageFile,pasos);

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
   
    );
  }
}
