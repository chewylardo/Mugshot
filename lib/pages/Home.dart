import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'Info del Cafe.dart';



class  MyHomePage extends StatelessWidget {
  const  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffold6 = Scaffold(
      appBar: AppBar(
        title: const Text(' MyHomePage'),
      ),
      body: Center(
      
      child: ListView.builder(
       
        padding: const EdgeInsets.all(16.0),
        itemCount: 5, // Puedes cambiar este valor para crear más o menos tarjetas
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                       'hola',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'hola',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('Detalles de la Receta'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InfoCafe(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                       
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ), 
      persistentFooterButtons: const <Widget>[
        
      ]
    );

    var scaffold5 = scaffold6;
    var scaffold4 = scaffold5;
    var scaffold3 = scaffold4;
    var scaffold2 = scaffold3;
    var scaffold = scaffold2;
    return scaffold;

  }
}
