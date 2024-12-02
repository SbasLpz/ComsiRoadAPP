import 'dart:async';

import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:app_rutas_comsi/Service/comsi_api.dart';
import 'package:flutter/cupertino.dart';

class MapManager extends ChangeNotifier {
  /// Singleton para que en cualquier llamada se accedan a los mismos datos
  // ------- Instancia unica compartida - Singleton ------
  static final MapManager instancia = MapManager._internal();
  factory MapManager() {
    return instancia;
  }
  MapManager._internal();
  // ------- Instancia unica compartida - Singleton ------

  List<UnitModel> listUnits = [];
  var count = 0;
  /// Bool que controla cuando las actaulizaciones de ubicacion se debene ejcutar y cuando no
  var stopTimer = false;

  /// Metodo que ejecuta el request de la posicion de las unidades a la API
  excuteRequest() async {
    print("******Provider Manager: Se actalizo la data de los marcadores");
    listUnits = await postUnits();
    count++;
    notifyListeners();
  }

  /// Metodo con Timer para ejecutar la Consulta de posicionamiento de las unidades
  /// cada 10 segundos simepre y cuando la variable StopTimer este en False.
  ///
  intervalUpdates() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if(stopTimer) {
        timer.cancel();
      } else {
        print("Unista LOCATION update done.");
        excuteRequest();
      }
    });
  }
}