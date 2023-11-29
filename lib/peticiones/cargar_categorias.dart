import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:motors_up/class/categorias.dart';

class PeticionesCategoria {
  static final PeticionesCategoria _peticionesCategoria =
      PeticionesCategoria._internal();

  factory PeticionesCategoria() {
    return _peticionesCategoria;
  }

  PeticionesCategoria._internal();

  String buscarCategoria({required String id, required List<dynamic> datos}) {
    String categoria = "";
    for (var element in datos) {
      if (element["_id"] == id) {
        categoria = element["nombre"].toString();
        break;
      }
    }
    return categoria;
  }

  Future<dynamic> getCategorias() async {
    try {
      final response = await http
          .get(Uri.parse("https://apimovil.onrender.com/api/categorias"));

      if (response.statusCode == 200) {
        archivarCategorias(jsonDecode(response.body));
        return jsonDecode(response.body);
      }
    } catch (e) {
      return jsonEncode({"error": "conexion fallida."});
    }
    return null;
  }

  void archivarCategorias(dynamic n) {
    for (var element in n) {
      Categorias categorias = Categorias();
      categorias.setCategoria(element);
    }
  }
}
