import 'package:flutter/material.dart';
import 'package:motors_up/class/validaciones.dart';
import 'package:motors_up/peticiones/login.dart';
import 'package:motors_up/principal.dart';
import 'package:motors_up/widgets/content_buscador_prin.dart';
import 'package:motors_up/widgets/nuvo_servicio.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Validaciones validaciones = Validaciones();
  TextEditingController tUsuarioCtrl = TextEditingController();
  TextEditingController tContrasenhaCtrl = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 540,
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 200,
                          height: 200,
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          child: const Image(
                            image: AssetImage("assets/imgs/motoLogo.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Inputs(
                        titulo: "Usuario",
                        labelInput: "Usuario",
                        colorFocus: Colors.black,
                        marginInput: 10,
                        controller: tUsuarioCtrl,
                        validacion: validaciones.camposVacios,
                      ),
                      Inputs(
                        titulo: "Contraseña",
                        labelInput: "Contraseña",
                        colorFocus: Colors.black,
                        marginInput: 10,
                        controller: tContrasenhaCtrl,
                        validacion: validaciones.camposVacios,
                      ),
                      Buttons(
                          callback: login,
                          backgraundButton:
                              const Color.fromRGBO(144, 202, 249, 1)),
                      Buttons(
                        callback: () {},
                        backgraundButton: const Color.fromARGB(0, 0, 0, 0),
                        titulotButton: "Nuervo usuario",
                        foregroundButton: Colors.blue,
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (!formKey.currentState!.validate()) return;
    PeticionesUsuarios pu = PeticionesUsuarios();
    var response =
        pu.autenticarUsuario(tUsuarioCtrl.text, tContrasenhaCtrl.text);

    // ignore: prefer_typing_uninitialized_variables
    var token;
    await response.then((value) => token = value);

    tUsuarioCtrl.clear();
    tContrasenhaCtrl.clear();
    try {
      if (await token["token"] != null) {
        Route route = MaterialPageRoute(builder: (bc) => const Principal());
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(route);
      }
      // ignore: empty_catches
    } catch (e) {}
  }
}
