import 'package:flutter/material.dart';
import 'package:motors_up/class/servicios.dart';
import 'package:motors_up/widgets/inicio.dart';
import 'package:motors_up/widgets/menu_lateral.dart';
import 'package:motors_up/widgets/nuvo_servicio.dart';
import 'package:motors_up/delegetes/busqueda.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  Servicios servicio = Servicios();
  String selectedOption = 'Inicio';

  String id = "";
  String codigo = "";
  String nombre = "";
  String descripcion = "";
  String precio = "";
  String categoria = "";
  String titulo = "";

  void selectDrawerOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  void datosActualizar() {
    id = servicio.getIdServicio().isNotEmpty ? servicio.getIdServicio() : "";
    codigo = servicio.getCodigoServicio().isNotEmpty
        ? servicio.getCodigoServicio()
        : "";
    nombre = servicio.getNombreServicio().isNotEmpty
        ? servicio.getNombreServicio()
        : "";
    descripcion = servicio.getDescripcionServicio().isNotEmpty
        ? servicio.getDescripcionServicio()
        : "";
    precio = servicio.getPrecioServicio().isNotEmpty
        ? servicio.getPrecioServicio()
        : "";
    categoria = servicio.getCategoriaServicio().isNotEmpty
        ? servicio.getCategoriaServicio()
        : "";
    titulo = servicio.getTituloServicio().isNotEmpty
        ? servicio.getTituloServicio()
        : "Nuevo servicio";
  }

  Widget buildBody() {
    switch (selectedOption) {
      case "inicio":
        return Inicio(funcion: selectDrawerOption);
      case "nuevo servicio":
        datosActualizar();
        return NuevoServicio(
          idServicio: id,
          codigo: codigo,
          titulo: titulo,
          nombreServicio: nombre,
          descriocionServicio: descripcion,
          precioServicio: precio,
          categoriaServicio: categoria,
          callback: selectDrawerOption,
        );
    }
    return Inicio(funcion: selectDrawerOption);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          drawer: MenuLateral(
            onChanged: selectDrawerOption,
          ),
          appBar: AppBar(
            title: const Text("Motors Up"),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: BusquedaServicios(
                          servicio.getServicio(), selectDrawerOption));
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: SingleChildScrollView(child: buildBody())),
    );
  }
}