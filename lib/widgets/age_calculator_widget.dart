
String calculateAge(String birthDateString) {
  try {
    // Parsear la fecha de nacimiento
    DateTime birthDate = DateTime.parse(birthDateString);
    DateTime now = DateTime.now();

    // Calcular la diferencia en años
    int years = now.year - birthDate.year;

    // Ajustar si el cumpleaños no ha pasado aún este año
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      years--;
    }

    return "$years";
  } catch (e) {
    return 'Inválido!!!';
  }
}
