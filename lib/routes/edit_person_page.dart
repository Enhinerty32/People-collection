import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:people_collection/widgets/text_field_save.dart';

import '../models/user_model.dart';
import '../widgets/action_deploy_widget.dart';

class EditPersonPage extends StatelessWidget {
  const EditPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thisController = Get.put(EditPersonPageController());
    final ListPerson? person = Get.arguments;
    double sizeSpace = 8;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Person'),
      ),
      body: ListView(
        children: [
          ActionDeployWidget(
            boolCtx: thisController.bool_name_controller,
            textTitle: Text('asdf'),
            deployWidget: Text("data"),
          ),
          TextFieldSave(
            function: () => print('activado'),
            boolController: thisController.bool_name_controller,
            stringController: thisController.text_name_controller,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
          // Get.toNamed("/home");
        },
        tooltip: 'Comeback',
        child: const Icon(Icons.save),
      ),
    );
  }
}

class EditPersonPageController extends GetxController {
  final text_name_controller = 'Hola'.obs;
  final bool_name_controller = false.obs;
}
