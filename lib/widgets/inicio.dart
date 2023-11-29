import 'package:flutter/material.dart';
import 'package:motors_up/widgets/content_buscador_prin.dart';
import 'package:motors_up/widgets/list_services.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key, required this.funcion});
  final Function(String) funcion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 260,
          child: BuscadorPrincipal(callback: funcion),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Titulos(titulo: "Servicios"),
        ),
        SizedBox(
          height: 450,
          child: ListaServicios(funcion: funcion),
        )
      ],
    );
  }
}

class Titulos extends StatelessWidget {
  final String titulo;
  final Alignment? ubicacionTitulo;
  final double? paddingTitulo;
  const Titulos({
    super.key,
    required this.titulo,
    this.ubicacionTitulo,
    this.paddingTitulo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingTitulo ?? 0.0),
      child: Container(
        alignment: ubicacionTitulo ?? Alignment.centerLeft,
        child: Text(
          titulo,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
