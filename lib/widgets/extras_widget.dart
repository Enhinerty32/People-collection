import 'package:flutter/material.dart';

import '../config/models/person_model.dart';

class ExtrasWidget extends StatefulWidget {
  final List<Extra> extras; // Lista de extras desde el estado
  final Function(Extra extra, int index) onExtraUpdated; // Callback para actualizar
  final Function(Extra extra) onExtraAdd; // Callback para agregar
  final Function(int index) onExtraDelete; // Callback para eliminar

  const ExtrasWidget({super.key, 
    required this.extras,
    required this.onExtraUpdated,
    required this.onExtraAdd,
    required this.onExtraDelete,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ExtrasWidgetState createState() => _ExtrasWidgetState();
}

class _ExtrasWidgetState extends State<ExtrasWidget> {
  late List<Extra> _localExtras;

  @override
  void initState() {
    super.initState();
    // Copia local de los extras para manejar los controladores
    _localExtras = List.from(widget.extras);
  }

  @override
  void didUpdateWidget(covariant ExtrasWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sincroniza la lista local cuando cambie el estado externo
    if (oldWidget.extras != widget.extras) {
      _localExtras = List.from(widget.extras);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            _buildSectionTitle('Extras'),
            Expanded(child: SizedBox()),
            IconButton(
              onPressed: () => _showAddExtraDialog(context),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        // Contenedor para la lista vertical
        Expanded(
          child: _localExtras.isEmpty
              ? Center(child: Text('No hay extras agregados'))
              : ListView.builder(
                shrinkWrap: true,
                  itemCount: _localExtras.length + 1, // +1 para añadir el SizedBox al final
                  itemBuilder: (context, index) {
                    // Si es el último índice, retorna el SizedBox
                    if (index == _localExtras.length) {
                      return SizedBox(height: 150);
                    }
                    
                    final extra = _localExtras[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                      child: ListTile(
                        title: Text(
                          extra.title.isNotEmpty ? extra.title : 'Extra',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showEditExtraDialog(context, extra, index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Confirmar antes de eliminar
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Eliminar extra'),
                                    content: Text('¿Está seguro de eliminar "${extra.title}"?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          widget.onExtraDelete(index);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Eliminar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () => _showEditExtraDialog(context, extra, index),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  void _showAddExtraDialog(BuildContext context) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Extra'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              TextFormField(
                controller: descController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final newExtra = Extra(
                  title: titleController.text,
                  description: descController.text,
                );
                widget.onExtraAdd(newExtra);
                Navigator.of(context).pop();
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  void _showEditExtraDialog(BuildContext context, Extra extra, int index) async {
    TextEditingController titleController = TextEditingController(text: extra.title);
    TextEditingController descController = TextEditingController(text: extra.description);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Extra'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              TextFormField(
                controller: descController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final updatedExtra = Extra(
                  title: titleController.text,
                  description: descController.text,
                );
                widget.onExtraUpdated(updatedExtra, index);
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}

// Ejemplo de uso
class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  List<Extra> extras = [
    Extra(title: "WiFi", description: "WiFi gratis"),
    Extra(title: "Desayuno", description: "Desayuno incluido"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejemplo de Extras')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExtrasWidget(
          extras: extras,
          onExtraUpdated: (extra, index) {
            setState(() {
              extras[index] = extra;
            });
          },
          onExtraAdd: (extra) {
            setState(() {
              extras.add(extra);
            });
          },
          onExtraDelete: (index) {
            setState(() {
              extras.removeAt(index);
            });
          },
        ),
      ),
    );
  }
}