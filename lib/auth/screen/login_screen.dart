import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import '../../routes/home_screen.dart';
import '/auth/Data/auth_provider.dart';
import '/auth/services/tools_TextFormField_provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthProvider _authProvider = AuthProvider();
  final ValidatorsTextformfieldProvider _toolsTextformfield =
      ValidatorsTextformfieldProvider();
  final LoginScreenController _controller = Get.put(LoginScreenController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _authProvider.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          final String token = snapshot.data ?? '';
          return token.isEmpty
              ? Login(
                  formKey: _formKey,
                  emailController: _emailController,
                  toolsTextformfield: _toolsTextformfield,
                  passwordController: _passwordController,
                  controller: _controller,
                  authProvider: _authProvider,
                )
              : HomeScreen();
        } else {
          return Text('Sin datos disponibles');
        }
      },
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.toolsTextformfield,
    required this.passwordController,
    required this.controller,
    required this.authProvider,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final ValidatorsTextformfieldProvider toolsTextformfield;
  final TextEditingController passwordController;
  final LoginScreenController controller;
  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Formulario para entrar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              _buildTextFormField(emailController, 'Correo electrónico',
                  toolsTextformfield.emailValidator),
              SizedBox(height: 20),
              _buildPasswordTextField(),
              SizedBox(height: 5),
              _buildFooterButtons(),
              SizedBox(height: 20),
              _buildLoginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(TextEditingController controller,
      String label, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Obx _buildPasswordTextField() {
    return Obx(() => TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () =>
                  controller.obscureText.value = !controller.obscureText.value,
              icon: Icon(controller.obscureText.value
                  ? Icons.remove_red_eye
                  : Icons.remove_red_eye_outlined),
            ),
            labelText: 'Contraseña',
            border: OutlineInputBorder(),
          ),
          obscureText: controller.obscureText.value,
          validator: toolsTextformfield.passwordValidartor,
        ));
  }

  Row _buildFooterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Get.offAndToNamed('/singup'),
          child: Text('Registrate'),
        ),
        TextButton(
          onPressed: () => Get.toNamed('/resetpass'),
          child: Text('Olvidates la contraseña'),
        ),
      ],
    );
  }

  ElevatedButton _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState?.validate() ?? false) {
          final User? userLog = await authProvider.signInWithEmailAndPassword(
            context: context,
            email: emailController.text,
            password: passwordController.text,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(userLog != null
                    ? 'Usuario registrado con éxito'
                    : 'Error en el registro')),
          );

          if (userLog != null) {
            Get.offAndToNamed('/home');
            Get.delete<LoginScreenController>();
          }
        }
      },
      child: Text('Entrar'),
    );
  }
}

class LoginScreenController extends GetxController {
  final RxBool obscureText = true.obs;
}
