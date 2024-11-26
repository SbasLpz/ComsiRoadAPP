import 'package:flutter/cupertino.dart';

class CommandManager extends ChangeNotifier {
  String? selected;
  var infoCmd = "";
  bool estaCargando = false;

  /** Metodo que controla cuando se visualiza y cuando no la lista de opciones del
   * DropdownMenu */
  toggleButton(String? newValue) {
    selected = newValue;
    notifyListeners();
  }

  /** Metodo que se encarga de cambiar el valor del texto de alerta o infomrativo que el usuario
   * ve cuando envia un comando.
   * */
  alert(String valor){
    infoCmd = valor;
    notifyListeners();
  }

  /** Metodo que se encarga de controlar cuando el comando se esta aun enviando y cuanto este
   * finaliza o le llega a la unidad en cuestion. Controlar cuando mostrar el texto de ALerta que le infomra al usuario
   * si el comando se envio con extio o no.
   * */
  changeEstaCargando(bool newValue) {
    estaCargando = newValue;
    notifyListeners();
  }
}