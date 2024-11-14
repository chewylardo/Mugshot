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
  final List<String> steps = []; 
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _productsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController(); 

  String? savedName;
  String? savedDescription;
  File? _selectedImage;
  int? key;
  int contador = 0;
  String? savedProducts;
  int? savedTime;

  void _saveName() {
    setState(() {
      savedName = _nameController.text;
    });
    _nameController.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Name: $savedName')));
  }

  void _saveDescription() {
    setState(() {
      savedDescription = _descriptionController.text;
    });
    _descriptionController.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Description: $savedDescription')));
  }

  void _saveIngredients() {
    setState(() {
      if (_ingredientsController.text.isNotEmpty) {
        ingredients.add(_ingredientsController.text);
        _ingredientsController.clear();
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Ingredient: ${_ingredientsController.text}')));
  }

  void _saveTime() {
    setState(() {
    
      if (_timeController.text.isNotEmpty && int.tryParse(_timeController.text) != null) {
        savedTime = int.parse(_timeController.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Time: $savedTime')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid time')));
      }
    });
  }

  void _saveProducts() {
    setState(() {
      savedProducts = _productsController.text;
    });
    _productsController.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Products: $savedProducts')));
  }

  void _saveSteps() {
    setState(() {
      if (_stepsController.text.isNotEmpty) {
        steps.add(_stepsController.text);
        _stepsController.clear();
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Step: ${_stepsController.text}')));
  }

  Cafe _generarCafe(String savedName, String savedDescription, List<String> ingredients, String savedProducts, int savedTime, List<String> steps) {
    List<String> misIngredientes = [];
    for (int i = 0; i < ingredients.length; i++) {
      misIngredientes.add(ingredients[i]);
    }

  
    String fechaRegistro = DateTime.now().toString();

    Cafe myCafe = Cafe(
      nombre: savedName,
      descripcion: savedDescription,
      ingredientes: misIngredientes,
      miCreador: '@Usuario Por Defecto',
      miIamagen: _selectedImage!,
      pasos: steps,
      fechaRegistro: fechaRegistro, 
      duracion: savedTime, 
      vecesPreparada: 0,
      porductosAsociados: savedProducts, 
      soyPrecargado: 0,
    );

    return myCafe;
  }

  void _darCafe() {
    if (savedName != null && savedDescription != null && ingredients.isNotEmpty && _selectedImage != null && savedTime != null && savedProducts != null && steps.isNotEmpty) {
      BottomBar.mainUsuario.agregarCafe(_generarCafe(savedName!, savedDescription!, ingredients, savedProducts!, savedTime!, steps));
      Navigator.pop(context);  
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, rellena todos los campos')));
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.second,
      appBar: AppBar(
        backgroundColor: ColorHelper.main,
        title: const Text('Creemos un café hoy', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            const Text('Nombre del café', style: TextStyle(fontSize: 24)),
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
                ElevatedButton(onPressed: _saveName, child: const Text('Guardar')),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Descripción', style: TextStyle(fontSize: 18)),
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
                ElevatedButton(onPressed: _saveDescription, child: const Text('Guardar')),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Ingredientes', style: TextStyle(fontSize: 18)),
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
                ElevatedButton(onPressed: _saveIngredients, child: const Text('Guardar')),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Tiempo (minutos)', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Duración',
                      hintText: 'Tiempo en minutos',
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _saveTime, child: const Text('Guardar')),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Productos Asociados', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _productsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Productos',
                      hintText: 'Productos asociados a tu café',
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _saveProducts, child: const Text('Guardar')),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Pasos de Preparación', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _stepsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Paso',
                      hintText: 'Describe el paso de la preparación',
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _saveSteps, child: const Text('Guardar')),
              ],
            ),
            const SizedBox(height: 20),
            _selectedImage != null
                ? Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const Text('No se ha seleccionado una imagen'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _pickImageFromGallery, child: const Text('Seleccionar imagen desde la galería')),
            ElevatedButton(onPressed: _pickImageFromCamera, child: const Text('Tomar una foto')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _darCafe, child: const Text('Guardar Café')),
          ],
        ),
      ),
    );
  }
}
