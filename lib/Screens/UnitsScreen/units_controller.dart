part of 'units_screen.dart';

List<UnitModel> unidades = [];

/// Controller para poder acceder y manejar el texto ingresado en el SearchBar
final searchController = TextEditingController();

/// Metodo que obtiene de las SharedPreferences de la app el ID del usuario
/// obtenido en el Inicio de Sesión.
///
Future<int?> loadIduser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? idUser = prefs.getInt('id_usr');
  return idUser;
}