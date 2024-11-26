import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryManager extends ChangeNotifier {
  // ------- Instancia unica compartida - Singleton ------
  static final HistoryManager instancia = HistoryManager._internal();
  factory HistoryManager() {
    return instancia;
  }
  HistoryManager._internal();
  // ------- Instancia unica compartida - Singleton ------

  DateTime initDate = DateTime(2023);

  /** Variables de Tiempo seteadas en Horas de inicio neutras */
  TimeOfDay initTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay endTime = TimeOfDay(hour: 00, minute: 00);

  /** Bool que controla cuando las Fechas de Inicio y Fin son en el mismo dia*/
  var sameDay = false;
  /** Bool que controla si la Hora de fin es previa a la Hora de inicio */
  var previousHour = false;
  /** Bool  que controla si la Fecha y Hora de Inicio y Fin son validas*/
  var validDates = false;
  /** Variable que contendra texto de advertencia cundo alguno de los datos no sea valido o presnete inconsistencias */
  var textoAdver =  "";

  /** Metodo que se encarga de que las la fecha y hora de inicio y fin sean validas
   * esto quiere decir:
   * Que la hora de fin no puede ser previa a la de inicio y las fechas de inicio y fin son en el mismo dia
   * */
  validar() {
    print("ENTRE AL VALIDAR()");

    if(sameDay && previousHour) {
      validDates = false;
      textoAdver = "NOTA: Al ser el mismo dia, la hora NO puede ser anterior a la hora de inicio.";
      notifyListeners();
    } else {
      validDates = true;
      textoAdver =  " ";
      notifyListeners();
    }
  }
}