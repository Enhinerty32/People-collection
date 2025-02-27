import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dtp;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:people_colletion_riverpod/config/services/config_services.dart';
import 'package:people_colletion_riverpod/provider/config_provider.dart';
import 'package:people_colletion_riverpod/provider/db_firestore_provider.dart';
import 'package:people_colletion_riverpod/provider/get_show_db_provider.dart';
import 'package:people_colletion_riverpod/widgets/extras_widget.dart';
import '../auth/providers/validartors_provider.dart';
import '../config/models/person_model.dart';
import '../widgets/socialNet_widget.dart';

class EditPersonScreen extends ConsumerWidget {
  EditPersonScreen({super.key, required this.person});
  final Person person;
  final double padding = 5.0;
  final TextEditingController personNick = TextEditingController();
  final TextEditingController personName = TextEditingController();
  final TextEditingController personDescription = TextEditingController();
  final TextEditingController personPhone = TextEditingController();
  final TextEditingController personCode = TextEditingController();
  final TextEditingController personSex = TextEditingController();
  final List<TextEditingController> personListSocialNet = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewPerson = ref.watch(editPersonProvider(person));
    final editPerson = ref.read(editPersonProvider(person).notifier);

    personNick.text = viewPerson.nick;
    personName.text = viewPerson.name;
    personPhone.text =
        viewPerson.phone.substring(viewPerson.phone.indexOf(" ") + 1);
    personCode.text = viewPerson.phone.split(" ")[0];
    personSex.text = viewPerson.gender;
    personDescription.text = viewPerson.description;
    for (int i = 0; i < viewPerson.socialNet.length; i++) {
      personListSocialNet
          .add(TextEditingController(text: viewPerson.socialNet[i]));
    }

    return Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: AppBar(
      title: const Text("Editando"),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              _buildTextFormField(
                controller: personNick,
                editPerson: editPerson,
                label: 'Apodo:',
                where: 'nick',
              ),
              _buildTextFormField(
                controller: personName,
                editPerson: editPerson,
                label: 'Nombre:',
                where: 'name',
              ),
              _buildTextFormFieldPhone(
                controller2: personCode,
                controller: personPhone,
                where: 'phone',
                label: 'Teléfono:',
                value: viewPerson.phone,
                ref: ref,
                editPerson: editPerson,
              ),
              Row(
                children: [
                  SexSelector(title: 'Sexo:', person: person),
                  Expanded(child: SizedBox()),
                  _buildTextContent(
                    context: context,
                    controller: personDescription,
                    editPerson: editPerson,
                    label: 'Descripcion:',
                    where: 'description',
                  ),
                ],
              ),
              _buildTextAge(viewPerson, context, ref, editPerson),
              const Divider(),
            ]),
          ),
            // Divider y título
          
         
          // SocialNetWidget (desplazamiento horizontal)
          SliverToBoxAdapter(
            child: SocialNetWidget(
              socialNetLinks: viewPerson.socialNet,
              onLinkUpdated: (value, key) =>
                  editPerson.changeListLink(link: value, where: key),
              onLinkAdd: (value) => editPerson.addListLink(link: value),
              onLinkDelete: (key) => editPerson.removeListLink(where: key),
            ),
          ),
      
          // Divider y título
          SliverToBoxAdapter(
            child: const Divider(),
          ),
          SliverToBoxAdapter(
            child: _buildSectionTitle('Datos adicionales'),
          ),
      
          // ExtrasWidget (desplazamiento vertical)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300, // Ajusta la altura según sea necesario
              child: ExtrasWidget(
                extras: viewPerson.extras,
                onExtraAdd: (extra) => editPerson.addListExtra(extra: extra),
                onExtraDelete: (index) => editPerson.removeListExtra(where: index),
                onExtraUpdated: (extra, index) =>
                    editPerson.changeListExtra(extra: extra, where: index),
              ),
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async { 
       
        // Agrega aquí la lógica para guardar los cambios
        context.pop();
        ref.read(dbProviderProvider).updatePerson(viewPerson);
         ref.refresh(dbProviderProvider);
      },
      child: const Icon(Icons.save),
    ),
  );
  }

  Card _buildTextAge(Person viewPerson, BuildContext context, WidgetRef ref,
      EditPerson editPerson) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5 + padding),
        child: Row(
          children: [
            _buildInfoRow('Edad:', '${ConfigServices().calculateAge(viewPerson.birthdate)}'),
            Expanded(child: SizedBox()),
            Row(
              children: [
                const Text('Fecha de nacimiento:'),
                TextButton(
                  onPressed: () => _showDatePicker(context, ref, editPerson),
                  child: Text(
                   ConfigServices().formatDate(DateTime.parse(viewPerson.birthdate)),
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required EditPerson editPerson,
    required TextEditingController controller,
    required String label,
    required String where,
  }) {
    TextEditingController ctrl = controller;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: TextFormField(
        controller: ctrl,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          editPerson.changeText(value: value, where: where);
        },
      ),
    );
  }

  Widget _buildTextContent({
    required BuildContext context,
    required EditPerson editPerson,
    required TextEditingController controller,
    required String label,
    required String where,
  }) {
    return ElevatedButton(
        child: Icon(Icons.description),
        onPressed: () {
          TextEditingController dialogController =
              TextEditingController(text: controller.text);

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Editar $label'),
                  content: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      controller: dialogController,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: label,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        dialogController.text = value;
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Cerrar el diálogo sin guardar
                      },
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        editPerson.changeText(
                            value: dialogController.text, where: where);
                        Navigator.of(context)
                            .pop(); // Cerrar el diálogo después de guardar
                      },
                      child: Text('Guardar'),
                    ),
                  ],
                );
              });
        });
  }

  Widget _buildTextFormFieldPhone(
      {required EditPerson editPerson,
      required String label,
      required String where,
      required String value,
      required TextEditingController controller,
      required TextEditingController controller2,
      required WidgetRef ref}) {
    final countryPicker = const FlCountryCodePicker(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text("Selecciona tu país", style: TextStyle(fontSize: 25)),
      ),
      searchBarDecoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
      ),
    );

    final code = controller2;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: ButtonCode(
            countryPicker: countryPicker,
            code: code,
          ),
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.phone,
        validator: (value) {
          final countryCode = ref.read(countryCodeProvider);
          return FormsValidatorServices().phoneValidator(value, countryCode);
        },
        onChanged: (value) {
          editPerson.changeText(value: value, where: where);
        },
      ),
    );
  }

  Widget _buildTextFormFieldContent(String label, String value) {
    final controller = TextEditingController(text: value);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text('$label $value'),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildExtraItem(BuildContext context, Extra extra) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        style: TextButton.styleFrom(alignment: Alignment.centerLeft),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(extra.title, maxLines: 4),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(extra.description),
              ),
            ),
          );
        },
        child: Text(extra.title, maxLines: 4),
      ),
    );
  }

  void _showDatePicker(
      BuildContext context, WidgetRef ref, EditPerson editPersonNotifier) {
    dtp.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      theme: dtp.DatePickerTheme(
        cancelStyle: const TextStyle(color: Colors.red),
        backgroundColor: Colors.black,
        itemStyle: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      onChanged: (date) => print('change $date'),
      onConfirm: (date) {
        print('confirm $date');
        editPersonNotifier.changeBirthDate(date);
      },
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime.now(),
      currentTime: DateTime.now(),
      locale: dtp.LocaleType.es,
    );
  }
}

 

