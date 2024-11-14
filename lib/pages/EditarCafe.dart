import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mugshot/models/Cafe.dart';
import 'package:mugshot/models/Usuario.dart';
import 'Navegacion.dart';
import 'package:mugshot/models/ColorHelper.dart';

class EditarCafeScreen extends StatefulWidget {
  final Cafe cafe;

  const EditarCafeScreen({required this.cafe});

  @override
  _EditarCafeScreenState createState() => _EditarCafeScreenState();
}

class _EditarCafeScreenState extends State<EditarCafeScreen> {
  late TextEditingController nombreController;
  late TextEditingController descripcionController;
  late TextEditingController ingredientesController;
  late TextEditingController pasosController;
  late TextEditingController fechaRegistroController;
  late TextEditingController duracionController;
  late TextEditingController productosAsociadosController;
  late TextEditingController vecesPreparadaController;
  late TextEditingController soyPrecargadoController;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.cafe.nombre);
    descripcionController = TextEditingController(text: widget.cafe.descripcion);
    ingredientesController = TextEditingController(text: widget.cafe.ingredientesToString());
    pasosController = TextEditingController(text: widget.cafe.pasos.join('\n'));
    fechaRegistroController = TextEditingController(text: widget.cafe.fechaRegistro);
    duracionController = TextEditingController(text: widget.cafe.duracion.toString());
    productosAsociadosController = TextEditingController(text: widget.cafe.porductosAsociados);
    vecesPreparadaController = TextEditingController(text: widget.cafe.vecesPreparada.toString());
    soyPrecargadoController = TextEditingController(text: widget.cafe.soyPrecargado.toString());
    _selectedImage = widget.cafe.miIamagen;
  }

  @override
  void dispose() {
    nombreController.dispose();
    descripcionController.dispose();
    ingredientesController.dispose();
    pasosController.dispose();
    fechaRegistroController.dispose();
    duracionController.dispose();
    productosAsociadosController.dispose();
    vecesPreparadaController.dispose();
    soyPrecargadoController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorHelper.second,
      appBar: AppBar(
        backgroundColor: ColorHelper.main,
        title: const Text("Editar Café", selectionColor: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextFormField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: "Descripción"),
            ),
            TextFormField(
              controller: ingredientesController,
              decoration: const InputDecoration(labelText: "Ingredientes (uno por línea)"),
              maxLines: 5,
            ),
            TextFormField(
              controller: pasosController,
              decoration: const InputDecoration(labelText: "Pasos (uno por línea)"),
              maxLines: 5,
            ),
            TextFormField(
              controller: fechaRegistroController,
              decoration: const InputDecoration(labelText: "Fecha de Registro"),
            ),
            TextFormField(
              controller: duracionController,
              decoration: const InputDecoration(labelText: "Duración (minutos)"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: productosAsociadosController,
              decoration: const InputDecoration(labelText: "Productos Asociados"),
            ),
            TextFormField(
              controller: vecesPreparadaController,
              decoration: const InputDecoration(labelText: "Veces Preparada"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 100),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(Icons.photo, color: Colors.white),
                  label: const Text("Galería", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorHelper.fourth,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _pickImageFromCamera,
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  label: const Text("Cámara", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorHelper.fourth,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              
               
                  widget.cafe.nombre = nombreController.text;
                  widget.cafe.descripcion = descripcionController.text;
                  widget.cafe.ingredientes = ingredientesController.text.split('\n');
                  widget.cafe.pasos = pasosController.text.split('\n');
                  widget.cafe.fechaRegistro = fechaRegistroController.text;
                  widget.cafe.duracion = int.tryParse(duracionController.text) ?? 0;
                  widget.cafe.porductosAsociados = productosAsociadosController.text;
                  widget.cafe.vecesPreparada = int.tryParse(vecesPreparadaController.text) ?? 0;
                  widget.cafe.soyPrecargado = int.tryParse(soyPrecargadoController.text) ?? 0;



                if (widget.cafe.soyPrecargado != 0) {
                
                  Cafe clonedCafe = Cafe(
                    nombre: widget.cafe.nombre,
                    descripcion:   widget.cafe.descripcion,
                    ingredientes: widget.cafe.ingredientes,
                    pasos: widget.cafe.pasos,
                    fechaRegistro: widget.cafe.fechaRegistro,
                    duracion:  widget.cafe.duracion,
                    porductosAsociados: widget.cafe.porductosAsociados,
                    vecesPreparada:  widget.cafe.vecesPreparada,
                    soyPrecargado: 0, 
                    miCreador: '@default',
                    miIamagen: _selectedImage!,
                  );

                  
                  BottomBar.mainUsuario..misCafes.add(clonedCafe);
                }

               
                if (_selectedImage != null) {
                  widget.cafe.miIamagen = _selectedImage!;
                }

                
                Navigator.pop(context, widget.cafe);
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
