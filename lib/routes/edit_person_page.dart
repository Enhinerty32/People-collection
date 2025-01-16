import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:people_collection/data/update_profile_data.dart';
import 'package:people_collection/models/person_resp.dart';
import 'package:people_collection/widgets/text_field_save.dart';

import '../widgets/action_deploy_widget.dart';

class EditPersonPage extends StatelessWidget {
  const EditPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(UpdateProfileController());
    final PersonResp? person = Get.arguments;
    double sizeSpace = 8;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Person'),
      ),
      body: ListView(
        children: [ActionDeployWidget(boolCtx: profileController.bool_name_controller,textTitle: Text('asdf'),deployWidget: Text("data"),),
          TextFieldSave(function: ()=>print('activado'),
            boolController: profileController.bool_name_controller,
            stringController: profileController.text_name_controller,
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
