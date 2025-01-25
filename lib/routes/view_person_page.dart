import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:people_collection/routes/_routes.dart';
import 'package:people_collection/routes/map_screen.dart';

import '../models/user_model.dart';
import '../widgets/_widgets.dart';

class ViewPersonPage extends StatelessWidget {
  const ViewPersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final thisController = Get.put(ViewPersonPageController());
    final ListPerson person = Get.arguments;

    double sizeSpace = 8;
      final  query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "${person.generalInformation.fullName}  ",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      body: ListView(
        
        children: [
          showProfile(sizeSpace, person.generalInformation),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionDeployWidget(
                    textTitle: Text('general_information '),
                    deployWidget: deployGeneralInfo(person: person,),
                    boolCtx:
                        thisController.general_information_deplegate_value),
                ActionDeployWidget(
                    textTitle: Text('interests'),
                    deployWidget: deployInterests(),
                    boolCtx: thisController.interest_deplegate_value),
                ActionDeployWidget(
                    textTitle: Text('touch_sensitive_body'),
                    deployWidget: deployTouchSensitveBody(),
                    boolCtx:
                        thisController.touch_sensitive_body_deplegate_value),
                ActionDeployWidget(
                    textTitle: Text('psychological_analysis'),
                    deployWidget: deployPsychological(),
                    boolCtx:
                        thisController.psychological_analysis_deplegate_value),
                ActionDeployWidget(
                    textTitle: Text('diagnosed_data'),
                    deployWidget: deployDiagnosedData(),
                    boolCtx: thisController.diagnosed_data_deplegate_value),
                ActionDeployWidget(
                    textTitle: Text('contact_about'),
                    deployWidget: deployContactAbout(),
                    boolCtx: thisController.contact_about_deplegate_value),
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
    );
  }

