import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MaterialesPage extends StatefulWidget {
  final List<Map<String, dynamic>> materialesSeleccionados;
  final Function(String, int, double, String) onMaterialAdded;
  final Function(int) onMaterialRemoved;
  final Function(int, String, int, double, String) onMaterialEdited;

  MaterialesPage({
    required this.materialesSeleccionados,
    required this.onMaterialAdded,
    required this.onMaterialRemoved,
    required this.onMaterialEdited,
  });

  @override
  _MaterialesPageState createState() => _MaterialesPageState();
}

class _MaterialesPageState extends State<MaterialesPage> {
  String? selectedTrabajo;
  List<String> trabajosDisponibles = ['Trabajo Fitness', 'Trabajo Altisimo', 'Trabajo Calimocho'];

  List<Map<String, dynamic>> materialesDisponibles = [
    // Tuberías y conexiones
    {'nombre': 'Tubo PVC 1/2" x 3m', 'seleccionado': false, 'cantidad': 1, 'precio': 3.50},
    {'nombre': 'Tubo PVC 3/4" x 3m', 'seleccionado': false, 'cantidad': 1, 'precio': 5.00},
    {'nombre': 'Tubo CPVC 1/2" x 3m', 'seleccionado': false, 'cantidad': 1, 'precio': 6.00},
    {'nombre': 'Codo PVC 90° 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 0.80},
    {'nombre': 'Codo PVC 90° 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.00},
    {'nombre': 'Codo CPVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.50},
    {'nombre': 'Tee PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.20},
    {'nombre': 'Tee PVC 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.50},
    {'nombre': 'Reducción PVC 3/4" a 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 1.00},
    {'nombre': 'Adaptador macho PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 0.90},
    {'nombre': 'Adaptador hembra PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 0.90},
    {'nombre': 'Rosca macho metálica 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 2.50},
    {'nombre': 'Rosca hembra metálica 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 2.50},
    // Llaves y válvulas
    {'nombre': 'Llave de paso PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 5.00},
    {'nombre': 'Llave de paso PVC 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 7.00},
    {'nombre': 'Válvula de retención PVC 1/2"', 'seleccionado': false, 'cantidad': 1, 'precio': 8.00},
    {'nombre': 'Válvula de retención PVC 3/4"', 'seleccionado': false, 'cantidad': 1, 'precio': 10.00},
    // Accesorios para instalaciones
    {'nombre': 'Cinta teflón 10m', 'seleccionado': false, 'cantidad': 1, 'precio': 1.50},
    {'nombre': 'Sellador de roscas líquido 50ml', 'seleccionado': false, 'cantidad': 1, 'precio': 4.00},
    {'nombre': 'Cemento PVC 250ml', 'seleccionado': false, 'cantidad': 1, 'precio': 3.50},
    {'nombre': 'Cemento CPVC 250ml', 'seleccionado': false, 'cantidad': 1, 'precio': 5.00},
    {'nombre': 'Abrazadera metálica 1/2" (paquete de 10)', 'seleccionado': false, 'cantidad': 1, 'precio': 6.00},
    {'nombre': 'Abrazadera metálica 3/4" (paquete de 10)', 'seleccionado': false, 'cantidad': 1, 'precio': 7.00},
    // Mangueras y conexiones flexibles
    {'nombre': 'Manguera para lavamanos 1/2" x 40cm', 'seleccionado': false, 'cantidad': 1, 'precio': 3.50},
    {'nombre': 'Manguera para inodoro 1/2" x 50cm', 'seleccionado': false, 'cantidad': 1, 'precio': 4.00},
    {'nombre': 'Manguera flexible para calentador 3/4" x 60cm', 'seleccionado': false, 'cantidad': 1, 'precio': 10.00},
    // Grifería y desagües
    {'nombre': 'Llave mezcladora para lavamanos', 'seleccionado': false, 'cantidad': 1, 'precio': 20.00},
    {'nombre': 'Llave mezcladora para fregadero', 'seleccionado': false, 'cantidad': 1, 'precio': 30.00},
    {'nombre': 'Desagüe para lavamanos con tapón automático', 'seleccionado': false, 'cantidad': 1, 'precio': 10.00},
    {'nombre': 'Sifón flexible PVC 1 1/2" para lavamanos', 'seleccionado': false, 'cantidad': 1, 'precio': 7.00},
    {'nombre': 'Sifón flexible PVC 1 1/2" para fregadero', 'seleccionado': false, 'cantidad': 1, 'precio': 9.00},
    // Tanques y bombas
    {'nombre': 'Tanque de agua plástico 200 galones', 'seleccionado': false, 'cantidad': 1, 'precio': 150.00},
    {'nombre': 'Bomba de agua 1/2 HP', 'seleccionado': false, 'cantidad': 1, 'precio': 120.00},
    {'nombre': 'Bomba sumergible para drenaje', 'seleccionado': false, 'cantidad': 1, 'precio': 180.00},
  ];

  void _showEditDialog(BuildContext context, int index) {
    final material = widget.materialesSeleccionados[index];
    String nombre = material['material'];
    int cantidad = material['cantidad'];
    double precio = material['precio'];
    String trabajo = material['trabajo'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Material'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Nombre'),
                    controller: TextEditingController(text: nombre),
                    onChanged: (value) => nombre = value,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Cantidad'),
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: cantidad.toString()),
                    onChanged: (value) => cantidad = int.tryParse(value) ?? cantidad,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Precio'),
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: precio.toString()),
                    onChanged: (value) => precio = double.tryParse(value) ?? precio,
                  ),
                  DropdownButton<String>(
                    value: trabajo,
                    hint: Text("Selecciona un trabajo"),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setStateDialog(() {
                        if (newValue != null) {
                          trabajo = newValue;
                        }
                      });
                    },
                    items: trabajosDisponibles.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                widget.onMaterialEdited(index, nombre, cantidad, precio, trabajo);
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _agregarMaterialesSeleccionados() {
    if (selectedTrabajo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecciona un trabajo primero.')),
      );
      return;
    }
    for (var material in materialesDisponibles) {
      if (material['seleccionado'] && material['cantidad'] > 0) {
        widget.onMaterialAdded(
          material['nombre'],
          material['cantidad'],
          material['precio'],
          selectedTrabajo!,
        );
        setState(() {
          material['seleccionado'] = false;
          material['cantidad'] = 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Selecciona un Trabajo"),
          DropdownButton<String>(
            value: selectedTrabajo,
            hint: Text("Seleccionar"),
            isExpanded: true,
            onChanged: (String? newValue) {
              setState(() {
                selectedTrabajo = newValue;
              });
            },
            items: trabajosDisponibles.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
          ),
          SizedBox(height: 20),
          Text("Selecciona Materiales:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: materialesDisponibles.length,
              itemBuilder: (context, index) {
                final material = materialesDisponibles[index];
                return Row(
                  children: [
                    Checkbox(
                      value: material['seleccionado'],
                      onChanged: (bool? value) {
                        setState(() {
                          material['seleccionado'] = value ?? false;
                        });
                      },
                    ),
                    Expanded(child: Text(material['nombre'])),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Precio'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          material['precio'] = double.tryParse(value) ?? material['precio'];
                        },
                        controller: TextEditingController(text: material['precio'].toString()),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Cantidad'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          material['cantidad'] = int.tryParse(value) ?? material['cantidad'];
                        },
                        controller: TextEditingController(text: material['cantidad'].toString()),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _agregarMaterialesSeleccionados,
            child: Text("Agregar Materiales Seleccionados"),
          ),
          SizedBox(height: 20),
          Text("Materiales Agregados:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: widget.materialesSeleccionados.length,
              itemBuilder: (context, index) {
                final material = widget.materialesSeleccionados[index];
                return ListTile(
                  title: Text("${material['trabajo']} - ${material['material']}"),
                  subtitle: Text("Cant: ${material['cantidad']} - Precio: \$${material['precio']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showEditDialog(context, index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => widget.onMaterialRemoved(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
