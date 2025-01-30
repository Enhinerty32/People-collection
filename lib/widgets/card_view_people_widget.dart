import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:people_collection/models/user_model.dart';
import 'package:people_collection/routes/view_person_page.dart';

import '../data/storage_provider.dart';

class CardViewPeopleWidget extends StatelessWidget {
  const CardViewPeopleWidget(
      {required this.deleteButton, required this.person, required this.index,   });
final int index;
  final void Function()? deleteButton;
  final ListPerson person;
  

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    double sizeSpace = 5;
    final myInfo = person.generalInformation;

    return GestureDetector(
      onTap: () {
        Get.to(ViewPersonPage(),
            arguments: person, transition: Transition.leftToRightWithFade);
      },
      child: Stack(
        children: [
          Card(
            child: Row(
              children: [SizedBox(width: 10,),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://preview.redd.it/l0m6jy5zqwxa1.png?width=640&crop=smart&auto=webp&s=c011ad1e3fcf666ade161a3a48ff6419fb944882'),
                ),
                Container(
                  width: query.size.width * 0.5,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apodo: ${myInfo.nickname.isEmpty ? '--' : myInfo.nickname}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: sizeSpace),
                      Text(
                        "Nombre : ${myInfo.fullName}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: sizeSpace),
                      Text(
                        "Edad: ${myInfo.birthDate.isEmpty ? '--' : myInfo.birthDate} ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: sizeSpace),
                      Text(
                        "Género: ${myInfo.gender.isEmpty ? '--' : myInfo.gender}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: sizeSpace),
                      Text(
                        "Connection Level: ${myInfo.connectionLevel}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: sizeSpace),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text('¿Estás seguro de que quieres eliminar ha?'),
                      content: Text(
                        "${myInfo.fullName}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 20, color: Colors.lightBlue),
                      ),
                      actions: [Row(children: [ TextButton(
                          onPressed: deleteButton,
                          child: Text('Eliminar'),
                        ),Expanded(child: SizedBox()),
                        TextButton(
                            onPressed: () {
                              // Cerrar el diálogo sin confirmar
                              Get.back();
                            },
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.red),
                            ))],)
                        
                      ]),
                );
              },
              icon: Icon(Icons.delete),
            ),
          ),
             Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Get.toNamed("/editPerson",arguments: index);
              },
              icon: Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }
}
