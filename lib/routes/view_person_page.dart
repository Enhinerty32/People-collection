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
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    actionDeployWidget(
                        textTittle: Text('general_information '),
                        deployWidget: deployGeneralInfo(person: person),
                        boolCtx: viewPersonSettings
                            .general_information_deplegate_value),
                    actionDeployWidget(
                        textTittle: Text('interests'),
                        deployWidget: deployInterests(),
                        boolCtx: viewPersonSettings.interest_deplegate_value),
                    actionDeployWidget(
                        textTittle: Text('touch_sensitive_body'),
                        deployWidget: deployTouchSensitveBody(),
                        boolCtx: viewPersonSettings
                            .touch_sensitive_body_deplegate_value),
                    actionDeployWidget(
                        textTittle: Text('psychological_analysis'),
                        deployWidget: deployPsychological(),
                        boolCtx: viewPersonSettings
                            .psychological_analysis_deplegate_value),
                    actionDeployWidget(
                        textTittle: Text('diagnosed_data'),
                        deployWidget: deployDiagnosedData(),
                        boolCtx:
                            viewPersonSettings.diagnosed_data_deplegate_value),
                    actionDeployWidget(
                        textTittle: Text('contact_about'),
                        deployWidget: deployContactAbout(),
                        boolCtx:
                            viewPersonSettings.contact_about_deplegate_value),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 10,
        ),
        CircleAvatar(
          radius: 55,
          backgroundImage: NetworkImage(
              'https://preview.redd.it/l0m6jy5zqwxa1.png?width=640&crop=smart&auto=webp&s=c011ad1e3fcf666ade161a3a48ff6419fb944882'),
        ),
        Container(
          width: 250,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Desplegar en produccion-------------------------
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

  Widget deployGeneralInfo({PersonResp? person}) {
    // final GeneralInformation myInfo = person.generalInformation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // // Desplegar en producción--------------------------------------------
        // Text("Full Name: ${myInfo.fullName}"),
        // Text("Description: ${myInfo.description}"),
        // Text("Nickname: ${myInfo.nickname}"),
        // Text("Mail: ${myInfo.mail}"),
        // Text("Blood Type: ${myInfo.bloodType}"),
        // Text("Birth Date: ${myInfo.birthDate}"),
        // Text(
        //     "Address Location: ${myInfo.address[0]}, ${myInfo.address[1]}"),
        // Text("Workplace: ${myInfo.workplace}"),
        // Text("Family: ${myInfo.closeRelationships.family.join(', ')}"),
        // Text("Friends: ${myInfo.closeRelationships.friends.join(', ')}"),
        // Text("Enemies: ${myInfo.closeRelationships.enemies.join(', ')}"),
        // Text("Personal History: ${myInfo.personalHistory.join(', ')}"),
        // Text("Gender: ${myInfo.gender}"),
        // Text("Languages Spoken: ${myInfo.languagesSpoken.join(', ')}"),
        // Text("Phones: ${myInfo.phones.join(', ')}"),
        // Text("Social Media: ${myInfo.socialMedia.join(', ')}"),
        // Text("Connection Level: ${myInfo.connectionLevel}"),

        //Periodo de prueba
        // Desplegar en producción
        Text("Full Name: Full Name"),
        Text("Description: Description"),
        Text("Nickname: Nickname"),
        Text("Mail: asdfasd@asdfasd.com"),
        Text("Blood Type: tipo A"),
        Text("Birth Date: YYYY-MM-DD"),
        Text("Address Location: log, lat"),
        Text("Workplace: Workplace Location"),
        Text("Family: Family Member 1, Family Member 2"),
        Text("Friends: Friend 1, Friend 2"),
        Text("Enemies: Enemy 1"),
        Text("Personal History: education, work, etc"),
        Text("Gender: Gender"),
        Text("Languages Spoken: Language 1, Language 2"),
        Text("Phones: Phone 1, Phone 2"),
        Text("Social Media: Social Media 1, Social Media 2"),
        Text("Connection Level: 0"),
      ],
    );
  }

  Widget deployInterests({PersonResp? person}) {
    // final GeneralInformation myInfo = person.generalInformation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // // Desplegar en producción--------------------------------------------
        Text("deployInterests"),
      ],
    );
  }

  Widget deployTouchSensitveBody({PersonResp? person}) {
    // final GeneralInformation myInfo = person.generalInformation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // Desplegar en producción--------------------------------------------
        Text("deployTouchSensitveBody"),
      ],
    );
  }

  Widget deployPsychological({PersonResp? person}) {
    // final GeneralInformation myInfo = person.generalInformation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // // Desplegar en producción--------------------------------------------
        Text("deployPsychological"),
      ],
    );
  }

  Widget deployDiagnosedData({PersonResp? person}) {
    // final GeneralInformation myInfo = person.generalInformation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // Desplegar en producción--------------------------------------------
        Text("deployDiagnosedData"),
      ],
    );
  }

  Widget deployContactAbout({PersonResp? person}) {
    // final GeneralInformation myInfo = person.generalInformation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // Desplegar en producción--------------------------------------------
        Text("deployContactAbout"),
      ],
    );
  }
}
