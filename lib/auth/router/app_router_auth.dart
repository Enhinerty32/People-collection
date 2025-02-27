import 'package:people_colletion_riverpod/auth/screen/0-screens.dart';
import 'package:people_colletion_riverpod/config/router/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
part 'app_router_auth.g.dart';

@riverpod
class AppPrincipalRouter extends _$AppPrincipalRouter {
  // ignore: avoid_public_notifier_properties
  final loginRoutes = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/resetPass',
      builder: (context, state) => ResetPassScreen(),
    ),
  ]);

  @override
  GoRouter build() {
    final baseRouter = ref.watch(appRouterProvider);
    final user = FirebaseAuth.instance.currentUser?.getIdToken();
    if (user != null) return baseRouter;
    return loginRoutes;
  }

  void getAccessibility() async {
    final baseRouter = ref.watch(appRouterProvider);
    state = baseRouter;
 
  }

  void closeAccessibility() async {
    state = loginRoutes;  
  }
}