  Row showProfile(double sizeSpace, GeneralInformation myInfo) {
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
              Text(
                "Apodo: ${myInfo.nickname.isEmpty ? '--' : myInfo.nickname}         ",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: sizeSpace,
              ),
              Text(
                "Nombre: ${myInfo.fullName.isEmpty ? '--' : myInfo.fullName}         ",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: sizeSpace,
              ),
              Text(
                "Edad: ${myInfo.birthDate.isEmpty ? '--' : ("2012-02-27")}          ",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: sizeSpace,
              ),
              Text(
                "Genero: ${myInfo.gender.isEmpty ? '--' : myInfo.gender}              ",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: sizeSpace,
              ),
              Text(
                "Connection Level: ${myInfo.connectionLevel == 0 ? '--' : myInfo.connectionLevel}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: sizeSpace,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget deployGeneralInfo({required ListPerson person}) {
    final GeneralInformation myInfo = person.generalInformation;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // // Desplegar en producción--------------------------------------------
        myInfo.description.isEmpty? SizedBox():  Text("Description${myInfo.description}"),
        myInfo.mail.isEmpty?  SizedBox(): Text("Mail${myInfo.mail}")                     ,
        myInfo.bloodType.isEmpty?SizedBox():  Text("Blood Type${myInfo.bloodType}")     ,
        myInfo.birthDate.isEmpty?SizedBox():  Text("Birth Date${myInfo.birthDate}")     ,
        myInfo.workplace.isEmpty?SizedBox(): Text("Workplace${myInfo.workplace}")       ,
        // myInfo.addressLocation[0]==0 && myInfo.addressLocation[1]==0? SizedBox():Text("Address Location: ${myInfo.addressLocation[0]}, ${myInfo.addressLocation[1]}") ,
        myInfo.locations.isEmpty? SizedBox():TextButton(onPressed: (){
        Get.toNamed('/map' ,arguments:myInfo.locations );
       }, child: Text('Direccion de su hogar'))
        // Text("Personal History: ${myInfo.personalHistory.join(', ')}"),
        // Text("Languages Spoken: ${myInfo.languagesSpoken.join(', ')}"),
        // Text("Phones:           ${myInfo.phones.join(', ')}"),
        // Text("Social Media:     ${myInfo.socialMedia.join(', ')}"),
        // Text("Enemies:          ${myInfo.closeRelationships.enemies.join(', ')}"),
        // Text("Friends:          ${myInfo.closeRelationships.friends.join(', ')}"),
        // Text("Family:           ${myInfo.closeRelationships.family.join(', ')}"),
      ],
    );
  }

  Widget deployInterests({ListPerson? person}) {
    // final Interests myInfo = person.interests;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // // Desplegar en producción--------------------------------------------
        // Text("deployInterests"),
        // Text("Mystical Interests: ${myInfo.mysticalInterests.join(', ')}"),
        // Text("Hobby Areas: ${myInfo.hobbyAreas.join(', ')}"),
        // Text("Musical Preferences: ${myInfo.musicalPreferences.join(', ')}"),
        // Text("Cinematic Themes: ${myInfo.cinematicThemes.join(', ')}"),
        // Text("Deep Interests: ${myInfo.deepInterests.join(', ')}"),

        Text("Mystical Interests: mysticalInterests"),
        Text("Hobby Areas: hobbyAreas"),
        Text("Musical Preferences: musicalPreferences"),
        Text("Cinematic Themes: cinematicThemes"),
        Text("Deep Interests: deepInterests"),
      ],
    );
  }

  Widget deployTouchSensitveBody({ListPerson? person}) {
    // final TouchSensitiveBody myInfo = person.touchSensitiveBody;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // Desplegar en producción--------------------------------------------
        // Text("deployTouchSensitveBody"),
        // Text("Mystical Interests: ${myInfo.neck}"),
        // Text("Mystical Interests: ${myInfo.shoulder}"),
        // Text("Mystical Interests: ${myInfo.chest}"),
        // Text("Mystical Interests: ${myInfo.abdomen}"),
        // Text("Mystical Interests: ${myInfo.elbow}"),
        // Text("Mystical Interests: ${myInfo.arm}"),
        // Text("Mystical Interests: ${myInfo.hands}"),
        // Text("Mystical Interests: ${myInfo.thigh}"),
        // Text("Mystical Interests: ${myInfo.knee}"),
        // Text("Mystical Interests: ${myInfo.leg}"),
        // Text("Mystical Interests: ${myInfo.feet}"),
        // Text("Mystical Interests: ${myInfo.upperBack}"),
        // Text("Mystical Interests: ${myInfo.lowerBack}"),
        // Text("Mystical Interests: ${myInfo.ear}"),
        // Text("Mystical Interests: ${myInfo.chin}"),
        // Text("Mystical Interests: ${myInfo.forehead}"),
        // Text("Mystical Interests: ${myInfo.cheek}"),
        // Text("Mystical Interests: ${myInfo.hair}"),
        // Text("Mystical Interests: ${myInfo.mouth}"),
        // Text("Mystical Interests: ${myInfo.nose}"),

        Text("Mystical Interests: myInfo.neck"),
        Text("Mystical Interests: myInfo.shoulder"),
        Text("Mystical Interests: myInfo.chest"),
        Text("Mystical Interests: myInfo.abdomen"),
        Text("Mystical Interests: myInfo.elbow"),
        Text("Mystical Interests: myInfo.arm"),
        Text("Mystical Interests: myInfo.hands"),
        Text("Mystical Interests: myInfo.thigh"),
        Text("Mystical Interests: myInfo.knee"),
        Text("Mystical Interests: myInfo.leg"),
        Text("Mystical Interests: myInfo.feet"),
        Text("Mystical Interests: myInfo.upperBack"),
        Text("Mystical Interests: myInfo.lowerBack"),
        Text("Mystical Interests: myInfo.ear"),
        Text("Mystical Interests: myInfo.chin"),
        Text("Mystical Interests: myInfo.forehead"),
        Text("Mystical Interests: myInfo.cheek"),
        Text("Mystical Interests: myInfo.hair"),
        Text("Mystical Interests: myInfo.mouth"),
        Text("Mystical Interests: myInfo.nose"),
      ],
    );
  }

  Widget deployPsychological({ListPerson? person}) {
    // final PsychologicalAnalysis myInfo = person.psychologicalAnalysis;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        //  Desplegar en producción--------------------------------------------
        //         Text("deployPsychological"),
        //            Text("MBTI: ${myInfo.mbti}"),
        //            Text("Enneagram: ${myInfo.enneagram}"),
        //            Text("BigFive: ${myInfo.bigFive}"),
        Text("MBTI:mbti"),
        Text("Enneagram:gram"),
        Text("BigFive:Five"),
      ],
    );
  }

  Widget deployDiagnosedData({ListPerson? person}) {
    // final DiagnosedData  myInfo = person.diagnosedData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // Desplegar en producción--------------------------------------------
        // Text("deployDiagnosedData"),
        // Text("Neck: ${myInfo. weight}"),
        // Text("Shoulder: ${myInfo.diagnosedConditions}"),
        // Text("Chest: ${myInfo.diagnosis }"),
        // Text("Chest: ${myInfo.sleepPattern }"),
        // Text("Chest: ${myInfo.menstrualCycle }"),

        Text("Neck: myInfo. weight"),
        Text("Shoulder: myInfo.diagnosedConditions"),
        Text("Chest: myInfo.diagnosis "),
        Text("Chest: myInfo.sleepPattern "),
        Text("Chest: myInfo.menstrualCycle "),
      ],
    );
  }

  Widget deployContactAbout({ListPerson? person}) {
    // final ContactAbout myInfo = person.contactAbout;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // Desplegar en producción--------------------------------------------
        Text("deployContactAbout"),

        // Text("verbalContextualStyle: ${myInfo.verbalContextualStyle  }"),
        // Text("languageComplexity: ${myInfo.languageComplexity  }"),
        // Text("discourseFormat: ${myInfo.discourseFormat  }"),
        // Text("responseInConflicts: ${myInfo.responseInConflicts  }"),
        // Text("wordGestureSync: ${myInfo.wordGestureSync  }"),
        // Text("postureChanges: ${myInfo.postureChanges  }"),
        // Text("spontaneousMicroexpressions: ${myInfo.spontaneousMicroexpressions  }"),
        // Text("personalSpaceRespect: ${myInfo.personalSpaceRespect  }"),
        // Text("digitalInteractionFormality: ${myInfo.digitalInteractionFormality  }"),
        // Text("writtenEmotionalExpression: ${myInfo.writtenEmotionalExpression  }"),
        // Text("responseSpeed: ${myInfo.responseSpeed  }"),
        // Text("interactionRhythmStyle: ${myInfo.interactionRhythmStyle  }"),
        // Text("writingCare: ${myInfo.writingCare  }"),
        // Text("messageLength: ${myInfo.messageLength  }"),
        // Text("visualContact: ${myInfo.visualContact  }"),
        // Text("physicalProximity: ${myInfo.physicalProximity  }"),
        // Text("voiceTone: ${myInfo.voiceTone  }"),
        // Text("intonation: ${myInfo.intonation  }"),
        // Text("gesticulation: ${myInfo.gesticulation  }"),
        // Text("generalAttitude: ${myInfo.generalAttitude  }"),
        // Text("emotionalConnection: ${myInfo.emotionalConnection  }"),
        // Text("interruptions: ${myInfo.interruptions  }"),
        // Text("appearanceCare: ${myInfo.appearanceCare  }"),
        // Text("listeningSkills: ${myInfo.listeningSkills  }"),
        // Text("expressionClarity: ${myInfo.expressionClarity  }"),
        // Text("oralCommunicationFormalityLevel: ${myInfo.oralCommunicationFormalityLevel  }"),

        Text("verbalContextualStyle: verbalContextualStyle  "),
        Text("languageComplexity: languageComplexity  "),
        Text("discourseFormat: discourseFormat  "),
        Text("responseInConflicts: responseInConflicts  "),
        Text("wordGestureSync: wordGestureSync  "),
        Text("postureChanges: postureChanges  "),
        Text("spontaneousMicroexpressions: spontaneousMicroexpressions  "),
        Text("personalSpaceRespect: personalSpaceRespect  "),
        Text("digitalInteractionFormality: digitalInteractionFormality  "),
        Text("writtenEmotionalExpression: writtenEmotionalExpression  "),
        Text("responseSpeed: responseSpeed  "),
        Text("interactionRhythmStyle: interactionRhythmStyle  "),
        Text("writingCare: writingCare  "),
        Text("messageLength: messageLength  "),
        Text("visualContact: visualContact  "),
        Text("physicalProximity: physicalProximity  "),
        Text("voiceTone: voiceTone  "),
        Text("intonation: intonation  "),
        Text("gesticulation: gesticulation  "),
        Text("generalAttitude: generalAttitude  "),
        Text("emotionalConnection: emotionalConnection  "),
        Text("interruptions: interruptions  "),
        Text("appearanceCare: appearanceCare  "),
        Text("listeningSkills: listeningSkills  "),
        Text("expressionClarity: expressionClarity  "),
        Text(
            "oralCommunicationFormalityLevel: oralCommunicationFormalityLevel  "),
      ],
    );
  }
}

class ViewPersonPageController extends GetxController {
  final general_information_deplegate_value = false.obs;
  final interest_deplegate_value = false.obs;
  final touch_sensitive_body_deplegate_value = false.obs;
  final psychological_analysis_deplegate_value = false.obs;
  final diagnosed_data_deplegate_value = false.obs;
  final contact_about_deplegate_value = false.obs;
}
