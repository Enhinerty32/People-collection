class FormsValidatorServices {
  
  String? emailValidator(String? value) {
    String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'El correo es obligatorio';
    } else if (!regExp.hasMatch(value)) {
      return 'Introduce un correo válido';
    }
    return null;
  }

  String? passwordValidartor(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria';
    } else if (value.length <= 8) {
      return 'La contraseña debe tener más de 8 caracteres';
    }
    return null;
  }

  String? nameValidartor(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre es obligatorio';
    }
    return null;
  }
  String? nickValidartor(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre es obligatorio';
    }
    return null;
  }

    String? phoneValidator(String? value ,String countryCodeController) {
    if (value == null || value.isEmpty) {
      return 'El número es obligatorio';
    } else if (countryCodeController.isEmpty) {
      return 'Selecciona el código de región';
    } else if (value.length > 12) {
      return 'Demasiado largo, mayor a 12 dígitos';
    } else if (value.length < 4) {
      return 'Demasiado corto, menor a 4 dígitos';
    }
    return null;
  }

}