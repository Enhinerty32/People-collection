import 'package:flutter/material.dart';
import '/auth/Data/auth_provider.dart';

class TextButtonSignOut extends StatelessWidget {
 TextButtonSignOut({
    super.key,
  });

  final AuthProvider authProvider =AuthProvider();

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          
          authProvider.signOut();
        },
        label: Text(
          "Cerrar sesion",
          style: TextStyle(color: Colors.red),
        ));
  }
}