import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:share_plus/share_plus.dart';
import 'package:mugshot/models/Cafe.dart';
import 'package:mugshot/models/Usuario.dart';
import 'package:mugshot/pages/Perfil.dart';
import 'dart:io';
import 'Navegacion.dart';
import 'package:mugshot/models/ColorHelper.dart';


import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';


import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class InfoCafe extends StatelessWidget {
  const InfoCafe({super.key, required this.cofee, required this.usuario});
  final Cafe cofee;
  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    

    return StatefulBuilder(
      builder: (context, setState) {
        return Scaffold(
          backgroundColor: ColorHelper.second,
          appBar: AppBar(
             backgroundColor: ColorHelper.main,
            title: const Text('Cafe',style:const TextStyle(color: Colors.white)),
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
            cofee.miIamagen != null
                ? Image.file(
                    cofee.miIamagen,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    
                  )
                : const Text("No hay imagen seleccionada"),
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
            Material(
              elevation: 4,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Perfil(miUsuario: usuario),
                    ),
                  );
                },
                child: Text(
                  usuario.usuario,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
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
                  icon: const Icon(
                    Icons.share
                  ),
                  onPressed: ()async {
                   shareImageWithMessage();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  
}


// alfin salio ;-;
Future<void> shareImageWithMessage() async {

  final ByteData bytes = await rootBundle.load('assets/pngs/Perro2.png');

  final Uint8List list = bytes.buffer.asUint8List();


  final tempDir = await getTemporaryDirectory();

  final file = await File('${tempDir.path}/Perro2.png').create();

  await file.writeAsBytes(list);


  final xFile = XFile(file.path);

 
 
  await Share.shareXFiles([xFile], text: 'mensaje generado con apliccaion flutter');
}

