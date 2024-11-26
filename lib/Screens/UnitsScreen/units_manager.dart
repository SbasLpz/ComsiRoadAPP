import 'package:flutter/cupertino.dart';

import '../../Models/unit_model.dart';

class UnitsManager extends ChangeNotifier {

  /** Singleton para que en cualquier llamada se accedan a los mismos datos  */
  //** -------------------------------------------------------- **//
  static final UnitsManager instancia = UnitsManager._internal();
  factory UnitsManager() {
    return instancia;
  }
  UnitsManager._internal();
  //** -------------------------------------------------------- **//

  /** Set que contiene los ID de las unidades seleccionadas por el usuario */
  Set<int> selectedIds = {};
  /** Bool que controla cuando el usuario uso el "Seleccionar todas" */
  bool isChecked = false;
  /**  */
  bool _isError = false;

  bool get isError => _isError;

  List<UnitModel> units = [];
  List<UnitModel> allUnits = [];

  /** Metodo que recibe ID de unidad seleccionada y la agrega al Set */
  void selectedUnits(int id) {
    if(selectedIds.contains(id)){
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    print("--- TOTAL UNTIS SELECTED: ${selectedIds.length}");
    notifyListeners();
  }

  /** Metodo del CheckBox (En false) para quitar la selección de todas la unidades */
  void quitarSelectedUnits() {
    selectedIds = {};
    selectedIds.clear();
    notifyListeners();
  }

  /** Metodo del CheckBox (En true) para seleccionar todas las unidades.
   * Recibe la lista de unidades, la recorre y agrega sus ID al Set.
   * */
  void selectAll(List<UnitModel> units, bool value) {
    isChecked = value;
    for(UnitModel unit in units) {
      selectedIds.add(int.parse(unit.id_gps!));
    }
    notifyListeners();
  }

  /** Metodo para realizar la busqeuda de unidades con base al parametro Query (Texto ingresado en el SearchBar)
   * El metodo filtra la lista de unidades que carga el FutureBuilder.
   * */
  search(String query) {
    if(query.isEmpty) {
      units = allUnits;
    } else {
      units = allUnits.where((f) => f.placa!.toLowerCase().contains(query.toLowerCase())
      || f.id!.toString().contains(query)).toList();
    }
    notifyListeners();
  }

  // resetSearchText() {
  //   units = allUnits;
  // }
  //
  // resetSelected(bool value) {
  //   if(value) {
  //     isChecked = value;
  //   }
  // }
  //
  // void setOnError(bool value) {
  //   _isError = value;
  //   notifyListeners();
  // }
}