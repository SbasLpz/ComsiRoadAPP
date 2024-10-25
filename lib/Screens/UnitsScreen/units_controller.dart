part of 'units_screen.dart';

List<UnitModel> unidades = [];

final searchController = TextEditingController();

Future<int?> loadIduser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? id_user = prefs.getInt('id_usr');
  return id_user;
}