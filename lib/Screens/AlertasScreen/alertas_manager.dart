import 'package:app_rutas_comsi/Screens/AlertasScreen/alertas_screen.dart';
import 'package:flutter/cupertino.dart';

class AlertasManager extends ChangeNotifier {

  /** Metodo que se encarga de acceder a la lista de marcadores del controller de Alertas
   * y elimina la alerta con el ID que recibe de parametro.
   * */
  toDeleteItem(int idx) {
    alertas.remove(idx);
    notifyListeners();
  }
}