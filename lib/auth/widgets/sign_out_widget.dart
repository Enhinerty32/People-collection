 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:people_colletion_riverpod/auth/providers/0-providers_auth.dart';

class SignOutWidget extends ConsumerWidget {
    final AuthFirebaseProvider authFirebaseProvider = AuthFirebaseProvider();
    SignOutWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () =>signOutAction(ref),
      child: Row(spacing: 5,
        children: [
          Icon(Icons.arrow_back_ios_new),
          Text('Salir de sesion')
        ],
      ),
    );
  }

  Future<void> signOutAction([ref])async {
                authFirebaseProvider.signOut();
                ref.read(appPrincipalRouterProvider.notifier).closeAccessibility();
                ref.read(appPrincipalRouterProvider).go('/');
  }
}