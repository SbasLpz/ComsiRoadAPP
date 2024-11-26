import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:app_rutas_comsi/Screens/UnitsScreen/units_manager.dart';
import 'package:app_rutas_comsi/Service/comsi_api.dart';
import 'package:app_rutas_comsi/Widgets/info_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../../Utils/global_context.dart';
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
  /** Variable que contendra el Set de unidades seleccionadas */
  Set<int> unidades = Set<int>.from(theUnitsManager.selectedIds);

  @override
  void initState() {
    // TODO: implement initState
    _loadUserId();
    /** Cuando se carga la pantalla del Mapa se empiezan a ejecutar la actaulización de ubicaciones de las unidades */
    mapManager.intervalUpdates();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    /** Cuando la pantalla de Mapa ya no es visible se Detiene la actualizacion de ubicaciones
     * para evitar que los request se esten ejecutando cada 10 sec de manera innesesaria.
     * */
    mapManager.stopTimer = true;
    super.dispose();
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
    /** Se declara la variable que para acceder al Manager de Unidades */
    final unitsManager = context.watch<UnitsManager>();
    /** Se asigna el Set de las Unidades seleccionadas a una variable. */
    unidades = Set<int>.from(unitsManager.selectedIds);
    // unidades.forEach((unit){
    //   //print("Unidad con ID: ${unit}");
    // });

    /** Se declara la variable que para acceder al Manager de Mapa */
    final mapManager = context.watch<MapManager>();

    return Scaffold(
      body: FutureBuilder(
          future: myUnitsPost,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              /** ---  Codigo cuando la consulta esta cargando --- */
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(snapshot.hasData && snapshot.data is List<UnitModel>) {
              /** --- Codigo para cuando la Consulta es Exitosa --- */

              /** defData verificar si la actualización de las unidades en Mapa (count)
               * si no se muestra las unidades obtenidas del FutureBuilder en caso de que ya se hayan realizado actualizacion de ubicación
               * accede a la lista de unidades del Manager y de ahi en adleante se usa esta vairbale para controlar las unidades en el Mapa.
               *
               * NOTA: Esto para no estar ejecutando el rewquest del FutureBuilder y evitar la recarga de la pantalla
               * */
              List<UnitModel> defData = mapManager.count == 0 ? snapshot.data! : mapManager.listUnits;

              /** listOdUnits ve si hay lista de unidades seleccionadas en caso de que no usa la variable defData
               * y en caso de que si, llama el mertodo que devuelve una lista de unidades filtrada a partir del Set con IDs
               * */
              List<UnitModel> listOfUnits = unidades.length == 0 ? defData : listaFiltrada(unidades, defData);

              /** Variables de configuración del FlutterMap */
              var zoom = 6.0;
              var iniLocation = listOfUnits.length == 0 ? LatLng(double.parse(listOfUnits.first.lat!), double.parse(listOfUnits.first.long!)) :  LatLng(9.9996, -84.1572);
              if(listOfUnits.length == 1) {
                zoom = 13.0;
                iniLocation = LatLng(double.parse(listOfUnits.first.lat!), double.parse(listOfUnits.first.long!));
              } else {
                zoom = 6.0;
              }

              /** Widget del FlutterMap */
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
                      /** Se asigna a markers el Metodo listToMarkerList que convierte Unidades en Marcadores del Mapa */
                        markers: listToMarkerList(listOfUnits)
                    ),
                  ]
              );
            } else {
              /** --- Codigo para cuando la Consulta ocrriera un error --- */
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error desconocido: ${snapshot.data}"),
                  Image.asset(
                    'assets/images/error.png',
                    width: 200,
                    height: 200,
                  ),
                ],
              );
            }
          }
      ),
    );
  }
}
