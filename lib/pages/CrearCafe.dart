import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mugshot/models/Cafe.dart';
import 'package:mugshot/models/Usuario.dart';
import 'Navegacion.dart';
import 'package:mugshot/models/ColorHelper.dart';

class Crearcafe extends StatefulWidget {
  const Crearcafe({super.key, required this.miUsuario});
  final Usuario miUsuario;

  @override
  State<Crearcafe> createState() => _CrearcafeState();
}

class _CrearcafeState extends State<Crearcafe> {
  

 
  final List<String> ingredients = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();

  String? savedName;
  String? savedDescription;
  File? _selectedImage;
  int ? key;

  int contador = 0;

  void _saveName() {
    setState(() {
      savedName = _nameController.text;
    });
    _nameController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved Name: $savedName')),
    );
  }

  void _saveDescription() {
    setState(() {
      savedDescription = _descriptionController.text;
    });
    _descriptionController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved Description: $savedDescription')),
    );
  }

  void _saveIngredients() {
    setState(() {
      if (_ingredientsController.text.isNotEmpty) {
        ingredients.add(_ingredientsController.text);
        _ingredientsController.clear();
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved Ingredient: ${_ingredientsController.text}')),
    );
  }



  Cafe _generarCafe(String savedName, String savedDescription, List<String> ingredients) {

    List<String> misIngredientes = [];

    for(int i = 0;i<ingredients.length;i++){

      misIngredientes.add(ingredients[i]);


    }
    


    Cafe myCafe = Cafe(savedName, savedDescription, misIngredientes,BottomBar.mainUsuario,_selectedImage!,contador);
    return myCafe;
  }







  void _darCafe() {
    BottomBar.mainUsuario.agregarCafe(_generarCafe(savedName!, savedDescription!, ingredients));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorHelper.second,
      appBar: AppBar(
         backgroundColor: ColorHelper.main,
        title: const Text('Creemos un café hoy',style:const TextStyle(color: Colors.white),),
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Nombre del café',
              style: TextStyle(fontSize: 24),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                      hintText: 'Ingresa el nombre de tu café',
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveName,
                  child: const Text('Guardar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Descripción',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descripción',
                      hintText: 'Ingresa una descripción de tu café',
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveDescription,
                  child: const Text('Guardar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingredientes',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingrediente',
                      hintText: 'Ingresa un ingrediente',
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveIngredients,
                  child: const Text('Guardar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(ingredients[index]),
                  );
                },
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Elegir foto de galeria",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),

              ),
              onPressed: () {

                _pickImageFromGallery();

                
              }  

            ),
              MaterialButton(
              color: Colors.red,
              child: const Text(
                "Sacar foto con camara",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),

              ),
              onPressed: () {
                
                _pickImageFromCammera();

              },

            ),
            const SizedBox(height: 20,),
            _selectedImage != null ? Image.file(_selectedImage!) : const Text("Seleccione imagen")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _darCafe,
        child: const Icon(Icons.check),
      ),
    );

    
  }
  Future _pickImageFromGallery() async{
     final returnedImage =  await ImagePicker().pickImage(source: ImageSource.gallery);

      if(returnedImage == null) return;
        
      setState(() {
        _selectedImage = File(returnedImage!.path);
      });
      

  }



    Future _pickImageFromCammera() async{
     final returnedImage =  await ImagePicker().pickImage(source: ImageSource.camera);

      if(returnedImage == null) return;
        
      setState(() {
        _selectedImage = File(returnedImage!.path);
      });
      

  }
}