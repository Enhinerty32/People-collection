import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/router/app_router_auth.dart';
import '../config/models/person_model.dart';
import '../config/services/config_services.dart';
import '../provider/get_show_db_provider.dart';

class CardPersonWidget extends ConsumerWidget {
  const CardPersonWidget(  { super.key, required this.person});
  final Person person;
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    return GestureDetector(
      onTap: () => ref
          .read(appPrincipalRouterProvider)
          .push('/viewPerson', extra: person),
      child: Card(
        elevation: 4, // Sombra para dar profundidad
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // CircleAvatar para la imagen de perfil

              const SizedBox(
                  width: 16), // Espaciado entre el avatar y el contenido
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      person.nick,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Nombre: ${person.name}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sexo: ${person.gender}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Edad: ${ConfigServices().calculateAge(person.birthdate)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Fecha de nacimiento: ${ConfigServices().formatDate(DateTime.parse(person.birthdate))}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              // Menú contextual para editar y eliminar
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'edit') {
                    ref
                        .read(appPrincipalRouterProvider)
                        .push('/editPerson', extra: person);
                  } else if (value == 'delete') {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('¿Está seguro de eliminarlo?'),
                        content: Text(person.nick),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              _deletePerson(ref, person.id);
                              Navigator.pop(context);
                            },
                            child: Text('Eliminar'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Editar'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Eliminar'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para eliminar una persona
  void _deletePerson(WidgetRef ref, String? id) {
    if (id == null) {
      // print('No hay ID en la eliminación');
      return;
    }
    ref.read(peopledbProvider.notifier).removePerson(id);
  }
}
