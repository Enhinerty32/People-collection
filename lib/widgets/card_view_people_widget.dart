import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:people_collection/models/person_resp.dart';

import '../routes/_routes.dart';

class CardViewPeopleWidget extends StatelessWidget {
  const CardViewPeopleWidget({super.key, this.person});
  // const CardViewPeopleWidget({super.key, required this.person});

  final PersonResp? person;

  @override
  Widget build(BuildContext context) {
    double sizeSpace=8;
//  final myInfo = person.generalInformation;
    if (person == null) {
      return GestureDetector(
        onTap:() {
          Get.to(ViewPersonPage (),arguments:person , transition: Transition.leftToRightWithFade);
        },
        child: Card(
            child: Row(
              children: [
                CircleAvatar( 
                  radius: 50,
                  backgroundImage: NetworkImage('https://preview.redd.it/l0m6jy5zqwxa1.png?width=640&crop=smart&auto=webp&s=c011ad1e3fcf666ade161a3a48ff6419fb944882'),
                ),
                Container(
                  width: 250,
                        padding: EdgeInsets.all(20),
                        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("Nickname: ${myInfo.nickname}"),
                  // Text("Full Name: ${myInfo.fullName}"),
                  // Text("Age: ${calculateAge("2012-02-27")} "),
                  // Text("Gender: ${myInfo.gender}"),
                  // Text("Connection Level: ${myInfo.connectionLevel}"),
                  Text("Nickname: Capilla"   ,overflow: TextOverflow.ellipsis, ),
                 SizedBox(height: sizeSpace,),
                  Text("fullName: Maria antonieta Maria antonieta Maria antonietadsfasdf asdfasdf ",   maxLines: 2,
                          overflow: TextOverflow.ellipsis, ),    SizedBox(height: sizeSpace,),
                  Text("Age:  24} ",overflow: TextOverflow.ellipsis,),    SizedBox(height: sizeSpace,),
                  Text("Gender: mujer",overflow: TextOverflow.ellipsis,),    SizedBox(height: sizeSpace,),
                  Text("Connection Lvl: - - - - - 0 - - - -", ),
                ],
                        ),
                      ),
              ],
            )),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}

 