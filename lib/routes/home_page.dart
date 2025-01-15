import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:people_collection/models/person_resp.dart';
import 'package:people_collection/routes/new_person_page.dart';
import 'package:people_collection/widgets/_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final TestModel GetxControl = Get.put(TestModel());


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Aqui va el buscador"),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Text("${index}");
          },
        ),
      ),
      body: Center(
        child: listCard(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          Get.to(NewPersonPage(),
              transition: Transition.leftToRightWithFade);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget listCard() {
 
    
       return ListView.builder(
            itemCount:20, 
            itemBuilder: (BuildContext context, int index) {
              return CardViewPeopleWidget(person: null,);
            },
          );
        
        
        
        
 
    
  }
}
