import 'dart:convert';
import 'dart:core';
import 'package:app_rutas_comsi/Models/alert_model.dart';
import 'package:app_rutas_comsi/Models/command_model.dart';
import 'package:app_rutas_comsi/Models/history_model.dart';
import 'package:app_rutas_comsi/Models/send_model.dart';
import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:http/http.dart' as http;
import 'package:session_manager/session_manager.dart';
import 'package:app_rutas_comsi/Models/validation_model.dart';

/// Validación de las credenciales de inicio de sesión
Future<dynamic> postLogin(String cuenta, String user, String pass) async {
  Map<String, dynamic> request = {
    'cuenta': cuenta,
    'user': user,
    'pass': pass
  };

  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/login/validarlogin");

  try {
    var res = await http.post(url, body: request);

    final body = jsonDecode(res.body);

    print("Consulta HECHA: ${ValidationModel.fromJson(body)}, DATOS ENV: $user, $pass");
    return ValidationModel.fromJson(body);

  } catch(e){
      return {'error': '$e'};
  }
}

Future myUnitsPost = postUnits();

/// Consulta que obtiene la lista de unidades
Future<dynamic> postUnits() async {
  String token = await SessionManager().getString("tokenUser");

  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/getAll/$token");

  try {
    var res = await http.get(url, headers: {});
    final List<dynamic> dataResp = res.statusCode == 200 ? json.decode(res.body)['data'] : [];

    return dataResp.map((unit) => UnitModel.fromJson(unit)).toList();
  } catch(e) {
    return {'error': '$e'};
  }

  //final List<dynamic> body = jsonDecode(res.body);

  //return body.map((unit) => UnitModel.fromJson(unit)).toList();

}

/// Consulta que obtiene infomración más detalla de la unidad
Future<List<UnitModel>> postInfo(String id,) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'id': id
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/getOne/$token");

  final response = await http.post(url, headers: {}, body: request);
  //final body = jsonDecode(response.body);
  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  //print("Envie: ${id}. SUCCESS del GET ONE VEHICLE: ${UnidadModel.fromJson(body).success}");
  return dataResp.map((unit)=>UnitModel.fromJson(unit)).toList();
}

/// Consulta que obtiene los puntos que recorrio la unidad para mostrar en su Historial
Future<List<HistoryModel>> postHistory(String cuenta, String fehaIni, String fechaFin) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'id': cuenta,
    'fechad': fehaIni,
    'fechah': fechaFin
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/getHistory/$token");

  final response = await http.post(url, headers: {}, body: request);

  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  return dataResp.map((history)=>HistoryModel.fromJson(history)).toList();
}

/// Consulta que obtiene las Alertas de las unidades para el usuairo
Future<List<AlertModel>> getAlerts() async {
  String token = await SessionManager().getString("tokenUser");
  token;
  //print("Token de Usuario a usar: ${token}");
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/getAlerts/$token");
  //print("URL del enspoint: ${url.toString()}");
  final response = await http.get(url, headers: {});
  //final List body = json.decode(response.body);

  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];
  //print("DataResp number of units: ${dataResp.length}");
  //print("Code Response: ${response.statusCode}");
  //print("Response SUCCESS: ${json.decode(response.body)['success']}");

  print("ACTUALICE LAS ALERTAS !");

  return dataResp.map((alerta) => AlertModel.fromJson(alerta)).toList();
}

/// Consulta que obtiene la lista de Comandos para una unidad
Future<List<CommandModel>> getCommands(String id) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'id': id
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/commands/getList/$token");

  final response = await http.post(url, headers: {}, body: request);

  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  return dataResp.map((cmd)=>CommandModel.fromJson(cmd)).toList();
}

/// Consulta que se encarga de enviar el Comando a la unidad.
Future<SendModel> sendCommand(String id, String sms) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'id': id,
    'sms': sms
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/commands/sendcommand/$token");

  final response = await http.post(url, headers: {}, body: request);
  final body = jsonDecode(response.body);
  //final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  print("Envie le COMANDO $sms, SUCCESS: ${SendModel.fromJson(body).success}");
  return SendModel.fromJson(body);
}