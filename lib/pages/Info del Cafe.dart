import 'package:flutter/material.dart';
import 'package:mugshot/pages/Navegacion.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mugshot/models/Cafe.dart';
import 'dart:io';
import 'package:mugshot/models/ColorHelper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class InfoCafe extends StatelessWidget {
  const InfoCafe({super.key, required this.cofee, required this.usuario});
  final Cafe cofee;
  final String usuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.second,
      appBar: AppBar(
        backgroundColor: ColorHelper.main,
        title: const Text('Cafe', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 500,
              height: 800,
              child: Card(
                color: ColorHelper.third,
                elevation: 4,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (cofee.soyPrecargado != 1)
                        cofee.miIamagen != null
                            ? Image.file(
                                cofee.miIamagen,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : const Text("No hay imagen seleccionada"),
                      if (cofee.soyPrecargado  == 1)
                        Image.asset(
                          'assets/pngs/Café.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(height: 8),
                      Text(
                        cofee.nombre,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(cofee.descripcion),
                      const SizedBox(height: 8),
                      Text(cofee.ingredientesToString()),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                await shareImageWithMessage(cofee);
              },
            ),
          ),
          Positioned(
            top: 16,
            right: 14,
            child: IconButton(
              icon: const Icon(Icons.plus_one),
              onPressed: (){
                for(int i = 0;i <BottomBar.mainUsuario.misCafes.length;i++){
                  if(BottomBar.mainUsuario.misCafes[i].nombre == cofee.nombre){

                      BottomBar.mainUsuario.misCafes[i].vecesPreparada++;


                    break;
                  }
                  
                }
              },
            ),
          ),
            Positioned(
            top: 16,
            right: 12,
            child: IconButton(
              icon: const Icon(Icons.plus_one),
              onPressed: (){
                
                if(cofee.soyPrecargado == 0){



                }



              },
            ),
          )
          
        ],
      ),
    );
  }

  // Function to share image and message
  Future<void> shareImageWithMessage(Cafe cofee) async {
    final ByteData bytes = await rootBundle.load('assets/pngs/Café.png');
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/Café.png').create();

    await file.writeAsBytes(list);
    final xFile = XFile(file.path);

    await Share.shareXFiles([xFile], text: 'Mensaje generado con la aplicación Flutter');
  }
}
//if(cofee.soyPrecargado == 0){}