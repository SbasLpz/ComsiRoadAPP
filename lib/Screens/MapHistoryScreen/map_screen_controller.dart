part of 'map_history_screen.dart';

LatLng puntoInicio = LatLng(0, 0);
LatLng puntoFinal = LatLng(0, 0);
List<Marker> marcadores = [];
final MapController mpController = MapController();

Map<Marker, HistoryModel> markersDataMap = {};

List<LatLng> pointsToPoly(List<HistoryModel> lista) {
  List<LatLng> puntos = [];

  lista.forEach((HistoryModel punto) {
    var point = LatLng(double.parse(punto.latitud!), double.parse(punto.longitud!));

    toMarkerDet(point, Icon(Icons.location_on, color: Colors.blue[800], size: 30,), punto);
    puntos.add(point);
  });

  print("Lista de PUNTOS para el POLYLINE: ${puntos}");
  puntos.reversed;

  puntoInicio = puntos.first;
  puntoFinal = puntos.last;

  toMarker(puntoInicio, Icon(Icons.location_on, color: Colors.green, size: 40,));
  toMarker(puntoFinal, Icon(Icons.location_on, color: Colors.redAccent, size: 40));

  print("Punto INICIO: ${puntoInicio}, Punto FINAL: ${puntoFinal}");

  return puntos;
}

toMarker(LatLng punto, Icon icono) {
  var marker = Marker(
      point: punto,
      width: 30.0,
      height: 30.0,
      child: icono
  );

  marcadores.add(marker);
}

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