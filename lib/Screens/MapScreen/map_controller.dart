part of 'map_screen.dart';

UnitsManager theUnitsManager = UnitsManager();
MapManager mapManager = MapManager();

/** Metodo que toma los ID del Set de unidades seleccionadas y buscas por ID esas unidades y las retorna */
List<UnitModel> listaFiltrada(Set<int> unidades, List<UnitModel> lista) {
  List<UnitModel> filterList = [];

  lista.forEach((UnitModel unit) {
    if(unidades.contains(int.parse(unit.id_gps!))) {
      filterList.add(unit);
    }
  });

  return filterList;
}

/** Metodo que toma una lista de unidades y las convierte en Marcadores.
 * Recorre la lista obtiene de cada unida su Latitud y Longitud, y cre un Marcador.
 * */
List<Marker> listToMarkerList(List<UnitModel> lista) {
  List<Marker> markerList = [];

  lista.forEach((UnitModel loca){
    var point = LatLng(double.parse(loca.lat!), double.parse(loca.long!));

    var marker = Marker(
      point: point,
      width: 30,
      height: 30,
      child: GestureDetector(
        onTap: () {
          /** Metodo que mostrara un Dialog con acciones cuando el usuario le presione
           * a un Marcador.
           * */
          showInfoDialog(loca);
        },
        child: Image.asset('assets/images/truck2.png'),
      ),
    );

    print("Unidad: ${loca.desc} | Lat: ${point.latitude}, Long: ${point.longitude}");
    markerList.add(marker);
  });

  print("OOPPAA --- /////");
  return markerList;
}

/** Metodo que converte un String de un Fecha a un fomrato valido */
String convertDateFormat(String date) {
  // Define el formato de la fecha original y el formato deseado
  DateFormat originalFormat = DateFormat('MM-dd-yy hh:mm a');
  DateFormat desiredFormat = DateFormat('dd-MM-yy hh:mm a');

  // Parsear la fecha original y formatearla en el nuevo formato
  DateTime dateTime = originalFormat.parse(date);
  return desiredFormat.format(dateTime);
}

/** Metodo que muestra y carga un Dialog en su Builder se manda llamar un Widget
 * con la estructura que tendra este Dialog este se encuentra en
 * Widgets/info_item.dart
 * */
showInfoDialog(UnitModel unidad) {
  print("InfoDialog Unidad.ID = ${unidad.id}");
  showDialog(
      context: GlobalContext.navKey.currentContext!,
      builder: (BuildContext context) => Dialog(
        child: SizedBox(
          child: infoItem(unidad, context),
        ),
      )
  );
}