import 'package:flutter/material.dart';
import 'package:motors_up/class/categorias.dart';
import 'package:motors_up/class/validaciones.dart';
import 'package:motors_up/peticiones/cargar_categorias.dart';
import 'package:motors_up/peticiones/cargar_servicios.dart';
import 'package:motors_up/widgets/content_buscador_prin.dart';
import 'package:motors_up/widgets/inicio.dart';

class NuevoServicio extends StatefulWidget {
  final String? idServicio;
  final String? nombreServicio;
  final String? descriocionServicio;
  final String? precioServicio;
  final String? categoriaServicio;
  final String? titulo;
  final String? codigo;
  final Function(String)? callback;

  const NuevoServicio(
      {super.key,
      this.titulo,
      this.nombreServicio,
      this.descriocionServicio,
      this.precioServicio,
      this.categoriaServicio,
      this.idServicio,
      this.codigo,
      this.callback});

  @override
  State<NuevoServicio> createState() => _NuevoServicioState();
}

class _NuevoServicioState extends State<NuevoServicio> {
  @override
  void initState() {
    super.initState();
    cargarCategorias();

    jtNombreCtrl.text = widget.nombreServicio ?? "";
    jtDescirpionCtrl.text = widget.descriocionServicio ?? "";
    jtPrecioCtrl.text = widget.precioServicio ?? "";
    jtCategoriaCtrl.text = widget.categoriaServicio ?? categorias[0];
    jtIdServicioCtrl.text = widget.idServicio ?? "";
    jtCodigoCtrl.text = widget.codigo ?? "";
  }

  TextEditingController jtIdServicioCtrl = TextEditingController();
  TextEditingController jtNombreCtrl = TextEditingController();
  TextEditingController jtDescirpionCtrl = TextEditingController();
  TextEditingController jtPrecioCtrl = TextEditingController();
  TextEditingController jtCategoriaCtrl = TextEditingController();
  TextEditingController jtCodigoCtrl = TextEditingController();
  Validaciones validaciones = Validaciones();
  GlobalKey<FormState> formNuevoRegistro = GlobalKey();

  List<String> categorias = [];

