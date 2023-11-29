import 'package:flutter/material.dart';
import 'package:motors_up/class/servicios.dart';

class BusquedaServicios extends SearchDelegate {
  List<dynamic> datos;
  List<dynamic> _filter = [];
  final Function(String) callback;
  BusquedaServicios(this.datos, this.callback);

  @override
  String get searchFieldLabel => 'Buscar servicio';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (
        _,
        int index,
      ) {
        return ListTile(
          title: Text(_filter[index]['nombre']),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = datos
        .where((element) =>
            element["nombre"].toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (
        _,
        int index,
      ) {
        return GestureDetector(
          onTap: () {
            try {
              Servicios servicio = Servicios();
              servicio.setTituloServicio("Editar Servicio");
              servicio.setIdServicio(_filter[index]["_id"]);
              servicio.setCodigoServicio(_filter[index]["codigo"]);
              servicio.setNombreServicio(_filter[index]["nombre"]);
              servicio.setDescripcionServicio(_filter[index]["descripcion"]);
              servicio.setPrecioServicio(_filter[index]["precio"].toString());
              servicio
                  .setCategoriaServicio(_filter[index]["categoria"]["nombre"]);

              callback("nuevo servicio");
              Navigator.pop(context);
            // ignore: empty_catches
            } catch (e) {}
          },
          child: ListTile(
            title: Text(_filter[index]['nombre']),
            subtitle: Text(_filter[index]['precio'].toString()),
          ),
        );
      },
    );
  }
}
