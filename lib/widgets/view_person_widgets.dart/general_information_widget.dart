import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:people_collection/models/user_model.dart';
import '../../Provider/settings_provider.dart';

class GeneralInformationWidget extends StatelessWidget {
  const GeneralInformationWidget({super.key, required this.person});
  final ListPerson person;

  @override
  Widget build(BuildContext context) {
    final myInfo = person.generalInformation;
    return Column(
      children: [
        _showProfile(myInfo),
        _buildCategoryExpansionTile("Datos Generales", _buildGeneralInfoSection(myInfo)),
      ],
    );
  }

  Widget _showProfile(GeneralInformation myInfo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 10),
        const CircleAvatar(
          radius: 55,
          backgroundImage: NetworkImage(
              'https://preview.redd.it/l0m6jy5zqwxa1.png?width=640&crop=smart&auto=webp&s=c011ad1e3fcf666ade161a3a48ff6419fb944882'),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var entry in {
                  "Apodo": myInfo.nickname,
                  "Nombre": myInfo.fullName,
                  "Edad": myInfo.birthDate,
                  "Género": myInfo.gender,
                  "Nivel de Conexión": myInfo.connectionLevel.toString()
                }.entries)
                  _buildInfoText(entry.key, entry.value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGeneralInfoSection(GeneralInformation myInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var entry in {
          "Descripción": myInfo.description,
          "Correo": myInfo.mail,
          "Tipo de Sangre": myInfo.bloodType,
          "Fecha de Nacimiento": myInfo.birthDate,
          "Lugar de Trabajo": myInfo.workplace
        }.entries)
          _buildInfoText(entry.key, entry.value),
        _buildLocationSection(myInfo),
        _buildListSection("Números de celular", myInfo.phones),
        _buildListSection("Lenguajes", myInfo.languagesSpoken),
        _buildListPersonalHistorySection("Historia Personal", myInfo.personalHistory),
        _buildListSocialSection("Redes Sociales", myInfo.socialMedia),
      ],
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Text("$label: ${value.isEmpty ? '--' : value}");
  }

  Widget _buildExpansionTile(String title, Widget child) {
    return ExpansionTile(
      
      title: Text(title),
      children: [child],
    );
  }

  Widget _buildListSection(String title, List<String> listItems) {
    return _buildListBase(
      title: title,
       
      listItems: listItems,
      itemBuilder: (context, item) => Text(item),
    );
  }

  Widget _buildListPersonalHistorySection(String title, List<PersonalHistory> listItems) {
    return _buildListBase(
      title: title,
       
      listItems: listItems,
      itemBuilder: (context, history) => SizedBox(
        child: TextButton(
          onPressed: () => SettingsProvider().showNotePopup(
              context: context, content: history.history, title: history.title),
          child: Text(history.title, maxLines: 3, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }

  Widget _buildListSocialSection(String title, List<String> listItems) {
    return _buildListBase(
      title: title,
      
      listItems: listItems,
      itemBuilder: (context, item) => _buildInfoTextButtonURL(item),
    );
  }

  Widget _buildListBase<T>({
    required String title,

    required List<T> listItems,
    required Widget Function(BuildContext, T) itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         
        _buildExpansionTile(
          title,
          listItems.isEmpty
              ? const Text("No hay datos")
              : Padding(padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listItems.length,
                    itemBuilder: (context, index) => itemBuilder(context, listItems[index]),
                  ),
              ),
        ),
      ],
    );
  }

  Widget _buildLocationSection(GeneralInformation myInfo) {
    return _buildListBase(
      title: "Lugares Registrados",
      listItems: myInfo.locations,
      itemBuilder: (context, place) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: ExpansionTileCard(
          baseColor: Colors.blueGrey.shade600,
          expandedColor: Colors.black87,
          title: Text(place.namePlace),
          children: [
              Text(place.description),
            TextButton(
              onPressed: () => Get.toNamed("/map", arguments: place.place),
              child: const Text("Ver en el mapa"),
            ),
          ],
        ),
      ),
    );
  }

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

    Widget _buildCategoryExpansionTile(String title, Widget child) {
    return ExpansionTile(
      title: Text(title,style: TextStyle(color: Colors.cyanAccent),),
      children: [SizedBox(width: 400,child: child)],
    );
  }

}
