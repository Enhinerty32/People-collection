import 'package:people_colletion_riverpod/auth/router/app_router_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/firebase_auth_provider.dart';
import '../providers/validartors_provider.dart';

class ResetPassScreen extends ConsumerWidget {
  ResetPassScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final formsValidator = FormsValidatorServices();
  final _ThisStyle thisStyle = _ThisStyle();
  final AuthFirebaseProvider authFirebaseProvider = AuthFirebaseProvider();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recupera la contraseña '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electronico',
                  border: thisStyle.inputBorder,
                ),
                validator: formsValidator.emailValidator,
              ),
              Row(
                children: [
                  Text(
                    'Ingresa el mismo correo con el que te registrastes',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      authFirebaseProvider.resetPassword(email: _emailController.text);
                      ref.read(appPrincipalRouterProvider).go('/');
                    }

                    print('Llave invalida');
                  },
                  child: Text('Enviar'))
            ],
          ),
        ),
      ),
    );
  }
}

class _ThisStyle {
  InputBorder inputBorder = OutlineInputBorder();
}
