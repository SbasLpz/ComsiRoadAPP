import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:app_rutas_comsi/Screens/UnitsScreen/units_manager.dart';
import 'package:app_rutas_comsi/Service/comsi_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';

import '../UnitsScreen/units_screen.dart';
import 'map_manager.dart';

part 'map_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  var id_usr = 0;
  Set<int> unidades = Set<int>.from(theUnitsManager.selectedIds);

  @override
  void initState() {
    // TODO: implement initState
    _loadUserId();
    super.initState();
  }

  Future<void> _loadUserId() async {
    final loadedId = await loadIduser(); // Esperamos el resultado del Future
    setState(() {
      id_usr = loadedId!; // Asignamos el valor obtenido
    });
    //_unitsFuture = postUnits(id_usr);
  }

  @override
  Widget build(BuildContext context) {
    final unitsManager = context.watch<UnitsManager>();
    unidades = Set<int>.from(unitsManager.selectedIds);
    unidades.forEach((unit){
      print("Unidad con ID: ${unit}");
    });
    final mapManager = context.watch<MapManager>();

    return Scaffold(
      body: FutureBuilder(
          future: postUnits(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(snapshot.hasData) {
              List<UnitModel> defData = mapManager.count == 0 ? snapshot.data! : mapManager.listUnits;
              List<UnitModel> listOfUnits = unidades.length == 0 ? defData : listaFiltrada(unidades, defData);

              var zoom = 6.0;
              var iniLocation = listOfUnits.length == 0 ? LatLng(double.parse(listOfUnits.first.lat!), double.parse(listOfUnits.first.long!)) :  LatLng(9.9996, -84.1572);
              if(listOfUnits.length == 1) {
                zoom = 13.0;
                iniLocation = LatLng(double.parse(listOfUnits.first.lat!), double.parse(listOfUnits.first.long!));
              } else {
                zoom = 6.0;
              }

              return FlutterMap(
                  options: MapOptions(
                    initialCenter: iniLocation,
                    initialZoom: zoom
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                        ),
                      ],
                    ),
                    MarkerLayer(
                        markers: listToMarkerList(listOfUnits)
                    ),
                  ]
              );
            } else {
              return Center(
                child: Text("Sin unidades disponibles"),
              );
            }
          }
      ),
    );
  }
}
