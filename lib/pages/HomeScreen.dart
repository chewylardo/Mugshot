import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';



var logger = Logger( printer: PrettyPrinter());

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  int _counter = 0;
 
  void _incrementCounter() {
    setState(() {
     
      _counter++;
    });
  }

   void _decrementCounter() {
    setState(() {
    
      _counter--;
    });
  }


   void _ResetCounter() {
    setState(() {
    
      _counter = 0;
    });
  }
  
 

  String _text(){
    String texto = '';
    if(_counter == 10 ){
        texto = 'VICTORIA';

      }else if (_counter == 5){
          texto = 'DERROTA';
      }else {
          texto = 'has apretado el boton esta cantidad de veces:';
      }


    return texto;
  }





  @override
  Widget build(BuildContext context) {
    int myIndex = 0;
       logger.d('Home page widget build is working');
    
     
    var scaffold6 = Scaffold(

     
      appBar: AppBar(

        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     
        title: Text(widget.title),
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
                      _text(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '$_counter',
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
                                builder: (context) => const Detalle(),
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
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: myIndex, 
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Tienda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Perfil',
        ),
      ],
      onTap: (int index) {
        setState((){

            myIndex = index;

        });
      },
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













/////////////////////////////////////////////////////////////////////////////////////////////


















class Detalle extends StatelessWidget {
  const Detalle({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffold6 = Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'informacion sobre detalles',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            
          ],
          
        ),
      ),
      
      persistentFooterButtons: <Widget>[
        TextButton(
            onPressed:(){
               
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Sobre(),
                  ),
                );
              },
              child: const Text('Sobre'),
        ),

        TextButton(
          onPressed:(){
               
            Navigator.pop(context);
          },
        child: const Text('Volver'),)
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









//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffold6 = Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Software programado Por Sergio Poblete',
              style: TextStyle(fontSize: 24),
            ),
             SizedBox(height: 20),
          
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
      
        TextButton(
          onPressed:(){
               
            Navigator.pop(context);
          },
        child: const Text('Volver'),)
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