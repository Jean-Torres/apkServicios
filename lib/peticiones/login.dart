import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeticionesUsuarios {
  Future<dynamic> autenticarUsuario(String usuario, String contrasenha) async {
    try {
      var uri = Uri.parse(
          "https://apimovil.onrender.com/api/usuarioSesion/userOne/$usuario/$contrasenha");
      final response = await http.get(
        uri,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return jsonEncode({"error": "conexion fallida."});
    }
    return null;
  }
}
