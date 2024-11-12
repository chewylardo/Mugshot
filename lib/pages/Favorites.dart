import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'Info del Cafe.dart';
import 'CrearCafe.dart';
import 'Navegacion.dart';
import 'package:mugshot/models/ColorHelper.dart';


class Favorites extends StatefulWidget {
  const Favorites ({super.key,  });


  @override
  State<Favorites > createState() => _Favorites ( );
}

class _Favorites extends State<Favorites > {
 
  

  List<bool> likeStates = List.generate(5, (_) => false); 
 
  @override
  Widget build(BuildContext context) {
    final Usuario mainUsuario = BottomBar.mainUsuario;
    final String nombre = mainUsuario.nombre;
    var scaffold6 = Scaffold(
      backgroundColor: ColorHelper.second,
    appBar: AppBar(
       backgroundColor: ColorHelper.main,
      title: Text('Cafes favoritos de $nombre',style:const TextStyle(color: Colors.white),),
    ),
    body: Center(
      child: BottomBar.mainUsuario.misFavoritos.isEmpty
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sentiment_dissatisfied,
                  size: 48,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text(
                  'Sin recetas por el momento',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: BottomBar.mainUsuario.misFavoritos.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/pngs/Café.png'),
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
                                BottomBar.mainUsuario.misFavoritos[index].nombre,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                BottomBar.mainUsuario.misFavoritos[index]
                                    .descripcion,
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('Detalles de la Receta',
                                        style:
                                            TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                               InfoCafe(cofee:  BottomBar.mainUsuario.misFavoritos[index], usuario:  BottomBar.mainUsuario.misFavoritos[index].miCreador),
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
                            label: Text('Like',
                                style: TextStyle(
                                    color: likeStates[index]
                                        ? Colors.blue
                                        : Colors.white)),
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



        ),
    ),
  );
    var scaffold5 = scaffold6;
    var scaffold4 = scaffold5;
    var scaffold3 = scaffold4;
    var scaffold2 = scaffold3;
    var scaffold = scaffold2;
    return scaffold;
}}