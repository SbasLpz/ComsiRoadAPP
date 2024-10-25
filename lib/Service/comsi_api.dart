import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:http/http.dart' as http;
import 'package:session_manager/session_manager.dart';
import 'package:app_rutas_comsi/Models/validation_model.dart';

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

    print("Consulta HECHA: ${ValidationModel.fromJson(body)}, DATOS ENV: ${user}, ${pass}");
    return ValidationModel.fromJson(body);

  } catch(e){
      return {'error': '${e}'};
  }
}

Future<List<UnitModel>> postUnits() async {
  String token = await SessionManager().getString("tokenUser");

  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/getAll/"+token);

  var res = await http.get(url, headers: {});

  //final List<dynamic> body = jsonDecode(res.body);

  //return body.map((unit) => UnitModel.fromJson(unit)).toList();
  final List<dynamic> dataResp = res.statusCode == 200 ? json.decode(res.body)['data'] : [];
  return dataResp.map((unit) => UnitModel.fromJson(unit)).toList();
}

// Future<List<UnitModel>> postLocation(int id_usr) async {
//  return List<UnitModel>([]);
// }

Future<List<UnitModel>> postInfo(String id,) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'id': id
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/getOne/"+token);

  final response = await http.post(url, headers: {}, body: request);
  //final body = jsonDecode(response.body);
  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  //print("Envie: ${id}. SUCCESS del GET ONE VEHICLE: ${UnidadModel.fromJson(body).success}");
  return dataResp.map((unit)=>UnitModel.fromJson(unit)).toList();
}