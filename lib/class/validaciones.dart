class Validaciones {
  String? camposVacios(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "No puede quedar vacío";
    }
    return null;
  }

  String? camposSoloTexto(String? value) {
    if (value == null) {
      return "El valor no puede ser nulo";
    }

    final RegExp textPattern = RegExp(r'^[a-zA-Z]+$');
    if (!textPattern.hasMatch(value.trim())) {
      return "Formato no permitido.";
    }
    return null;
  }

  String? camposNumeroTexto(String? value) {
    if (value == null) {
      return "El valor no puede ser nulo";
    }

    final RegExp textPattern = RegExp(r'^[a-zA-Z0-9]+$');
    if (!textPattern.hasMatch(value.trim())) {
      return "Formato no permitido.";
    }
    return null;
  }

  String? camposNumeros(String? value) {
    if (value == null) {
      return "El valor no puede ser nulo";
    }

    final RegExp textPattern = RegExp(r'^[0-9]+$');
    if (!textPattern.hasMatch(value.trim())) {
      return "Formato no permitido.";
    }
    return null;
  }
}
