import 'package:flutter/cupertino.dart';

import '../../Models/unit_model.dart';

class UnitsManager extends ChangeNotifier {
  //** -------------------------------------------------------- **//
  static final UnitsManager instancia = UnitsManager._internal();
  factory UnitsManager() {
    return instancia;
  }
  UnitsManager._internal();
  //** -------------------------------------------------------- **//

  Set<int> selectedIds = {};
  bool isChecked = false;
  bool _isError = false;

  bool get isError => _isError;

  List<UnitModel> units = [];
  List<UnitModel> allUnits = [];

  void selectedUnits(int id) {
    if(selectedIds.contains(id)){
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    print("--- TOTAL UNTIS SELECTED: ${selectedIds.length}");
    notifyListeners();
  }

  void quitarSelectedUnits() {
    selectedIds = {};
    selectedIds.clear();
    notifyListeners();
  }

  void selectAll(List<UnitModel> units, bool value) {
    isChecked = value;
    for(UnitModel unit in units) {
      selectedIds.add(int.parse(unit.id_gps!));
    }
    notifyListeners();
  }

  // --- Metodos para busqueda ---- //
  search(String query) {
    if(query.isEmpty) {
      units = allUnits;
    } else {
      units = allUnits.where((f) => f.placa!.toLowerCase().contains(query.toLowerCase())
      || f.id!.toString().contains(query)).toList();
    }
    notifyListeners();
  }

  resetSearchText() {
    units = allUnits;
  }

  resetSelected(bool value) {
    if(value) {
      isChecked = value;
    }
  }

  void setOnError(bool value) {
    _isError = value;
    notifyListeners();
  }
}