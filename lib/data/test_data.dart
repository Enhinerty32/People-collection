import 'dart:convert';

import 'package:get/get.dart';
import 'package:people_collection/models/person_resp.dart';
import 'package:flutter/services.dart' show rootBundle;


class TestModel extends GetxController {
  var  listPeople =<PersonResp> [].obs;
  var name = ''.obs;
  var age = 0.obs;

  void updateName(String newName) {
    name.value = newName;
  }

  void updateAge(int newAge) {
    age.value = newAge;
  }

 
Future<void> loadJson() async {
  // Cargar el archivo JSON
  String jsonString = await rootBundle.loadString('lib/assets/test_json.json');

  // Parsear el JSON
  var jsonData = jsonDecode(jsonString);
  // var jsonData = jsonDecode(jsonString);

  // Usar los datos
  if (jsonData is List) {
    // print('Es una lista: ${jsonData.length}');
     listPeople.value =jsonData.map((item) => PersonResp.fromJson(item)).toList();
      

    
  } else if (jsonData is Map) {
    // print('Es un mapa: ${jsonData.keys}');
  }
}

}
        
        // if (GetxControl.listPeople.isEmpty) {
        //   return CircularProgressIndicator();
        // } else {
        //   return ListView.builder(
        //     itemCount:20, 
        //     itemBuilder: (BuildContext context, int index) {
        //       return CardViewPeopleWidget(name: "name");
        //     },
        //   );
        // }