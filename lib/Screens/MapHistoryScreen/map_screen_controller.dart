part of 'map_history_screen.dart';

LatLng puntoInicio = const LatLng(0, 0);
LatLng puntoFinal = const LatLng(0, 0);
/// Lista que contiene la lista de todos los marcadores cerados de los puntos por lo que paso la unidad en el Mapa
List<Marker> marcadores = [];

final MapController mpController = MapController();


Map<Marker, HistoryModel> markersDataMap = {};

/// Metodo para crear o convertir la lista de Puntos de la unidad en obtejots LatLng
/// para crear el Polyline
///
List<LatLng> pointsToPoly(List<HistoryModel> lista) {
  List<LatLng> puntos = [];

  for (var punto in lista) {
    var point = LatLng(double.parse(punto.latitud!), double.parse(punto.longitud!));

    toMarkerDet(point, Icon(Icons.location_on, color: Colors.blue[800], size: 30,), punto);
    puntos.add(point);
  }

  print("Lista de PUNTOS para el POLYLINE: $puntos");
  puntos.reversed;

  puntoInicio = puntos.first;
  puntoFinal = puntos.last;

  /** De crolor ver esta el marcador donde comenzo la ruta y de rojo el marcador de final */
  toMarker(puntoInicio, const Icon(Icons.location_on, color: Colors.green, size: 40,));
  toMarker(puntoFinal, const Icon(Icons.location_on, color: Colors.redAccent, size: 40));

  print("Punto INICIO: $puntoInicio, Punto FINAL: $puntoFinal");

  return puntos;
}

/// Metodo para crea un marcador del el FlutterMap, con su coordenadas y su rewspectivo icono
toMarker(LatLng punto, Icon icono) {
  var marker = Marker(
      point: punto,
      width: 30.0,
      height: 30.0,
      child: icono
  );

  marcadores.add(marker);
}

/// Metodo para crea un marcador del el FlutterMap, con su coordenadas y su rewspectivo icono
/// con un parametro extra para pasarle tambien datos del punto que pueden ser mostrados en el Dialog desplegable
///

toMarkerDet (LatLng punto, Icon icono, HistoryModel data) {
  var marker = Marker(
      point: punto,
      width: 30.0,
      height: 30.0,
      child: icono,
      key: ObjectKey(data)
  );

  markersDataMap[marker] = data;
  marcadores.add(marker);
}