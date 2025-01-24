import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:people_collection/firebase_options.dart';
import 'auth/Data/auth_provider.dart';
import 'auth/screen/login_screen.dart';
import 'auth/screen/reset_pass_screen.dart';
import 'auth/screen/settings_screen.dart';
import 'auth/screen/sign_up_screen.dart';
import 'routes/_routes.dart';
import 'routes/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(AuthProvider()); // Inicializa el controlador principal
      }),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/test',
          page: () => TestPage(),
        ),
        GetPage(
          name: '/newPerson',
          page: () => NewPersonPage(),
        ),
        GetPage(
          name: '/editPerson',
          page: () => EditPersonPage(),
        ),
        GetPage(
          name: '/viewPerson',
          page: () => ViewPersonPage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/singup',
          page: () => SignUpScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/resetpass',
          page: () => ResetPass(),
        ),
        GetPage(
          name: '/settings',
          page: () => SettingsScreen(),
        ),
      ],
    );
  }
}
