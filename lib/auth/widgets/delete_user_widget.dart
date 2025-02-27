 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:people_colletion_riverpod/auth/providers/0-providers_auth.dart';

class DeleteUserWidget extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthFirebaseProvider _authFirebaseProvider = AuthFirebaseProvider();
  final FormsValidatorServices _formsValidator = FormsValidatorServices();

  DeleteUserWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => _showDeleteDialog(context, ref),
    
      icon: const Icon(Icons.delete, color: Colors.red),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, WidgetRef ref) async {
    await showDialog(
      context: context,
      builder: (context) => Form(
        key: _formKey,
        child: AlertDialog(
          title: const Text('¿Estás seguro de que quieres eliminar la cuenta?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                controller: _emailController,
                labelText: 'Correo electrónico',
                validator: _formsValidator.emailValidator,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Contraseña',
                validator: _formsValidator.passwordValidartor,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _deleteAccount(context, ref),
                  child: const Text('Eliminar'),
                ),
                TextButton(
                  onPressed: () {
                    cleanText();
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
 
  Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState?.validate() != true) {
      _showErrorSnackBar(context, 'Error en el registro');
      return;
    }

    try {
      await _authFirebaseProvider.deleteUser(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (_authFirebaseProvider.auth.currentUser == null) {
        cleanText();
        ref.read(appPrincipalRouterProvider).pop();
        ref.read(appPrincipalRouterProvider.notifier).closeAccessibility();
        ref.read(appPrincipalRouterProvider).go('/');

        if (context.mounted) {
          _showSuccessSnackBar(context, 'Usuario eliminado con éxito');
        }
      } else {
        _showErrorSnackBar(context, 'Error al eliminar la cuenta');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error inesperado: $e');
    }
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  void cleanText() {
    _emailController.clear();
    _passwordController.clear();
  }
}