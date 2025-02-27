import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/models/person_model.dart';

class ViewPersonScreen extends StatelessWidget {
  const ViewPersonScreen({super.key, required this.person});
  final Person person;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.nick),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 9,
                children: [
                  CircleAvatar(
                    maxRadius: 50,
                    backgroundImage: NetworkImage(
                        'https://datepsychology.com/wp-content/uploads/2022/09/gigachad.jpg'),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Apodo : ${person.nick}'),
                        Text('Nombre : ${person.name}'),
                        Text('Sexo : ${person.gender}'),
                        Text('Edad : ${person.birthdate}'),
                        Text('Fecha de nacimiento : ${person.birthdate}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Text('Descripcion'),
            Text('${person.description}'),
            Divider(),
            Text('Numero de celular'),
            Text('${person.phone}'),
            Divider(),
            Text('Redes Sociales'),
            _buildListSocialNet(),
            Divider(),
            Text('Datos adicionales'),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: person.extras.length,
                itemBuilder: (context, index) {
                  final Extra extra = person.extras[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment
                              .centerLeft, // Alinea el texto a la izquierda
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                extra.title,
                                maxLines: 4,
                              ),
                              content: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Text(extra.description)),
                            ),
                          );
                        },
                        child: Text('${extra.title}', maxLines: 4)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildListSocialNet() {
    return SizedBox(
            height: 50, // Ajusta según lo que necesites
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: person.socialNet.length,
              itemBuilder: (context, index) {
                return Tooltip(
                  showDuration:Duration(seconds: 8) ,
                  message: person.socialNet[index],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: person.socialNet[index]));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color.fromARGB(255, 163,
                                  254, 166),  
                              content: Row(
                                children: [
                                  Text('Copiado:  '),
                                  Text(
                                    '${person.socialNet[index]}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        },
                        icon: Icon(Icons.link)),
                  ),
                );
              },
            ),
          );
  }
}
