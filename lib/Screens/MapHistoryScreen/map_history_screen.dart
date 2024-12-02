import 'package:app_rutas_comsi/Models/history_model.dart';
import 'package:app_rutas_comsi/Service/comsi_api.dart';
import 'package:app_rutas_comsi/Widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

part 'map_screen_controller.dart';

class MapHistoryScreen extends StatefulWidget {
  const MapHistoryScreen({super.key, required this.id, required this.fechaIni, required this.fechaFin});

  /// Parametros que viene desde la pantalla de historial y son necesarios para
  /// ejecutar el request a la API del historial.
  ///
  final String id;
  final String fechaIni;
  final String fechaFin;

  @override
  State<MapHistoryScreen> createState() => _MapHistoryScreenState();
}

class _MapHistoryScreenState extends State<MapHistoryScreen> {

  final PopupController myPopupController = PopupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Regresar",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)
            );
          },
        ),
      ),
      body: FutureBuilder(
        /** Request para obtener el historial de la ruta de la unidad */
        future: postHistory(widget.id, widget.fechaIni, widget.fechaFin),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            /** ---  Codigo cuando la consulta esta cargando --- */
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            /** --- Codigo para cuando la Consulta es Exitosa --- */
            final listaPuntos = snapshot.data;

            /** Variable que contiene en formato LatLng el punto de inicio de la ruta
             * para que se use de referencia al cargar el FlutterMap
             * */
            var firstPoint = LatLng(double.parse(listaPuntos!.first.latitud!),
                double.parse(listaPuntos.first.longitud!));

            return FlutterMap(
                options: MapOptions(
                  initialCenter: firstPoint,
                  initialZoom: 13,
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
                  /** Widget para crear una Polyline o la linea que une los puntos de la ruta que siguio la unidadn */
                  PolylineLayer(
                      polylines: [
                        Polyline(
                            points: pointsToPoly(listaPuntos),
                            color: Colors.lightBlue,
                            borderStrokeWidth: 2.0,
                            borderColor: Colors.lightBlue
                        )
                      ]
                  ),
                  /** Widget necesario para que cuando el usuario haga Tap en alguno de los marcadores del historial
                   * se muestre uns especia de Dialog con infmoración.
                   * */
                  PopupMarkerLayer(
                      options: PopupMarkerLayerOptions(
                          markers: marcadores,
                          popupController: myPopupController,
                          popupDisplayOptions: PopupDisplayOptions(

                              builder: (BuildContext context, Marker marker) {
                                var data = markersDataMap[marker];
                                if (data == null) {
                                  print("DATA KEY NULL.");
                                } else {
                                  print("DATA KEY FOUND. ${data.fecha_pc}");
                                }

                                return data == null ? const Text("")
                                    : HistoryItem(data: data, popupController: myPopupController,); //infoDialogHistory(data, context);
                              }
                          )
                      )
                  ),
                ]
            );
          } else {
            /** --- Codigo para cuando la Consulta ocrriera un error --- */
            return const Center(
              child: Text("No hubo ruta en esos intervalos"),
            );
          }
        },
      ),
    );
  }
}
