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
  TimeOfDay initTime = TimeOfDay(hour: 00, minute: 00);

  TimeOfDay endTime = TimeOfDay(hour: 00, minute: 00);
  var sameDay = false;
  var previousHour = false;

  var validDates = false;
  var textoAdver =  "";

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