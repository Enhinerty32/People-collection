import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/widgets/delete_user_widget.dart';
import '../auth/widgets/sign_out_widget.dart';
import '../config/models/person_model.dart';
import '../config/models/user_model.dart';
import '../provider/config_provider.dart';
import '../provider/get_show_db_provider.dart';
import '../widgets/card_person_widget.dart';
import '../auth/providers/validartors_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userdbProvider);
    final peopleAsync = ref.watch(peopledbProvider);

    return Scaffold(
      drawer: _buildDrawer(userAsync),
      appBar: AppBar(title: const Text('People Collection')),
      body: _buildBody(peopleAsync, ref),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTestPerson(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawer(AsyncValue<MyUser?> userAsync) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 150),
          userAsync.when(
            data: (user) => Text('Email: ${user?.email ?? "No disponible"}'),
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const Text('Error cargando usuario'),
          ),
          const Spacer(),
          Row(children: [SignOutWidget(),
          Expanded(child: SizedBox()),
          DeleteUserWidget(),],)
       
        ],
      ),
    );
  }

  Widget _buildBody(AsyncValue<List<Person>> peopleAsync, WidgetRef ref) {
     
    return peopleAsync.when(
      data: (people) => ListView.builder(
          itemCount: people.length + 1,
          itemBuilder: (context, index) {
            if (index == people.length) {
              // print("$index ${people.length}");
              return SizedBox(height: 100);
            }
            return CardPersonWidget(person: people[index], );
          }),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Error cargando personas')),
    );
  }

  void _addTestPerson(BuildContext context, WidgetRef ref) {
    final db = ref.read(dbProviderProvider);
    final formKey = GlobalKey<FormState>();
    final nickController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final countryPicker = const FlCountryCodePicker(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text("Selecciona tu país", style: TextStyle(fontSize: 25)),
      ),
      searchBarDecoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
      ),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agrega una nueva persona'),
        content: _buildDialogContent(formKey, nickController, nameController,
            phoneController, countryPicker, ref, db, context),
      ),
    );
  }

  Widget _buildDialogContent(
      GlobalKey<FormState> formKey,
      TextEditingController nickController,
      TextEditingController nameController,
      TextEditingController phoneController,
      FlCountryCodePicker countryPicker,
      WidgetRef ref,
      dynamic db,
      BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(nickController, 'Apodo',
                FormsValidatorServices().nickValidartor),
            _buildTextField(nameController, 'Nombre',
                FormsValidatorServices().nameValidartor),
            _buildPhoneField(phoneController, countryPicker, ref),
            const SizedBox(height: 16),
            _buildDialogButtons(formKey, nickController, nameController,
                phoneController, ref, db, context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label, border: const OutlineInputBorder()),
        validator: validator,
      ),
    );
  }

  Widget _buildPhoneField(TextEditingController controller,
      FlCountryCodePicker countryPicker, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Celular',
          prefixIcon: ButtonCode(countryPicker: countryPicker),
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.phone,
        validator: (value) {
          final countryCode = ref.read(countryCodeProvider);
          return FormsValidatorServices().phoneValidator(value, countryCode);
        },
      ),
    );
  }

  Widget _buildDialogButtons(
      GlobalKey<FormState> formKey,
      TextEditingController nickController,
      TextEditingController nameController,
      TextEditingController phoneController,
      WidgetRef ref,
      dynamic db,
      BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () => context.pop(), child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final countryCode = ref.watch(countryCodeProvider);
              final newPerson = Person(
                nick: nickController.text,
                name: nameController.text,
                birthdate: DateTime.now().toString(),
                description: '',
                gender: '--',
                phone: "$countryCode ${phoneController.text}",
                socialNet: [ ],
                extras: [ 
                ],
              );
              db.addPerson(newPerson);
              context.pop();
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}

class ButtonCode extends ConsumerWidget {
  const ButtonCode({super.key, required this.countryPicker});

  final FlCountryCodePicker countryPicker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryCode = ref.watch(countryCodeProvider);

    return GestureDetector(
      onTap: () async {
        final picked = await countryPicker.showPicker(
            context: context, backgroundColor: Colors.black);
        if (picked != null) {
          ref.read(countryCodeProvider.notifier).updateValue(picked.dialCode);
        }
      },
      child: Container(
        width: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
        child: Text(countryCode.isNotEmpty ? countryCode : 'Select',
            style: const TextStyle(fontSize: 17)),
      ),
    );
  }
}
