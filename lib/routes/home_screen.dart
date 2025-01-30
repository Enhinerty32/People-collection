import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:get/get.dart';
import 'package:people_collection/routes/_routes.dart';
import '../data/storage_provider.dart';
import '../auth/widgets/text_button_sign_out_widget.dart';
import '../models/user_model.dart';
import '../widgets/card_view_people_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  //Nuestro model es UserModel puedes implementar cualquier otro y la collecion y las reglas en firestore deben estar
  final StorageProvider<UserModel> storageProvider = Get.put(
    StorageProvider<UserModel>(
      collectionPath: "users",
      modelFactory: (json) => UserModel.fromJson(json),
    ),
  );
  
  final TextEditingController _textAddPerson = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Rx<UserModel?> user = storageProvider.model;

    final myUserVoid =
UserModel(id: '', name: '', email: '', phone: '', listPeople: [
ListPerson(
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
    locations: []
  ),
  interests: Interests(
    mysticalInterests: [],
    hobbyAreas: [],
    musicalPreferences: [],
    cinematicThemes: [],
    deepInterests: []
  ),
  touchSensitiveBody: TouchSensitiveBody(
    neck: 0,
    shoulder: 0,
    chest: 0,
    abdomen: 0,
    elbow: 0,
    arm: 0,
    hands: 0,
    thigh: 0,
    knee: 0,
    leg: 0,
    feet: 0,
    upperBack: 0,
    lowerBack: 0,
    glutes: 0,
    ear: 0,
    chin: 0,
    forehead: 0,
    cheek: 0,
    hair: 0,
    mouth: 0,
    nose: 0
  ),
  psychologicalAnalysis: PsychologicalAnalysis(
    mbti: '',
    enneagram: Enneagram(
      perfectionist: 0,
      helper: 0,
      achiever: 0,
      individualist: 0,
      investigator: 0,
      loyalist: 0,
      enthusiast: 0,
      challenger: 0,
      peacemaker: 0
    ),
    bigFive: BigFive(
      openness: [0],
      conscientiousness: [0],
      extraversion: [0],
      agreeableness: [0],
      neuroticism: [0]
    )
  ),
  diagnosedData: DiagnosedData(
    weight: 0,
    sleepPattern: SleepPattern(
      wakeUp: DateTime(2000, 1, 1),
      sleepTime: DateTime(2000, 1, 1),
      sleepDuration: 0,
      energyPeak: DateTime(2000, 1, 1),
      tirednessPeak: DateTime(2000, 1, 1)
    ),
    diagnosedConditions: [],
    diagnosis: '',
    menstrualCycle: MenstrualCycle(
      start: DateTime(2000, 1, 1),
      bloodDuration: 0,
      cycleLength: 0
    )
  )
)
])
;
    final newPerson = myUserVoid.listPeople.first;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("People Colletion"),
        actions: [IconButton(onPressed: (){
          Get.toNamed('/chat');
        }, icon:Icon(Icons.chat))],
      ),
      drawer: InfoDrawer(user: user, person: newPerson),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Center(
                child: listCard(user: user),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: add_person(context, user, newPerson),
    );
  }

  FloatingActionButton add_person(
      BuildContext context, Rx<UserModel?> user, ListPerson newPerson) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text('Ingresa el nombre de la nueva persona '),
              actions: [
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: "Nombre Completo"),
                      controller: _textAddPerson,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            if (user.value != null) {
                              newPerson.generalInformation.fullName =
                                  _textAddPerson.text;
                              user.value!.listPeople.add(newPerson);
                              storageProvider.updateModel(user.value!);
                              _textAddPerson.text = '';
                              Get.back();
                            }
                          },
                          child: Text('Agregar'),
                        ),
                        Expanded(child: SizedBox()),
                        TextButton(
                          onPressed: () {
                            Get.back(); // Cerrar el diálogo sin confirmar
                          },
                          child: Text('Cancelar',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    )
                  ],
                ),
              ]),
        );
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }

  Obx listCard({required Rx<UserModel?> user}) {
    return Obx(() {
      final myuser = user.value;
      if (myuser == null) {
        return CircularProgressIndicator();
      } else if (myuser.listPeople.isNotEmpty) {
        return Column(
          children: [
            // JsonView.map(myuser.toJson()),
            ListView.builder(
              shrinkWrap: true, // Importante para que se ajuste al contenido
              physics:
                  NeverScrollableScrollPhysics(), // Evita conflictos con el ScrollView externo

              itemCount: myuser.listPeople.length,
              itemBuilder: (BuildContext context, int index) {
                final ListPerson person = myuser.listPeople[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.5),
                  child: CardViewPeopleWidget(
                    index: index,
                    
                    person: person,
                    deleteButton: () async {
                      
                      myuser.listPeople.removeAt(index);
                      storageProvider.updateModel(myuser);
                      Get.back(); // Cerrar el diálogo sin confirmar
                    },
                  ),
                );
              },
            ),
          ],
        );
      } else {
        return Center(child: Text("No hay personas registradas"));
      }
    });
  }

  Obx InfoDrawer({required Rx<UserModel?> user, required ListPerson person}) {
    return Obx(() {
      final myuser = user.value;
      if (myuser == null) {
        return CircularProgressIndicator.adaptive();
      } else {
        return Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: SizedBox(height: 1)),
              Text("++      My id:   ${myuser.id}"),
              Text("++      My email:${myuser.email}"),
              Text("++      My name: ${myuser.name}"),
              Text("++      My phone: ${myuser.phone}"),
              TextButton(
                onPressed: () async {
                  if (user.value != null && user.value!.listPeople.isNotEmpty) {
                    user.value!.listPeople.removeAt(0);
                    storageProvider.updateModel(user.value!);
                  }
                },
                child: Text("Remove Person"),
              ),
              Expanded(child: SizedBox(height: 1)),
              TextButtonSignOut()
            ],
          ),
        );
      }
    });
  }
}
