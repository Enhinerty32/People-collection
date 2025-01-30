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
      final  person = thisController.listPerson.value;

      // Asignar valores iniciales a los controladores
      thisController.setInitialValues(person);
    

 String? myValidartor(String? value) {
 
  }

     List<String> fields = [
        "nickname",
        "fullName",
        "gender", 
        "description",
        "mail",
        "workplace",
        "diagnosis"
        ];
   

      return Column(
        children: [
          _buildCategoryExpansionTile("Datos Generales", 
          Column(
            children: [ 
            textFormFieldMyEdit(thisController:thisController, fields:fields[0], userInfo: person.generalInformation.nickname,validartor: myValidartor,name:"Apodo" ),
            textFormFieldMyEdit(thisController:thisController, fields:fields[1], userInfo: person.generalInformation.fullName,validartor: myValidartor,name:"Nombre Completo"),
            textFormFieldMyEdit(thisController:thisController, fields:fields[2], userInfo: person.generalInformation.gender,validartor: myValidartor,name:"Genero"),
            textFormFieldMyEdit(thisController:thisController, fields:fields[3], userInfo: person.generalInformation.description,validartor: myValidartor,name:"Descripcion" ),
            textFormFieldMyEdit(thisController:thisController, fields:fields[4], userInfo: person.generalInformation.mail,validartor: myValidartor,name:"Correo Electronico"),
            textFormFieldMyEdit(thisController:thisController, fields:fields[5], userInfo: person.generalInformation.workplace,validartor: myValidartor,name:"Lugar de trabajo" ),
            ]  
          ),),
            _buildCategoryExpansionTile("Diagnostico", 
          Column(
            children: [ 
            textFormFieldMyEdit(thisController:thisController, fields:fields[6], userInfo: person.diagnosedData.diagnosis,validartor: myValidartor,name:"Diagnostico General" ),
            
            ]  
          ),),
          
          JsonView.map(person.toJson()),
        ],
      );
    } else {
      return const Center(child: Text("No hay personas registradas"));
    }
  }

    Widget _buildCategoryExpansionTile(String title, Widget child) {
    return ExpansionTile(
      title: Text(title,style: TextStyle(color: Colors.cyanAccent),),
      children: [SizedBox(width: 400,child: child)],
    );
  }


  Widget textFormFieldMyEdit({required EditPersonPageController thisController, required  String fields, required  String userInfo, required  String name,  required String? validartor(String? value)}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
                controller: thisController.textControllers[fields],
             
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText:name,
          ),
                onChanged: (value)async {
                 
   thisController.updateTextData(userInfo, value)   ;
                },
                validator:  validartor,
               
              ),
    );
  }
 
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

  void setInitialValues(ListPerson person) async{
    textControllers["fullName"]!.text = person.generalInformation.fullName;
    textControllers["description"]!.text = person.generalInformation.description;
    textControllers["nickname"]!.text = person.generalInformation.nickname;
    textControllers["mail"]!.text = person.generalInformation.mail;
    textControllers["gender"]!.text = person.generalInformation.gender;
    textControllers["workplace"]!.text = person.generalInformation.workplace;
    
    textControllers["diagnosis"]!.text = person.diagnosedData.diagnosis;
  }
  
Future <void> updateTextData(String userInfo ,value)async{
    userInfo = value;
}
 
}
