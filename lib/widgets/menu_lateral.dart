import 'package:flutter/material.dart';
import 'package:motors_up/class/servicios.dart';
import 'package:motors_up/widgets/login.dart';

class MenuLateral extends StatelessWidget {
  final Function(String) onChanged;
  const MenuLateral({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        Column(children: [
          ClipRRect(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 310,
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: Image(
                image: const AssetImage("assets/imgs/moto.jpeg"),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Opcines",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 437,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 0),
              children: [
                OpcionesMenu(
                  icon: const Icon(Icons.miscellaneous_services),
                  titulo: "Servicios",
                  funcion: onChanged,
                  ventana: "inicio",
                ),
                OpcionesMenu(
                  icon: const Icon(Icons.miscellaneous_services),
                  titulo: "Nosotros",
                  funcion: onChanged,
                  ventana: "inicio",
                ),
                OpcionesMenu(
                  icon: const Icon(Icons.miscellaneous_services),
                  titulo: "Nuevo servicio",
                  funcion: onChanged,
                  ventana: "nuevo servicio",
                ),
              ],
            ),
          ),
        ]),
        Positioned(
            child: Column(
          children: [
            const Spacer(),
            OpcionesMenu(
              icon: const Icon(Icons.exit_to_app),
              titulo: "Cerrar sesión",
              colorFondo: (Colors.white),
              funcion: onChanged,
            ),
          ],
        ))
      ]),
    );
  }
}

class OpcionesMenu extends StatefulWidget {
  final String titulo;
  final Icon icon;
  final Color? colorFondo;
  final Function(String) funcion;
  final String? ventana;
  const OpcionesMenu({
    super.key,
    required this.titulo,
    required this.icon,
    this.colorFondo,
    required this.funcion,
    this.ventana,
  });

  @override
  State<OpcionesMenu> createState() => _OpcionesMenuState();
}

class _OpcionesMenuState extends State<OpcionesMenu> {
  void setDatos() {
    Servicios servicio = Servicios();
    servicio.setTituloServicio("Nuevo servicio");
    servicio.setNombreServicio("");
    servicio.setDescripcionServicio("");
    servicio.setPrecioServicio("");
    servicio.setCategoriaServicio("");
    servicio.setTituloServicio("");
    servicio.setCodigoServicio("");
  }

  void cerrarSesion(BuildContext context) {
    if (widget.titulo == "Cerrar sesión") {
      setState(() {});
      Route route = MaterialPageRoute(builder: (bc) => const Login());
      Navigator.of(context).push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        widget.funcion(widget.ventana ?? "inicio"),
        Navigator.pop(context),
        setDatos(),
        cerrarSesion(context)
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.all(20),
          color: widget.colorFondo ?? Colors.blue[50],
          width: double.infinity,
          child: Row(
            children: [
              widget.icon,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.titulo,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ],
          )),
    );
  }
}
