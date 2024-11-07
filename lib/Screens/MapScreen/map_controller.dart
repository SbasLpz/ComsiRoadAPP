part of 'map_screen.dart';

UnitsManager theUnitsManager = UnitsManager();
MapManager mapManager = MapManager();

List<UnitModel> listaFiltrada(Set<int> unidades, List<UnitModel> lista) {
  List<UnitModel> filterList = [];

  lista.forEach((UnitModel unit) {
    if(unidades.contains(unit.id_reporte!)) {
      filterList.add(unit);
    }
  });

  return filterList;
}

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
          print("Buenas tardes -");
          //showMiDialog(loca);
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

String convertDateFormat(String date) {
  // Define el formato de la fecha original y el formato deseado
  DateFormat originalFormat = DateFormat('MM-dd-yy hh:mm a');
  DateFormat desiredFormat = DateFormat('dd-MM-yy hh:mm a');

  // Parsear la fecha original y formatearla en el nuevo formato
  DateTime dateTime = originalFormat.parse(date);
  return desiredFormat.format(dateTime);
}

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