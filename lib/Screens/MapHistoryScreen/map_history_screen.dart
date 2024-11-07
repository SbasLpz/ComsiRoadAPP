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
      body: FutureBuilder(
        future: postHistory(widget.id, widget.fechaIni, widget.fechaFin),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final listaPuntos = snapshot.data;
            var firstPoint = LatLng(double.parse(listaPuntos!.first.latitud!),
                double.parse(listaPuntos!.first.longitud!));

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
                  PolylineLayer(
                      polylines: [
                        Polyline(
                            points: pointsToPoly(listaPuntos!),
                            color: Colors.lightBlue,
                            borderStrokeWidth: 2.0,
                            borderColor: Colors.lightBlue
                        )
                      ]
                  ),
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
                                //return Text(data == null ? "Hola Wenas" : "Hola Wenas ${data.fecha_pc}");
                                return data == null ? Text("")
                                    : HistoryItem(data: data, popupController: myPopupController,); //infoDialogHistory(data, context);
                              }
                          )
                      )
                  ),
                ]
            );
          } else {
            return Center(
              child: Text("No hubo ruta en esos intervalos"),
            );
          }
        },
      ),
    );
  }
}
