import 'package:flutter/material.dart';

class SocialNetWidget extends StatefulWidget {
  final List<String> socialNetLinks; // Lista de enlaces desde el estado
  final Function(String link, int index) onLinkUpdated; // Callback para actualizar el estado
  final Function(String link) onLinkAdd; // Callback para agregar un nuevo enlace
  final Function(int index) onLinkDelete; // Callback para eliminar un enlace

  const SocialNetWidget({super.key, 
    required this.socialNetLinks,
    required this.onLinkUpdated,
    required this.onLinkAdd,
    required this.onLinkDelete,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SocialNetWidgetState createState() => _SocialNetWidgetState();
}

class _SocialNetWidgetState extends State<SocialNetWidget> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los valores iniciales del estado
    _controllers = widget.socialNetLinks
        .map((link) => TextEditingController(text: link))
        .toList();
  }

  @override
  void didUpdateWidget(covariant SocialNetWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Sincroniza los controladores con el estado cuando cambie
    if (oldWidget.socialNetLinks != widget.socialNetLinks) {
      // Si la lista ha crecido, agrega nuevos controladores
      if (widget.socialNetLinks.length > _controllers.length) {
        for (int i = _controllers.length; i < widget.socialNetLinks.length; i++) {
          _controllers.add(TextEditingController(text: widget.socialNetLinks[i]));
        }
      }
      // Si la lista ha disminuido, elimina los controladores sobrantes
      else if (widget.socialNetLinks.length < _controllers.length) {
        for (int i = _controllers.length - 1; i >= widget.socialNetLinks.length; i--) {
          _controllers[i].dispose();
          _controllers.removeAt(i);
        }
      }
      // Actualiza los valores de los controladores existentes
      for (int i = 0; i < widget.socialNetLinks.length; i++) {
        _controllers[i].text = widget.socialNetLinks[i];
      }
    }
  }

  @override
  void dispose() {
    // Limpia los controladores cuando el widget se destruya
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildSectionTitle('Redes Sociales'),
            Expanded(child: SizedBox()),
            IconButton(
              onPressed: () async {
                TextEditingController dialogController = TextEditingController();

                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Creando'),
                      content: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: TextFormField(
                          controller: dialogController,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Edita link',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Cerrar el diálogo sin guardar
                          },
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Agrega el estado con el nuevo valor
                            widget.onLinkAdd(dialogController.text);
                            Navigator.of(context).pop(); // Cerrar el diálogo después de guardar
                          },
                          child: Text('Agregar'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        SizedBox(
          height: 50, // Ajusta según lo que necesites
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _controllers.length,
            itemBuilder: (context, index) {
              final controller = _controllers[index];
              return Tooltip(
                key: ValueKey(controller.hashCode), // Clave única basada en el controlador
                showDuration: Duration(seconds: 8),
                message: controller.text,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Icon(Icons.link),
                    onPressed: () async {
                      TextEditingController dialogController =
                          TextEditingController(text: controller.text);

                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            key: ValueKey(controller.hashCode), // Clave única para el diálogo
                            title: Row(
                              children: [
                                Text('Editar'),
                                Expanded(child: SizedBox()),
                                IconButton(
                                  onPressed: () {
                                    // Elimina el estado con el nuevo valor
                                    widget.onLinkDelete(index);
                                    Navigator.of(context).pop(); // Cerrar el diálogo después de guardar
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: const Color.fromARGB(255, 253, 143, 135),
                                  ),
                                ),
                              ],
                            ),
                            content: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: TextFormField(
                                controller: dialogController,
                                maxLines: null,
                                decoration: InputDecoration(
                                  labelText: 'Edita link',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Cerrar el diálogo sin guardar
                                },
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Actualiza el estado con el nuevo valor
                                  widget.onLinkUpdated(dialogController.text, index);
                                  Navigator.of(context).pop(); // Cerrar el diálogo después de guardar
                                },
                                child: Text('Guardar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
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
}