import 'package:chips_choice/chips_choice.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:people_collection/Provider/settings_provider.dart';
import 'package:people_collection/routes/_routes.dart';
import 'package:people_collection/routes/map_screen.dart';
import 'package:people_collection/widgets/show_and_edit_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/user_model.dart';
import '../widgets/_widgets.dart';
import '../widgets/enneagram_radar_chart_widget.dart';
import '../widgets/get_mbti_widged.dart';
import '../widgets/sleep_pattern_widget.dart';
import '../widgets/view_person_widgets.dart/general_information_widget.dart';

class ViewPersonPage extends StatelessWidget {
  const ViewPersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final thisController = Get.put(ViewPersonPageController());
    final ListPerson person = Get.arguments;
    const double sizeSpace = 8;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          person.generalInformation.fullName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          GeneralInformationWidget(person: person,),//listo
          _buildCategoryExpansionTile("Intereses", deployInterests(person: person)),//listo
          _buildCategoryExpansionTile("Datos Psicologicos", deployPsychological(person: person)),//Falta Big Five
          _buildCategoryExpansionTile("Diagnóstico", deployDiagnosedData(person: person)),//Falta Ciclo menstrual
          // _buildCategoryExpansionTile("Sensible al tacto", deployTouchSensitveBody()),//aun no
          // _buildCategoryExpansionTile("Datos adicionales", deployContactAbout()),//aun no
          const SizedBox(height: 150),
        ],
      ), 
    );
  }
 //---------------
  Widget _buildInfoText(String label, String value) {
    return Text("$label: ${value.isEmpty ? '--' : value}");
  }


//-------------------
  Widget _buildProfileText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text("$label: ${value.isEmpty ? '--' : value}", overflow: TextOverflow.ellipsis, maxLines: 2),
    );
  }
//-----------------
  Widget _buildExpansionTile(String title, Widget child) {
    return ExpansionTile(
      title: Text(title,),
      children: [SizedBox(width: 400,child: child)],
    );
  }

  //---------------
  Widget _buildCategoryExpansionTile(String title, Widget child) {
    return ExpansionTile(
      title: Text(title,style: TextStyle(color: Colors.cyanAccent),),
      children: [SizedBox(width: 400,child: child)],
    );
  }

//-----------------

Widget textWidget(String text){
return Padding(
  padding:  EdgeInsets.symmetric(vertical:  6.0),
  child: Text(text
      ,style: TextStyle(fontSize: 15),),
);
  }
//-----------------
  Widget _buildListTextSection({required List<String> listItems, required String title}) {
    return _buildListSection(
      title: title,
      listItems: listItems,
      emptyMessage: "No hay datos",
      itemBuilder: (context, item) => textWidget(item),
    );
  }

  Widget _buildListSection({required String title,   required List listItems, required String emptyMessage, required Widget Function(BuildContext, dynamic) itemBuilder}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildExpansionTile(
                  title,
                  listItems.isEmpty
                      ? Text(emptyMessage)
                      : Padding(
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listItems.length,
                            itemBuilder: (context, index) {
                              final item = listItems[index];
                              return itemBuilder(context, item);
                            },
                          ),
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//----------------
  Widget _buildInfoTextButtonURL(String url) {
    return Tooltip(
      message: url,
      child: IconButton(
        onPressed: () async {
          await SettingsProvider().launchURL(url);
        },
        icon: Icon(SettingsProvider().getIconForPlatform(url)),
      ),
    );
  }



 

  Widget deployInterests({required ListPerson person}) {
    final Interests myInfo = person.interests;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [

        _buildListTextSection(listItems: myInfo.mysticalInterests,title:"Intereses misticos" ),
        _buildListTextSection(listItems:myInfo.hobbyAreas,title:"Pasatiempos" ),
        _buildListTextSection(listItems:myInfo.musicalPreferences,title:"Preferencias musicales " ),
        _buildListTextSection(listItems:myInfo.cinematicThemes,title:"Intereses Cinematograficos" ),
        _buildListTextSection(listItems:myInfo.deepInterests,title:"Intereses Profundos" ),
         
         
         
         
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

  Widget deployPsychological({required ListPerson person}) {
    final PsychologicalAnalysis myInfo = person.psychologicalAnalysis;
    return SizedBox(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
 
          MbtiWidget(mbtiType: myInfo.mbti),
         EnneagramRadarChartWidget(enneagramData:myInfo.enneagram ,),
          // Text("BigFive:Five"),
        ],
      ),
    );
  }

  Widget deployDiagnosedData({required ListPerson person}) {
    final DiagnosedData  myInfo = person.diagnosedData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // Desplegar en producción--------------------------------------------
        // Text("deployDiagnosedData"),
        myInfo.diagnosis.isEmpty?textWidget("Diagnóstico General: --"):textWidget("Diagnóstico General: ${myInfo.diagnosis}"),
        textWidget("Peso: ${myInfo. weight} kg"),
         _buildListTextSection(listItems: myInfo.diagnosedConditions,title:"Condiciones diagnosticadas" ),
        _buildExpansionTile('Horario de sueño', SleepPatternWidget(sleepPattern: myInfo.sleepPattern)),

        //Aun no implementado 
        // Text("Ciclo Menstrual: ${myInfo.menstrualCycle }"), 
      ],
    );
  }





//Aun no implementado 
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

class ViewPersonPageController extends GetxController {}
