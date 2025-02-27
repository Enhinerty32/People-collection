class ConfigServices {
  int calculateAge(String birthdate) {
  try {
    final birthDate = DateTime.parse(birthdate);
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  } catch (e) {
    print("Error al parsear la fecha de nacimiento: $e");
    return 0;
  }
}
  String formatDate(DateTime date) {
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

}