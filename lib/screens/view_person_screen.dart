import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/models/person_model.dart';
import '../config/services/config_services.dart';

class ViewPersonScreen extends StatelessWidget {
  const ViewPersonScreen({super.key, required this.person});
  final Person person;

  @override
  Widget build(BuildContext context) {
    final Color colorr = Colors.purple;
    return Scaffold(
      appBar: AppBar(
        title: Text(person.nick, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: colorr,
        elevation: 0,
        actions: [IconButton(onPressed:()=> copyView(context,person), icon:Icon(Icons.copy))],
      ),
      resizeToAvoidBottomInset: true, // Asegura que el contenido se ajuste al teclado
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0, // Ajusta el padding inferior
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nombre: ${person.name}', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Sexo: ${person.gender}', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Edad: ${ConfigServices().calculateAge(person.birthdate)}', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Fecha de nacimiento: ${ConfigServices().formatDate(DateTime.parse(person.birthdate))}', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Descripción', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(person.description, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Número de celular', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(person.phone, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Redes Sociales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    _buildListSocialNet(colorr, context),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Datos adicionales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    _buildExtrasList(colorr),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
String createProfileString(Person person) {
  // Crear un StringBuffer para construir el perfil
  StringBuffer profile = StringBuffer();

  // Agregar los datos básicos 
  profile.writeln('Nick: ${person.nick}');
  profile.writeln('Name: ${person.name}');
  profile.writeln('Age: ${ConfigServices().calculateAge(person.birthdate)}');
  profile.writeln('Birthdate: ${ConfigServices().formatDate(DateTime.parse(person.birthdate))}');
  profile.writeln('Description: ${person.description}');
  profile.writeln('Gender: ${person.gender}');
  profile.writeln('Phone: ${person.phone}');

  // Agregar las redes sociales
  profile.writeln('Social Networks:');
  for (var network in person.socialNet) {
    profile.writeln('- $network');
  }

  // Agregar los extras
  profile.writeln('Extras:');
  for (var extra in person.extras) {
    profile.writeln('- ${extra.title}: \n${extra.description}');
  }

  // Convertir el StringBuffer a String y retornarlo
  return profile.toString();
}

  void copyView(BuildContext context,Person person) {
    String copyString =createProfileString(person);
           Clipboard.setData(ClipboardData(text:copyString ));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color.fromARGB(255, 163, 254, 166),
                  content: Row(
                    children: [
                      Text('Perfil Copiado:',
                        style: TextStyle(fontSize: 18)),
                      Text(
                       person.nick,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
  }

  Widget _buildListSocialNet(Color colorr, BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: person.socialNet.map((social) {
        return Tooltip(
          message: social,
          child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: social));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color.fromARGB(255, 163, 254, 166),
                  content: Row(
                    children: [
                      Text('Copiado:  '),
                      Text(
                        social,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: Chip(
              label: Text(''),
              avatar: Icon(Icons.link, color: Colors.white),
              backgroundColor: colorr,
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExtrasList(Color colorr) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: person.extras.length,
      itemBuilder: (context, index) {
        final Extra extra = person.extras[index];
        return Card(
          shadowColor: colorr,
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(extra.title, style: TextStyle(fontSize: 16)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(extra.title, style: TextStyle(fontWeight: FontWeight.bold)),
                  content: SingleChildScrollView(
                    child: Text(extra.description, style: TextStyle(fontSize: 16)),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cerrar', style: TextStyle(color: Colors.blueAccent)),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}