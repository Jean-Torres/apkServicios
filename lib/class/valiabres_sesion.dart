class Valiabres {
  var _token = "";

  static Valiabres? _instance;
  Valiabres._internal();

  factory Valiabres() {
    _instance ??= Valiabres._internal();
    return _instance!;
  }

  void setToken(var toke) {
    _token = toke;
  }

  dynamic getToke() {
    return _token;
  }
}
