import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';





class Infoproducto extends StatelessWidget {
  const Infoproducto({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffold6 = Scaffold(
      appBar: AppBar(
        title: const Text('Cafe'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'informacion sobre cafe',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            
          ],
          
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
