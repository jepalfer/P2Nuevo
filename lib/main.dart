import 'package:flutter/material.dart';

import 'package:p2_tienda_muebles/mesa.dart';
import 'package:p2_tienda_muebles/mesaCocina.dart';
import 'package:p2_tienda_muebles/mesaOficina.dart';
import 'package:p2_tienda_muebles/tienda.dart';
import 'package:p2_tienda_muebles/tiendaCocina.dart';
import 'package:p2_tienda_muebles/tiendaOficina.dart';
import 'package:p2_tienda_muebles/factoriaMuebles.dart';
import 'package:p2_tienda_muebles/factoriaTiendaMesaCocina.dart';
import 'package:p2_tienda_muebles/factoriaTiendaMesaOficina.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'dart:math';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda de muebles Hnos. Pérez',
      home: const MyHomePage(title: 'Tienda de muebles Hnos. Pérez'),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counterOficina = 0,
      _counterCocina = 0;
  int _stockOficina = 0,
      _stockCocina = 0,
      _idMuebleCocina = 0,
      _idMuebleOficina = 0;
  double _costeOficina = 199,
      _costeCocina = 150,
      _saldo = 1000;

  FactoriaMuebles factoriaGeneral = FactoriaTiendaMesaCocina();

  void _incrementCounterOficina() {
    _counterOficina++;
    setState(() {
      _stockOficina --;
    });
  }

  void _incrementCounterCocina() {
    setState(() {
      _counterCocina++;
      setState(() {
        _stockCocina--;
      });
    });
  }

  int _sell(double cost) {
    if (_saldo - cost >= 0) {
      _saldo -= cost;
      return 1;
    }
    else {
      return 0;
    }
  }

  void _popUpStock(BuildContext contexto) {
    showDialog(
      context: contexto,
      builder: (BuildContext contexto) {
        return AlertDialog(
          title: Text('¡No hay suficiente stock!'),
          content: Text('El tipo de mesa que desea comprar no está disponible de momento'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _popUpCost(BuildContext contexto) {
    showDialog(
      context: contexto,
      builder: (BuildContext contexto) {
        return AlertDialog(
          title: Text('¡No hay suficiente dinero!'),
          content: Text(
              'No dispones del dinero suficiente para comprar la mesa que quieres'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _createOficina() {
    Mesa mesa = factoriaGeneral.crearMesa(_idMuebleOficina);
    _idMuebleOficina ++;
    setState(() {
      _stockOficina ++;
    });
  }

  void _createCocina() {
    Mesa mesa = factoriaGeneral.crearMesa(_idMuebleCocina);
    _idMuebleCocina ++;
    setState(() {
      _stockCocina ++;
    });
  }


  void _reset() {
    setState(() {
      _counterOficina = 0;
      _counterCocina = 0;
      _idMuebleCocina = 0;
      _idMuebleOficina = 0;
      _stockOficina = 0;
      _stockCocina = 0;
      _saldo = 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/mesa-cocina-libro-nube-1_cerrada.jpg', width: 500, height: 400),
                      const SizedBox(height: 2),
                      Text('Has comprado ${_counterCocina.toString()} mesas de cocina y hay ${_stockCocina.toString()} mesas de cocina disponibles\n'),

                      ElevatedButton(
                        onPressed: () {
                          _createCocina();
                        },
                        child: Text('Crear mesa de cocina'),
                      ),
                      Text('\n'),
                      ElevatedButton(
                        onPressed: () {
                          if (_stockCocina == 0) {
                            _popUpStock(context);
                          }
                          else if (_sell(_costeCocina) == 0) {
                            _popUpCost(context);
                          }
                          else {
                            _incrementCounterCocina();
                          }
                        },
                        child: Text('Comprar mesa de cocina (${_costeCocina.toString()}€)'),
                      ),
                      Text('\n'),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/mesaOficina.jpg', width: 500, height: 400),
                      const SizedBox(height: 2),
                      Text('Has comprado ${_counterOficina.toString()} mesas de oficina y hay ${_stockOficina.toString()} mesas de oficina disponibles'),
                      ElevatedButton(
                        onPressed: () {
                          _createOficina();
                        },
                        child: Text('Crear mesa de oficina'),
                      ),
                      Text('\n'),
                      ElevatedButton(
                        onPressed: () {
                          if (_stockOficina == 0) {
                            _popUpStock(context);
                          }
                          else if (_sell(_costeOficina) == 0) {
                            _popUpCost(context);
                          }
                          else {
                            _incrementCounterOficina();
                          }
                        },
                        child: Text('Comprar mesa de oficina (${_costeOficina.toString()}€)'),
                      ),
                      Text('\n'),
                    ],
                  ),
                ],
              ),
              Text('\nDispones de ${_saldo.toString()} €'),
              ElevatedButton(
                onPressed: () {
                  _reset();
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}