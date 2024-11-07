import 'dart:async';

import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:app_rutas_comsi/Service/comsi_api.dart';
import 'package:flutter/cupertino.dart';

class MapManager extends ChangeNotifier {
  // ------- Instancia unica compartida - Singleton ------
  static final MapManager instancia = MapManager._internal();
  factory MapManager() {
    return instancia;
  }
  MapManager._internal();
  // ------- Instancia unica compartida - Singleton ------

  List<UnitModel> listUnits = [];
  var count = 0;
  var stopTimer = false;

  excuteRequest() async {
    print("******Provider Manager: Se actalizo la data de los marcadores");
    listUnits = await postUnits();
    count++;
    notifyListeners();
  }

  intervalUpdates() {
    Timer.periodic(Duration(seconds: 10), (timer) {
      if(stopTimer) {
        timer.cancel();
      } else {
        print("Unista LOCATION update done.");
        excuteRequest();
      }
    });
  }
}