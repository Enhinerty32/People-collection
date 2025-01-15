import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPersonPage extends StatelessWidget {
  const EditPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Person'),
      ),
      body: Center(
        child: Text('Edit Person Page'),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          Get.back();
        },
        tooltip: 'Comeback',
        child: const Icon(Icons.save),
      ),
    );
  }
}