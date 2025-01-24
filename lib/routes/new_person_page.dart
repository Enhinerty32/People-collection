import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPersonPage extends StatelessWidget {
  const NewPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewPersonPage'),
      ),
      body: Center(
        child: Text('NewPersonPage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
        },
        tooltip: 'Comeback',
        child: const Icon(Icons.check),
      ),
    );
  }
}