  Future<void> cargarCategorias() async {
    PeticionesCategoria pc = PeticionesCategoria();
    List<dynamic> resul = await pc.getCategorias();
    setState(() {
      categorias = resul.map((dynamic categorias) {
        return categorias["nombre"].toString();
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: 220,
              child: Image(
                image: const AssetImage("assets/imgs/motoServicio.jpeg"),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              )),
          Titulos(
            titulo: widget.titulo ?? "Nuevo servicio",
            ubicacionTitulo: Alignment.center,
            paddingTitulo: 8.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            height: 500,
            child: SingleChildScrollView(
              child: Form(
                  key: formNuevoRegistro,
                  child: Column(
                    children: [
                      Inputs(
                        titulo: "Codigo",
                        labelInput: "codigo",
                        colorFocus: Colors.black,
                        borderRadius: 5,
                        marginInput: 10,
                        controller: jtCodigoCtrl,
                        soloLectura: false,
                        validacion: validaciones.camposNumeros,
                      ),
                      Inputs(
                          titulo: "Nombre",
                          labelInput: "Nombre",
                          colorFocus: Colors.black,
                          borderRadius: 5,
                          marginInput: 10,
                          controller: jtNombreCtrl,
                          validacion: validaciones.camposNumeroTexto),
                      Inputs(
                        titulo: "descricion",
                        labelInput: "Descripción",
                        colorFocus: Colors.black,
                        borderRadius: 5,
                        marginInput: 10,
                        controller: jtDescirpionCtrl,
                        validacion: validaciones.camposNumeroTexto,
                      ),
                      Inputs(
                          titulo: "precio",
                          labelInput: "Precio",
                          colorFocus: Colors.black,
                          borderRadius: 5,
                          tipoInput: TextInputType.datetime,
                          controller: jtPrecioCtrl,
                          validacion: validaciones.camposNumeros),
                      InputSelect(
                          categorias: categorias, controllerC: jtCategoriaCtrl),
                      Buttons(
                        callback: callBack,
                        backgraundButton:
                            const Color.fromRGBO(144, 202, 249, 1),
                      ),
                      if (widget.titulo != "Nuevo servicio")
                        Buttons(
                          callback: eliminarServicio,
                          backgraundButton: const Color.fromARGB(0, 0, 0, 0),
                          titulotButton: "Eliminar Servicio",
                          foregroundButton: Colors.red,
                        ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }

  void guardarDatos() async {
    Categorias categorias = Categorias();
    var datos = {
      "codigo": jtCodigoCtrl.text,
      "nombre": jtNombreCtrl.text,
      "descripcion": jtDescirpionCtrl.text,
      "precio": jtPrecioCtrl.text,
      "categoria": categorias.getCategoria(jtCategoriaCtrl.text)
    };
    PeticionesServicios ps = PeticionesServicios();
    ps.setServicios(datos);
    setState(() {});
    widget.callback!("inicio");
  }

  void actualizarServicio() async {
    Categorias categorias = Categorias();
    var datos = {
      "nombre": jtNombreCtrl.text,
      "descripcion": jtDescirpionCtrl.text,
      "categoria": categorias.getCategoria(jtCategoriaCtrl.text),
      "precio": jtPrecioCtrl.text
    };

    PeticionesServicios ps = PeticionesServicios();
    var response = ps.updateServicios(jtIdServicioCtrl.text, datos);
    // ignore: prefer_typing_uninitialized_variables
    var id;
    await response.then((value) => id = value);

    if (id != null) {
      setState(() {});
      widget.callback!("inicio");
    }
  }

  void eliminarServicio() async {
    _showMyDialog();
  }

  void callBack() {
    if (!formNuevoRegistro.currentState!.validate()) return;

    if (widget.titulo != "Editar Servicio") {
      guardarDatos();
    } else {
      actualizarServicio();
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '¿Estas seguro de eliminar el servicio con el id ${widget.idServicio}}?',
            style: const TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'eliminar',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
              onPressed: () {
                PeticionesServicios ps = PeticionesServicios();
                ps.deleteServicio(widget.idServicio ?? "");
                Navigator.of(context).pop();
                setState(() {});
                widget.callback!("inicio");
              },
            ),
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Buttons extends StatelessWidget {
  final VoidCallback callback;
  final double? widthButton;
  final double? heightButton;
  final String? titulotButton;
  final Color backgraundButton;
  final Color? foregroundButton;
  const Buttons({
    super.key,
    required this.callback,
    this.widthButton,
    this.heightButton,
    this.titulotButton,
    required this.backgraundButton,
    this.foregroundButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 5.0),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: backgraundButton,
        ),
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Text(titulotButton ?? "Guardar",
            style: TextStyle(
                color: foregroundButton ?? Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class InputSelect extends StatefulWidget {
  const InputSelect({
    super.key,
    required this.categorias,
    required this.controllerC,
  });

  final List<String> categorias;
  final TextEditingController controllerC;

  @override
  State<InputSelect> createState() => _InputSelectState();
}

class _InputSelectState extends State<InputSelect> {
  int indexOpcion = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10.0),
      child: DropdownButton(
        value: widget.categorias.isNotEmpty
            ? widget.categorias[widget.controllerC.text.isNotEmpty
                ? widget.categorias.indexOf(widget.controllerC.text)
                : indexOpcion]
            : null,
        items: widget.categorias.map((String categoria) {
          return DropdownMenuItem<String>(
            value: categoria,
            child: Text(categoria),
          );
        }).toList(),
        onChanged: (String? value) {
          indexOpcion = widget.categorias.indexOf(value!);
          widget.controllerC.text = value;
          setState(() {});
        },
        // Stylos
        iconSize: 30,
        elevation: 20,
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
      ),
    );
  }
}
