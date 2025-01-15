import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/_routes.dart'; 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        
      
        useMaterial3: true,
      ),
      initialRoute: '/home',
         getPages: [
        GetPage(name: '/home', page: () => HomePage(),),
        GetPage(name: '/test', page: () => TestPage(),),
        GetPage(name: '/newPerson', page: () => NewPersonPage(),),
        GetPage(name: '/editPerson', page: () => EditPersonPage(),),
        GetPage(name: '/viewPerson', page: () => ViewPersonPage(),),
      ],
    
     
    );
  }
}
 