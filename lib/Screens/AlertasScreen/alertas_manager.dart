import 'package:app_rutas_comsi/Screens/AlertasScreen/alertas_screen.dart';
import 'package:flutter/cupertino.dart';

class AlertasManager extends ChangeNotifier {

  toDeleteItem(int idx) {
    alertas.remove(idx);
  }
}