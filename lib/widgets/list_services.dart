import 'package:flutter/material.dart';
import 'package:motors_up/class/servicios.dart';
import 'package:motors_up/peticiones/cargar_servicios.dart';

class ListaServicios extends StatefulWidget {
  final Function(String) funcion;
  const ListaServicios({super.key, required this.funcion});

  @override
  State<ListaServicios> createState() => _ListaServiciosState();
}

class _ListaServiciosState extends State<ListaServicios> {
  void setDatos(dynamic element) {
    try {
      Servicios servicio = Servicios();
      servicio.setIdServicio(element["_id"]);
      servicio.setCodigoServicio(element["codigo"]);
      servicio.setNombreServicio(element["nombre"]);
      servicio.setDescripcionServicio(element["descripcion"]);
      servicio.setPrecioServicio(element["precio"].toString());
      servicio.setCategoriaServicio(element["categoria"]["nombre"]);
      servicio.setTituloServicio("Editar Servicio");
      // ignore: empty_catches
    } catch (e) {}
  }

  final PeticionesServicios ps = PeticionesServicios();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: ps.getServicios(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                  child: ListView(
                children: servicios(snapshot.data, context),
              ))
            ],
          );
        }
        return const Text("Sin datos");
      },
    );
  }

  List<Widget> servicios(List<dynamic> infom, BuildContext context) {
    List<Widget> servicio = [];

    for (var element in infom) {
      servicio.add(
        GestureDetector(
          onTap: () => {
            widget.funcion("nuevo servicio"),
            setDatos(element),
          },
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Card(
                child: Column(
                  children: [
                    const Image(
                        image: AssetImage("assets/imgs/motoHerramienta.jpeg")),
                    SizedBox(
                      height: 65,
                      child: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 180,
                              height: 90,
                              child: Column(
                                children: [
                                  CaracteristicaServicio(
                                    titulo: element["nombre"],
                                    subTitulo: element["descripcion"] ??
                                        "sin descripcion",
                                  ),
                                ],
                              )),
                          SizedBox(
                              width: 140,
                              height: 90,
                              child: Column(
                                children: [
                                  CaracteristicaServicio(
                                    titulo: "Precio:",
                                    directionTitulo: TextAlign.right,
                                    subTitulo: "\$${element["precio"]}",
                                    directionSubTitulo: TextAlign.right,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      );
    }
    return servicio;
  }
}

class CaracteristicaServicio extends StatelessWidget {
  final String titulo;
  final String subTitulo;
  final TextAlign? directionTitulo;
  final TextAlign? directionSubTitulo;
  final double? fontSizeTitulo;
  const CaracteristicaServicio({
    super.key,
    required this.titulo,
    required this.subTitulo,
    this.directionTitulo,
    this.directionSubTitulo,
    this.fontSizeTitulo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListTile(
        title: Text(
          titulo,
          textAlign: directionTitulo ?? TextAlign.left,
          style: TextStyle(fontSize: fontSizeTitulo ?? 18),
        ),
        subtitle: Text(
          subTitulo,
          textAlign: directionTitulo ?? TextAlign.left,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
