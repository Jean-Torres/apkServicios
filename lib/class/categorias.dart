class Categorias {
  final List<dynamic> _categorias = [];

  static Categorias? _instance;
  Categorias._internal();

  factory Categorias() {
    _instance ??= Categorias._internal();
    return _instance!;
  }

  void setCategoria(dynamic categorias) {
    _categorias.add(categorias);
  }

  String? getCategoria(String nombre) {
    for (var i = 0; i < _categorias.length; i++) {
      if (_categorias[i]["nombre"] == nombre) {
        return _categorias[i]["_id"];
      }
    }

    return null;
  }
}
