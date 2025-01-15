import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:people_collection/models/person_resp.dart';
import 'package:people_collection/routes/_routes.dart';
import 'package:people_collection/services/view_person_page_settings.dart';

import '../widgets/_widgets.dart';

class ViewPersonPage extends StatelessWidget {
  const ViewPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewPersonSettings = Get.put(ViewPersonPageSettings());
    final PersonResp? person = Get.arguments;

    double sizeSpace = 8;
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                Text(
                  "fullName: Maria antonieta  ",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          body: ListView(
            children: [
              showProfile(sizeSpace),
              Container(margin: EdgeInsets.all(10), 
                child: Column(
                  children: [
                    actionDeployWidget(
                        textTittle: Text('general_information '),
                        deployWidget: deployGeneralInfo(),
                        boolCtx: viewPersonSettings
                            .general_information_deplegate_value),
                    actionDeployWidget(
                        textTittle: Text('interests'),
                        deployWidget: Text('Desplegado'),
                        boolCtx: viewPersonSettings.interest_deplegate_value),
                    actionDeployWidget(
                        textTittle: Text('touch_sensitive_body'),
                        deployWidget: Text('Desplegado'),
                        boolCtx: viewPersonSettings
                            .touch_sensitive_body_deplegate_value),
                    actionDeployWidget(
                        textTittle: Text('psychological_analysis'),
                        deployWidget: Text('Desplegado'),
                        boolCtx: viewPersonSettings
                            .psychological_analysis_deplegate_value),
                    actionDeployWidget(
                        textTittle: Text('diagnosed_data'),
                        deployWidget: Text('Desplegado'),
                        boolCtx: viewPersonSettings
                            .diagnosed_data_deplegate_value),
                    actionDeployWidget(
                        textTittle: Text('contact_about'),
                        deployWidget: Text('Desplegado'),
                        boolCtx: viewPersonSettings
                            .contact_about_deplegate_value),
                  ],
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(EditPersonPage(),
                  arguments: person, transition: Transition.cupertino);
            },
            tooltip: 'Comeback',
            child: const Icon(Icons.edit),
          ),
        ));
  }

  Row showProfile(double sizeSpace) {
    return Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://preview.redd.it/l0m6jy5zqwxa1.png?width=640&crop=smart&auto=webp&s=c011ad1e3fcf666ade161a3a48ff6419fb944882'),
                ),
                Container(
                  width: 250,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Desplegar en produccion
                      // Text("Nickname: ${myInfo.nickname}"),
                      // Text("Full Name: ${myInfo.fullName}"),
                      // Text("Age: ${calculateAge("2012-02-27")} "),
                      // Text("Gender: ${myInfo.gender}"),
                      // Text("Connection Level: ${myInfo.connectionLevel}"),
                      Text(
                        "Nickname: Capilla",
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: sizeSpace,
                      ),
                      Text(
                        "Age:  24} ",
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: sizeSpace,
                      ),
                      Text(
                        "Gender: mujer",
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: sizeSpace,
                      ),
                      Text(
                        "Connection Lvl: - - - - - 0 - - - -",
                      ),
                    ],
                  ),
                ),
              ],
            );
  }

  Widget deployGeneralInfo() {return Text('Desplegado');}

 
}
