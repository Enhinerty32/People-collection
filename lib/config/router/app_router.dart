import 'package:people_colletion_riverpod/provider/0-provider.dart';
import 'package:people_colletion_riverpod/screens/0-screens.dart';
import 'package:people_colletion_riverpod/screens/view_person_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import '../../screens/edit_person_screen.dart';
import '../models/person_model.dart';

part 'app_router.g.dart';

//Cambiar de pagina llamar a appPrincipalRouter en riverpod
@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
        path: '/viewPerson',
        builder: (context, state) {
          final person = state.extra as Person;
          return ViewPersonScreen(person: person);
        }),
    GoRoute(
        path: '/editPerson',
        builder: (context, state) {
          final person = state.extra as Person;
          return EditPersonScreen(person: person);
        }),
  ]);
}
