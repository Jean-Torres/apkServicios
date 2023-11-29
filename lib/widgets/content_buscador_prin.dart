import 'package:flutter/material.dart';
import 'package:motors_up/class/validaciones.dart';

class BuscadorPrincipal extends StatefulWidget {
  final Function(String) callback;
  const BuscadorPrincipal({super.key, required this.callback});

  @override
  State<BuscadorPrincipal> createState() => _BuscadorPrincipalState();
}

class _BuscadorPrincipalState extends State<BuscadorPrincipal> {
  Validaciones validaciones = Validaciones();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: const BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.zero,
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
      child: SizedBox(
        height: 200,
        child: Column(children: [
          SizedBox(
              height: 140,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.all(20.0)),
                  Expanded(
                    child: Inputs(
                      titulo: "Search",
                      labelInput: "Search",
                      borderRadius: 30,
                      validacion: validaciones.camposNumeroTexto,
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              )),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width - 20,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                TargetDatos(
                  titulo: "Fecha hoy",
                  subTitulo:
                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  fontSize: 16,
                ),
                const Spacer(),
                TargetDatos(
                  titulo: "Servicio del dia",
                  subTitulo: "Cambio de aceite",
                  fontSize: 18,
                  widthTarget: MediaQuery.of(context).size.width / 2.4,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class TargetDatos extends StatelessWidget {
  final String titulo;
  final String subTitulo;
  final Color? colorFondo;
  final double? widthTarget;
  final double? fontSize;
  const TargetDatos({
    super.key,
    this.colorFondo,
    required this.titulo,
    required this.subTitulo,
    this.widthTarget,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthTarget ?? MediaQuery.of(context).size.width / 2.5,
      margin: const EdgeInsets.all(2),
      color: colorFondo ?? Colors.white,
      child: Column(children: [
        const SizedBox(
          width: 0,
          height: 20,
        ),
        Text(
          titulo,
          style: TextStyle(fontSize: fontSize ?? 18, color: Colors.grey),
        ),
        const Spacer(),
        Text(
          subTitulo,
          style: TextStyle(fontSize: fontSize ?? 25),
        ),
        const SizedBox(
          height: 10,
        )
      ]),
    );
  }
}

class Inputs extends StatelessWidget {
  final String titulo;
  final Color? colorFocus;
  final double? borderRadius;
  final TextInputType? tipoInput;
  final String? labelInput;
  final double? marginInput;
  final TextEditingController? controller;
  final bool? soloLectura;
  final VoidCallback? callBack;
  final String? Function(String?)? validacion;

  const Inputs({
    super.key,
    required this.titulo,
    this.colorFocus,
    this.borderRadius,
    this.tipoInput,
    this.labelInput,
    this.marginInput,
    this.controller,
    this.soloLectura,
    this.callBack,
    required this.validacion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginInput ?? 2.2),
      child: TextFormField(
        readOnly: soloLectura ?? false,
        controller: controller,
        style: const TextStyle(fontSize: 22, letterSpacing: 1.5),
        decoration: InputDecoration(
            label: Text(labelInput ?? ""),
            hintText: titulo,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorFocus ?? Colors.white),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 10))),
            border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 10)))),
        keyboardType: tipoInput ?? TextInputType.text,
        validator: validacion,
      ),
    );
  }
}
