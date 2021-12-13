import 'package:flutter/material.dart';
import 'package:app/services/person_data.dart';
// import 'package:app/main.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  // const ({ Key? key }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //controller para obtener el nro de cédula del textfiel
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Color personalColor = Color(0xff00B0EB);
  @override
  void initState() {
    super.initState();
    Global.pages = 0;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: personalColor, // status bar color
    ));
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(25),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/personal.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  'VERIFICACIÓN DE PERSONAS',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Text(
                      'Ingrese el número de documento',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                      // textAlign: TextAlign.center,
                    ),
                    Text(
                      'para validar los datos del',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                      // textAlign: TextAlign.center,
                    ),
                    Text(
                      'ciudadano',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                      // textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.only(bottom: 25),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => showInputDialog(context).then((ciValue) {
                    myController.text = ''; //Limpiar textfield
                    ciValue = ciValue.replaceAll(' ', ''); //Remove white spaces
                    RegExp regexp =
                        RegExp(r'^[0-9]*$'); //Para validación de sólo números
                    if (!regexp.hasMatch(ciValue)) {
                      showAlert();
                    } else if (ciValue != false && ciValue != '') {
                      Global.ci = ciValue;
                      Navigator.pushNamed(context, '/loading');
                    }
                  }),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'INGRESAR ',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: personalColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showInputDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ingrese Nro. de Cédula'),
            content: TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                labelText: 'Ingrese Cédula',
                contentPadding: EdgeInsets.only(left: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              controller: myController,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: personalColor,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    return Navigator.pop(context, myController.text.toString());
                  },
                  child: Text(
                    'Aceptar',
                    style: TextStyle(
                      color: personalColor,
                    ),
                  ))
            ],
          );
        });
  }

// MOSTRAR ALERT DIALOG CUANDO SE INGRESAN MAL LOS DATOS
  showAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Timer(Duration(milliseconds: 700), () {
            Navigator.pop(context);
          });
          return AlertDialog(
            title: Center(child: Text('Ingrese sólo números')),
          );
        });
  }
}
