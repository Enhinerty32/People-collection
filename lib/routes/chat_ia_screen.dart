import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatIAScreen extends StatelessWidget {
  const ChatIAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: (){Get.back();}, icon:Icon(Icons.arrow_back_ios_new))],),
      drawer: Drawer(),
      body: Center(child: Text('chat'),),
    );
  }
}