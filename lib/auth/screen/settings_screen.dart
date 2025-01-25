import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/storage_provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  // final authProvider = AuthProvider();
  // final mainDB = Get.put(Maindb());
  final SettingsScreenController thisController =
      Get.put(SettingsScreenController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Configuracion'),
      ),
      body: Center(
        child: Column(
          children: [
        
            
          ],
        ),
      ),
    );
  }
}

class SettingsScreenController extends GetxController {
 
}
