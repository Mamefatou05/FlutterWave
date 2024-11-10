class Validators {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le numéro de téléphone est requis';
    }
    if (!RegExp(r'^\+?[0-9]{9,14}$').hasMatch(value)) {
      return 'Numéro de téléphone invalide';
    }
    return null;
  }

  static String? validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le code PIN est requis';
    }
    if (value.length != 4) {
      return 'Le code PIN doit contenir 4 chiffres';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Le code PIN doit contenir uniquement des chiffres';
    }
    // Vérifie les chiffres consécutifs
    for (int i = 0; i < 3; i++) {
      if (int.parse(value[i + 1]) == int.parse(value[i]) + 1) {
        return 'Les chiffres ne doivent pas être consécutifs';
      }
    }
    // Vérifie les chiffres répétitifs
    if (RegExp(r'(\d)\1').hasMatch(value)) {
      return 'Les chiffres ne doivent pas être répétitifs';
    }
    return null;
  }
}