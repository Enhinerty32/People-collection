 
import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:get/get.dart';
import '../data/storage_provider.dart';
import '../models/user_model.dart';

class EditPersonPage extends StatelessWidget {
  EditPersonPage({Key? key}) : super(key: key);

  final StorageProvider<UserModel> storageProvider = Get.put(
    StorageProvider<UserModel>(
      collectionPath: "users",
      modelFactory: (json) => UserModel.fromJson(json),
    ),
  );
  final int index = Get.arguments;
  final EditPersonPageController thisController =
      Get.put(EditPersonPageController());

  @override
  Widget build(BuildContext context) {
    final Rx<UserModel?> user = storageProvider.model;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Person'),
      ),
      body: ListView(
        children: [
          editUser(user: user, index: index, thisController: thisController),
        ],
      ),
      floatingActionButton:
          SaveButton(user: user, index: index, thisController: thisController),
    );
  }

  FloatingActionButton SaveButton({
    required Rx<UserModel?> user,
    required int index,
    required EditPersonPageController thisController,
  }) {
    return FloatingActionButton(
      onPressed: () async {
        final myUser = user.value;
        if (myUser == null) {
          print('SaveButton: No se encontró el usuario');
          return;
        }
        if (myUser.listPeople.isNotEmpty) {
          myUser.listPeople[index] = thisController.listPerson.value;
          storageProvider.updateModel(myUser);
        } else {
          print('SaveButton: No se grabaron los cambios');
        }
        Get.offAndToNamed("/login");
      },
      tooltip: 'Guardar',
      child: const Icon(Icons.save),
    );
  }

  Widget editUser({
    required Rx<UserModel?> user,
    required int index,
    required EditPersonPageController thisController,
  }) {
    final myUser = user.value;
    if (myUser == null) {
      return const CircularProgressIndicator();
    }
    if (myUser.listPeople.isNotEmpty) {
      thisController.listPerson.value = myUser.listPeople[index];
      final ListPerson person = thisController.listPerson.value;

      // Asignar valores iniciales a los controladores
      thisController.setInitialValues(person);
 
      return Column(
        children: [
         _buildCategoryExpansionTile( "Datos Generales",Column(
            children: [
                TextFormFielListPeople(thisController, person,"nickname","Apodo"),
                TextFormFielListPeople(thisController, person,"fullName","Nombre Completo "),
                //edad
                TextFormFielListPeople(thisController, person,"gender","Genero"),
                //lvl de conexion
                TextFormFielListPeople(thisController, person,"description","Descripcion"),
                TextFormFielListPeople(thisController, person,"mail","Correo Electronico"),
                //tipo de sangre
                TextFormFielListPeople(thisController, person,"workplace","Lugar de Trabajo"),
                //lugares registrados 
                //Numeros de celular
                //Lenguajes
                //Historia personal
                //Link de redes sociales
                ]
          ))
          ,
          _buildCategoryExpansionTile('Diagnostico',Column(
            children: [
              //Intereses Misticos
              //Pasatiempos 
              //Preferencias Musicales
              //Intereses Cinematograficos
              //Intereses Profundos 

          ],)),
          _buildCategoryExpansionTile('Datos Psicologicos',Column(
            children: [
                //Datos MBIT
                //Datos de Enegrama

          ],))
          ,
        _buildCategoryExpansionTile('Diagnostico',Column(
          children: [
              TextFormFielListPeople(thisController, person,"diagnosis","Diagnostico General"),
              //Peso
              //Condiciones diagnosticadas 
              //Horario de sueño
              ],)),

          JsonView.map(person.toJson()),
        ],
      );
    } else {
      return const Center(child: Text("No hay personas registradas"));
    }
  }

  TextFormField TextFormFielListPeople(EditPersonPageController thisController, ListPerson person,String obj,String name) {
    return TextFormField(
              controller: thisController.textControllers[obj],
              onChanged: (value) {
                thisController.updatePersonField(person, obj, value);
              },
              decoration: InputDecoration(labelText: name),
          );
  }
}
    Widget _buildCategoryExpansionTile(String title, Widget child) {
    return ExpansionTile(
      title: Text(title,style: TextStyle(color: Colors.cyanAccent),),
      children: [SizedBox(width: 400,child: child)],
    );
  }


