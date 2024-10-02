import 'package:flutter/material.dart';
import 'package:mugshot/models/Usuario.dart';
import 'Info del Cafe.dart';
import 'CrearCafe.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,  required this.mainUsuario});
  final Usuario mainUsuario; 

  @override
  State<MyHomePage> createState() => _MyHomePageState(mainUsuario: mainUsuario );
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({  required this.mainUsuario});
  final Usuario mainUsuario;
  List<bool> likeStates = List.generate(5, (_) => false); 

  @override
  Widget build(BuildContext context) {
    var scaffold6 = Scaffold(
      appBar: AppBar(
        title: const Text('Cafes Recomendados de hoy'),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: likeStates.length, 
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
                            'Cafe $index',
                             style:const TextStyle(fontSize: 18,color: Colors.white),
                          ),
                          Text(
                            'El cafe $index es el cafe mas potente que puedes hacer con \ncafe de tarro  ',
                            style:const TextStyle(fontSize: 11,color: Colors.white),
                            
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
                                      builder: (context) => const InfoCafe(),
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
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  Crearcafe(miUsuario: mainUsuario,),
            ),
          );
        },
        child: const Icon(Icons.add), 
      ),
    );
    

  


    var scaffold5 = scaffold6;
    var scaffold4 = scaffold5;
    var scaffold3 = scaffold4;
    var scaffold2 = scaffold3;
    var scaffold = scaffold2;
    return scaffold;

  }
}
