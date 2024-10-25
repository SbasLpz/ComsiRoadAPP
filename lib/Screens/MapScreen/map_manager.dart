import 'package:app_rutas_comsi/Models/unit_model.dart';
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
}