class EditPersonPageController extends GetxController {
  final Rx<ListPerson> listPerson = ListPerson(
    generalInformation: GeneralInformation(
      workplace: '',
      socialMedia: [],
      phones: [],
      personalHistory: [],
      nickname: '',
      mail: '',
      languagesSpoken: [],
      gender: '',
      fullName: '',
      description: '',
      connectionLevel: 0,
      closeRelationships: CloseRelationships(enemies: [], family: [], friends: []),
      bloodType: '',
      birthDate: '',
      locations: [],
    ),
    interests: Interests(
      mysticalInterests: [],
      hobbyAreas: [],
      musicalPreferences: [],
      cinematicThemes: [],
      deepInterests: [],
    ),
    touchSensitiveBody: TouchSensitiveBody(
      neck: 0, shoulder: 0, chest: 0, abdomen: 0, elbow: 0, arm: 0, hands: 0,
      thigh: 0, knee: 0, leg: 0, feet: 0, upperBack: 0, lowerBack: 0, glutes: 0,
      ear: 0, chin: 0, forehead: 0, cheek: 0, hair: 0, mouth: 0, nose: 0,
    ),
    psychologicalAnalysis: PsychologicalAnalysis(
      mbti: '',
      enneagram: Enneagram(
        perfectionist: 0, helper: 0, achiever: 0, individualist: 0,
        investigator: 0, loyalist: 0, enthusiast: 0, challenger: 0, peacemaker: 0,
      ),
      bigFive: BigFive(
        openness: [0], conscientiousness: [0], extraversion: [0],
        agreeableness: [0], neuroticism: [0],
      ),
    ),
    diagnosedData: DiagnosedData(
      weight: 0,
      sleepPattern: SleepPattern(
        wakeUp: DateTime(2000, 1, 1),
        sleepTime: DateTime(2000, 1, 1),
        sleepDuration: 0,
        energyPeak: DateTime(2000, 1, 1),
        tirednessPeak: DateTime(2000, 1, 1),
      ),
      diagnosedConditions: [],
      diagnosis: '',
      menstrualCycle: MenstrualCycle(
        start: DateTime(2000, 1, 1),
        bloodDuration: 0,
        cycleLength: 0,
      ),
    ),
  ).obs;

  final Map<String, TextEditingController> textControllers = {
    "nickname": TextEditingController(),
    "fullName": TextEditingController(),
    "gender": TextEditingController(),
    "description": TextEditingController(),
    "mail": TextEditingController(),
    "workplace": TextEditingController(),
    "diagnosis": TextEditingController(),
  };

  void setInitialValues(ListPerson person) {
    textControllers["nickname"]!.text = person.generalInformation.nickname;
    textControllers["fullName"]!.text = person.generalInformation.fullName;
    textControllers["gender"]!.text = person.generalInformation.gender;
    textControllers["description"]!.text = person.generalInformation.description;
    textControllers["mail"]!.text = person.generalInformation.mail;
    textControllers["workplace"]!.text = person.generalInformation.workplace;
    textControllers["diagnosis"]!.text = person.diagnosedData.diagnosis;
  }

  void updatePersonField(ListPerson person, String field, String value) {
    switch (field) {
      case "nickname":  person.generalInformation.nickname = value;
        break;
      case "fullName":
        person.generalInformation.fullName = value;
        break;
      case "gender":
        person.generalInformation.gender = value;
        break;
      case "description":
        person.generalInformation.description = value;
        break;
      case "mail":
        person.generalInformation.mail = value;
        break;
      case "workplace":
        person.generalInformation.workplace = value;
        break;
      case "diagnosis":
        person.diagnosedData.diagnosis = value;
        break;
    }
  }
}
