class Servicios {
  String _nombreServicio = "";
  String _descripcionServicio = "";
  String _precioServicio = "";
  String _categoriaServicio = "";
  String _tituloOperacion = "";
  String _codigoServicio = "";
  String _idServicio = "";
  List<dynamic> _servicios = [];

  static Servicios? _instance;
  Servicios._internal();

  factory Servicios() {
    _instance ??= Servicios._internal();
    return _instance!;
  }

  void setNombreServicio(String nombreServicio) {
    _nombreServicio = nombreServicio;
  }

  void setDescripcionServicio(String descripcionServicio) {
    _descripcionServicio = descripcionServicio;
  }

  void setPrecioServicio(String precioServicio) {
    _precioServicio = precioServicio;
  }

  void setCategoriaServicio(String categoriaServicio) {
    _categoriaServicio = categoriaServicio;
  }

  void setTituloServicio(String tituloServicio) {
    _tituloOperacion = tituloServicio;
  }

  void setCodigoServicio(String codigoServicio) {
    _codigoServicio = codigoServicio;
  }

  void setIdServicio(String idServicio) {
    _idServicio = idServicio;
  }

  void setServicios(dynamic servicio) {
    _servicios.add(servicio);
  }

  void resetServicios() {
    _servicios = [];
  }

  String getNombreServicio() {
    return _nombreServicio;
  }

  String getDescripcionServicio() {
    return _descripcionServicio;
  }

  String getPrecioServicio() {
    return _precioServicio;
  }

  String getCategoriaServicio() {
    return _categoriaServicio;
  }

  String getTituloServicio() {
    return _tituloOperacion;
  }

  String getCodigoServicio() {
    return _codigoServicio;
  }

  String getIdServicio() {
    return _idServicio;
  }

  List<dynamic> getServicio() {
    return _servicios;
  }
}
