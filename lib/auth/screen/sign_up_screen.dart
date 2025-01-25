import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/auth/Data/auth_provider.dart';
import '/auth/services/tools_TextFormField_provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final AuthProvider authProvider = AuthProvider();
  final toolsTextformfield = ValidatorsTextformfieldProvider();
  final SignUpScreenController thisController = Get.put(SignUpScreenController());

  final FlCountryCodePicker countryPicker = const FlCountryCodePicker(
    title: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text("Selecciona tu país", style: TextStyle(fontSize: 25)),
    ),
    searchBarDecoration: InputDecoration(
      border: OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
    ),
  );

  SignUpScreen({super.key});

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número es obligatorio';
    } else if (thisController.countryCode.isEmpty) {
      return 'Selecciona el código de región';
    } else if (value.length > 12) {
      return 'Demasiado largo, mayor a 12 dígitos';
    } else if (value.length < 4) {
      return 'Demasiado corto, menor a 4 dígitos';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Formulario Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                _buildNameField(),
                SizedBox(height: 20),
                _buildPhoneField(),
                SizedBox(height: 20),
                _buildEmailField(),
                SizedBox(height: 20),
                _buildPasswordField(),
                _buildLoginRedirectButton(),
                SizedBox(height: 20),
                _buildRegisterButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Nombre',
        border: OutlineInputBorder(),
      ),
      validator: toolsTextformfield.nameValidartor,
    );
  }

  TextFormField _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(
        labelText: 'Celular',
        prefixIcon: ButtonCode(thisController: thisController, countryPicker: countryPicker, authProvider: authProvider),
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      validator: _phoneValidator,
    );
  }

  TextFormField _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Correo electrónico',
        border: OutlineInputBorder(),
      ),
      validator: toolsTextformfield.emailValidator,
    );
  }

  Obx _buildPasswordField() {
    return Obx(() => TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                thisController.obscureText.value = !thisController.obscureText.value;
              },
              icon: Icon(thisController.obscureText.value ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
            ),
            labelText: 'Contraseña',
            border: OutlineInputBorder(),
          ),
          obscureText: thisController.obscureText.value,
          validator: toolsTextformfield.passwordValidartor,
        ));
  }

  Align _buildLoginRedirectButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          Get.offAndToNamed('/login');
        },
        child: Text('¿Ya eres usuario?'),
      ),
    );
  }

  ElevatedButton _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate() && thisController.countryCode.isNotEmpty) {
          var result = await authProvider.registerWithEmailAndPassword(
            phone: '${thisController.countryCode.value} ${_phoneController.text}',
            name: _nameController.text,
            context: context,
            email: _emailController.text,
            password: _passwordController.text,
          );
          if (result != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuario registrado con éxito')));
            Get.offAndToNamed('/login');
            Get.delete<SignUpScreenController>();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error en el registro')));
          }
        }
      },
      child: Text('Registrar'),
    );
  }
}

class ButtonCode extends StatelessWidget {
  const ButtonCode({
    super.key,
    required this.countryPicker,
    required this.authProvider,
    required this.thisController,
  });

  final FlCountryCodePicker countryPicker;
  final AuthProvider authProvider;
  final SignUpScreenController thisController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await countryPicker.showPicker(
          context: context,
          backgroundColor: Colors.black,
        );
        if (picked != null) {
          thisController.countryCode.value = picked.dialCode;
        }
      },
      child: SizedBox(
        width: 70,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Obx(
            () => Text(
              thisController.countryCode.isNotEmpty ? '${thisController.countryCode.value} ' : 'Select',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpScreenController extends GetxController {
  final RxBool obscureText = true.obs;
  var countryCode = ''.obs;
}
