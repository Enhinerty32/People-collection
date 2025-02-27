 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:people_colletion_riverpod/auth/providers/0-providers_auth.dart';
 

class RegisterScreen extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthFirebaseProvider authFirebaseProvider = AuthFirebaseProvider();
  final formsValidator = FormsValidatorServices();
  final _ThisStyle thisStyle = _ThisStyle();
  RegisterScreen({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
 
  
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electronico',
                  border: thisStyle.inputBorder,
                ),
                validator: formsValidator.emailValidator,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña ',
                  border: thisStyle.inputBorder,
                ),
                validator: formsValidator.passwordValidartor,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        ref.read(appPrincipalRouterProvider).go('/');
                      },
                      child: Text('Ya tienes Cuenta?')),
                  Expanded(child: SizedBox())
                ],
              ),
              ElevatedButton(
                  onPressed:() =>_registerUser(context:context,ref:ref),
                  child: Text('Ingresar'))
            ],
          ),
        ),
      ),
    );
  }
  
 void _registerUser({required BuildContext context, required WidgetRef ref}) async {
  if (_formKey.currentState?.validate() == true) {
    var result = await authFirebaseProvider.registerWithEmailAndPassword(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (result != null) {
      // Registro exitoso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario registrado con éxito')),
      );
      ref.read(appPrincipalRouterProvider.notifier).getAccessibility();
      ref.read(appPrincipalRouterProvider).go('/');
    } else {
      // Error en el registro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en el registro')),
      );
    }
  }
}

}

class _ThisStyle {
  InputBorder inputBorder = OutlineInputBorder();
}
