import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:mugshot/models/Cafe.dart';
import 'package:mugshot/models/Usuario.dart';
import 'package:mugshot/pages/Perfil.dart';
import 'Navegacion.dart';

class InfoCafe extends StatelessWidget {
  const InfoCafe({super.key, required this.cofee, required this.usuario});
  final Cafe cofee;
  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    bool fav = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cafe'),
          ),
          body: Stack(
            children: [
              Center(
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Image(image:AssetImage('assets/pngs/cafecito.png')),
                       
                        Text(
                          cofee.nombre,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cofee.descripcion,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cofee.ingredientesToString(),
                        ),
                        const SizedBox(height: 16),
                        Material(
                          elevation: 4,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Perfil(miUsuario: usuario)),
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
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: Icon(
                    Icons.star,
                    color: fav ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      fav = !fav;
                    });
                    BottomBar.mainUsuario.misFavoritos.add(cofee);
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