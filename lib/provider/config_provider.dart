import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth/providers/0-providers_auth.dart';
import '../config/models/person_model.dart';

part 'config_provider.g.dart';

@riverpod
class CountryCode extends _$CountryCode {
  @override
  String build() {
    return ''; // Código de país predeterminado (puedes ajustarlo según tus necesidades)
  }

  void updateValue(String value) {
    state = value;
  }
}

@riverpod
class EditPerson extends _$EditPerson {
  @override
  Person build(Person person) => person;

  void changeBirthDate(DateTime date) {
    state = state.copyWith(birthdate: date.toString());
  }

  void changeSex(String sex) {
    state = state.copyWith(gender: sex);
  }

  void changeListLink({required String link, required int where}) {
    if (where >= 0 && where < state.socialNet.length) {
      final newSocialNet = List<String>.from(state.socialNet);

      newSocialNet[where] = link;

      state = state.copyWith(socialNet: newSocialNet);
      print(where);
    } else {
      print('Posición fuera de rango');
    }
  }

  void removeListLink({required int where}) {
    // Verificamos que la posición esté dentro del rango de la lista
    if (where >= 0 && where < state.socialNet.length) {
      // Creamos una nueva lista para mantener la inmutabilidad
      final newSocialNet = List<String>.from(state.socialNet);

      // Eliminamos el elemento en la posición específica
      newSocialNet.removeAt(where);

      // Actualizamos el estado usando copyWith
      state = state.copyWith(socialNet: newSocialNet);
    } else {
      print('Posición fuera de rango');
    }
  }

  void addListLink({required String link}) {
    // Creamos una nueva lista para mantener la inmutabilidad
    final newSocialNet = List<String>.from(state.socialNet);

    // Agregamos el nuevo elemento al final de la lista
    newSocialNet.add(link);

    // Actualizamos el estado usando copyWith
    state = state.copyWith(socialNet: newSocialNet);
  }

  void changeText({required String value, required String where}) {
    final countryCode = ref.watch(countryCodeProvider);
    switch (where) {
      case 'nick':
        state = state.copyWith(nick: value);
        break;
      case 'name':
        state = state.copyWith(name: value);
        break;
      case 'description':
        state = state.copyWith(description: value);
        break;
      case 'phone':
        state = state.copyWith(phone: "$countryCode $value");
        break;
    }
  }

  void changeListExtra({required Extra extra, required int where}) {
  if (where >= 0 && where < state.extras.length) {
    final newExtras = List<Extra>.from(state.extras);
    
    newExtras[where] = extra;
    
    state = state.copyWith(extras: newExtras);
    print('Actualizado extra en posición $where');
  } else {
    print('Posición fuera de rango');
  }
}

void removeListExtra({required int where}) {
  // Verificamos que la posición esté dentro del rango de la lista
  if (where >= 0 && where < state.extras.length) {
    // Creamos una nueva lista para mantener la inmutabilidad
    final newExtras = List<Extra>.from(state.extras);
    
    // Eliminamos el elemento en la posición específica
    newExtras.removeAt(where);
    
    // Actualizamos el estado usando copyWith
    state = state.copyWith(extras: newExtras);
    print('Eliminado extra en posición $where');
  } else {
    print('Posición fuera de rango');
  }
}

void addListExtra({required Extra extra}) {
  // Creamos una nueva lista para mantener la inmutabilidad
  final newExtras = List<Extra>.from(state.extras);
  
  // Agregamos el nuevo elemento al final de la lista
  newExtras.add(extra);
  
  // Actualizamos el estado usando copyWith
  state = state.copyWith(extras: newExtras);
  print('Agregado nuevo extra: ${extra.title}');
}
}

// Enum de los tipos de sexo
enum SexType { none, women, man }

// Provider que almacena el estado seleccionado
@Riverpod(keepAlive: true)
class SelectSex extends _$SelectSex {
  @override
  SexType build() => SexType.none;

  void setSexType(SexType sexType) {
    state = sexType;
  }
}
