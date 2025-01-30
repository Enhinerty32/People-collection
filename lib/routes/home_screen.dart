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
      workplace: 'Oceanic Innovations Institute',
      socialMedia: ['@deepsea_voyager', '@hydro_technologist'],
      phones: ['+1 305 555 9876', '+44 20 7946 1234'],
      personalHistory: [
        PersonalHistory(
          title: 'Expedición al Abismo Challenger',
          history: 'Lideró un equipo de investigación en la fosa más profunda del océano (2026)'
        ),
        PersonalHistory(
          title: 'Descubrimiento de criaturas bioluminiscentes',
          history: 'Descubrió nuevas especies marinas adaptadas a la oscuridad total a más de 10,000 metros de profundidad'
        )
      ],
      nickname: 'Tide',
      mail: 'sea.researcher@oceanicinnovations.com',
      languagesSpoken: ['Inglés', 'Francés', 'Lengua de Signos Submarina'],
      gender: 'No binario',
      fullName: 'Kai Oceanus Abyssal',
      description: 'Investigador marino y líder en biotecnología acuática',
      connectionLevel: 9,
      closeRelationships: CloseRelationships(
        enemies: ['Corporación DeepWell'],
        family: ['Dr. Talia Abyss (madre)', 'Nautilus Deep (hermanx)'],
        friends: ['Prof. Triton Wave', 'Captain Coral Reef']
      ),
      bloodType: 'O-',
      birthDate: '1995-11-11',
      locations: [
        Location(
          namePlace: 'Centro de Investigación Submarina Neptuno', 
          description: 'Centro de estudios sobre vida marina y ecosistemas abisales', 
          place: Place(lat: -22.9916, lng: -122.0002)  // Coordenadas cerca del Abismo Challenger
        ),
        Location(
          namePlace: 'Laboratorio de Bioluminiscencia Profunda', 
          description: 'Laboratorio flotante en el océano Pacífico para investigación biológica', 
          place: Place(lat: -5.2500, lng: -80.5000)  // Coordinadas en el Océano Pacífico
        )
      ]
    ),
    
    interests: Interests(
      mysticalInterests: ['Energías de las corrientes oceánicas', 'Cultura marina ancestral'],
      hobbyAreas: ['Fotografía subacuática', 'Estudio de géiseres hidrotermales'],
      musicalPreferences: ['Música ambiental marina', 'Sonidos de ballenas'],
      cinematicThemes: ['Cine documental de exploración marina', 'Películas sobre la vida en las profundidades'],
      deepInterests: ['Ecología marina', 'Tecnologías para la preservación de los océanos']
    ),
    
    touchSensitiveBody: TouchSensitiveBody(
      neck: 4,
      shoulder: 3,
      chest: 2,
      abdomen: 4,
      elbow: 2,
      arm: 3,
      hands: 6,  // Alta sensibilidad táctil por trabajo en ambientes acuáticos
      thigh: 3,
      knee: 4,   // Lesión en expedición submarina
      leg: 4,
      feet: 5,   // Adaptación al uso prolongado de aletas
      upperBack: 2,
      lowerBack: 3,
      glutes: 2,
      ear: 8,    // Alta sensibilidad auditiva en ambientes subacuáticos
      chin: 1,
      forehead: 3,
      cheek: 4,
      hair: 0,   // Cabeza afeitada para mejor ajuste de equipo
      mouth: 5,
      nose: 7    // Adaptación al olfato de compuestos marinos
    ),
    
    psychologicalAnalysis: PsychologicalAnalysis(
      mbti: 'INTP-A',
      enneagram: Enneagram(
        perfectionist: 7.5,
        helper: 5.5,
        achiever: 6.5,
        individualist: 8,
        investigator: 10,
        loyalist: 3,
        enthusiast: 4,
        challenger: 6,
        peacemaker: 5
      ),
      bigFive: BigFive(
        openness: [93],
        conscientiousness: [81],
        extraversion: [42],
        agreeableness: [67],
        neuroticism: [27]
      )
    ),
    
    diagnosedData: DiagnosedData(
      weight: 68,
      sleepPattern: SleepPattern(
        wakeUp: DateTime(2024, 4, 15, 6, 30),
        sleepTime: DateTime(2024, 4, 15, 22, 0),
        sleepDuration: 8,
        energyPeak: DateTime(2024, 4, 15, 7, 30),
        tirednessPeak: DateTime(2024, 4, 15, 15, 0)
      ),
      diagnosedConditions: ['Sensibilidad extrema al movimiento en agua', 'Estrés por privación de luz'],
      diagnosis: 'Adaptación psicológica a entornos de oscuridad constante',
      menstrualCycle: MenstrualCycle(
        start: DateTime(2024, 4, 1),
        bloodDuration: 6,
        cycleLength: 30
      )
    )
  )
])

;
    final newPerson = myUserVoid.listPeople.first;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Home Screen"),
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
                return CardViewPeopleWidget(
                  
                  person: person,
                  deleteButton: () async {
                    
                    myuser.listPeople.removeAt(index);
                    storageProvider.updateModel(myuser);
                    Get.back(); // Cerrar el diálogo sin confirmar
                  },
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
