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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Ingredient')));
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Products')));
  }

  void _saveSteps() {
    setState(() {
      if (_stepsController.text.isNotEmpty) {
        steps.add(_stepsController.text);
        _stepsController.clear();
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved Step')));
  }

  Cafe _generarCafe(String savedName, String savedDescription, List<String> ingredients, String savedProducts, int savedTime, List<String> steps) {
    String fechaRegistro = DateTime.now().toString();

    return Cafe(
      nombre: savedName,
      descripcion: savedDescription,
      ingredientes: ingredients,
      miCreador: savedName,
      miIamagen: _selectedImage!,
      pasos: steps,
      fechaRegistro: fechaRegistro,
      duracion: savedTime,
      vecesPreparada: 0,
      porductosAsociados: savedProducts,
      soyPrecargado: 0,
    );
  }

  void _darCafe() {
    if (savedName != null && savedDescription != null && ingredients.isNotEmpty && _selectedImage != null && savedTime != null && savedProducts != null && steps.isNotEmpty) {
      widget.miUsuario.agregarCafe(_generarCafe(savedName!, savedDescription!, ingredients, savedProducts!, savedTime!, steps));
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
            const Text('Nombre del café', style: TextStyle(fontSize: 24, color: Colors.white)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                      hintText: 'Ingresa el nombre de tu café',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveName,
                  style: ElevatedButton.styleFrom(backgroundColor: ColorHelper.main),
                  child: const Text('Guardar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Descripción', style: TextStyle(fontSize: 18, color: Colors.white)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descripción',
                      hintText: 'Ingresa una descripción de tu café',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveDescription,
                  style: ElevatedButton.styleFrom(backgroundColor: ColorHelper.main),
                  child: const Text('Guardar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Ingredientes', style: TextStyle(fontSize: 18, color: Colors.white)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingrediente',
                      hintText: 'Ingresa un ingrediente',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveIngredients,
                  style: ElevatedButton.styleFrom(backgroundColor: ColorHelper.main),
                  child: const Text('Añadir', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: ingredients.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(ingredients[index], style: const TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Tiempo (minutos)', style: TextStyle(fontSize: 18, color: Colors.white)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Duración',
                      hintText: 'Tiempo en minutos',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveTime,
                  style: ElevatedButton.styleFrom(backgroundColor: ColorHelper.main),
                  child: const Text('Guardar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Productos Asociados', style: TextStyle(fontSize: 18, color: Colors.white)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _productsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Productos',
                      hintText: 'Ingresa productos asociados',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveProducts,
                  style: ElevatedButton.styleFrom(backgroundColor: ColorHelper.main),
                  child: const Text('Guardar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Pasos de Preparación', style: TextStyle(fontSize: 18, color: Colors.white)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _stepsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Paso',
                      hintText: 'Describe un paso de preparación',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveSteps,
                  style: ElevatedButton.styleFrom(backgroundColor: ColorHelper.main),
                  child: const Text('Añadir', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: steps.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(steps[index], style: const TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    child: const Text('Seleccionar Imagen de Galería'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickImageFromCamera,
                    child: const Text('Tomar Foto'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey), 
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _darCafe,
              style: ElevatedButton.styleFrom(backgroundColor: ColorHelper.main),
              child: const Text('Finalizar y Guardar Café', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