class ButtonCode extends ConsumerWidget {
  const ButtonCode(
      {required this.code, super.key, required this.countryPicker});
  final FlCountryCodePicker countryPicker;
  final TextEditingController code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryCode = ref.watch(countryCodeProvider);
    Future.delayed(Duration.zero, () {
      if (countryCode.isEmpty && code.text.isNotEmpty) {
        ref.read(countryCodeProvider.notifier).updateValue(code.text);
      }
    });

    return GestureDetector(
      onTap: () async {
        final picked = await countryPicker.showPicker(
          context: context,
          backgroundColor: Colors.black,
        );
        if (picked != null) {
          code.text = picked.dialCode;
          ref.read(countryCodeProvider.notifier).updateValue(picked.dialCode);
        }
      },
      child: Container(
        width: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
        child: Text(
          countryCode.isNotEmpty ? countryCode : 'Select',
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}

class SexSelector extends ConsumerStatefulWidget {
  final Person person;
  final String title;

  const SexSelector({required this.person, required this.title, super.key});

  @override
  _SexSelectorState createState() => _SexSelectorState();
}

class _SexSelectorState extends ConsumerState<SexSelector> {
  bool initialized = false;

  SexType _mapStringToSexType(String sex) {
    switch (sex.toLowerCase()) {
      case 'mujer':
        return SexType.women;
      case 'hombre':
        return SexType.man;
      default:
        return SexType.none;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) {
      initialized = true;
      Future.delayed(Duration.zero, () {
        final initialSexType = _mapStringToSexType(widget.person.gender);
        ref.read(selectSexProvider.notifier).setSexType(initialSexType);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sexType = ref.watch(selectSexProvider);

    ref.listen(selectSexProvider, (_, newSexType) {
      final newSex = newSexType == SexType.man
          ? 'Hombre'
          : newSexType == SexType.women
              ? 'Mujer'
              : '--';

      ref.read(editPersonProvider(widget.person).notifier).changeSex(newSex);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<SexType>(
          segments: [
            ButtonSegment(value: SexType.none, label: const Text('--')),
            ButtonSegment(value: SexType.man, label: const Icon(Icons.male)),
            ButtonSegment(
                value: SexType.women, label: const Icon(Icons.female)),
          ],
          selected: {sexType},
          onSelectionChanged: (Set<SexType> value) {
            if (value.isNotEmpty) {
              ref.read(selectSexProvider.notifier).setSexType(value.first);
            }
          },
        ),
      ],
    );
  }
}
