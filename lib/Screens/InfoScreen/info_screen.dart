import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:app_rutas_comsi/Screens/HistoryScreen/history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Styles/theme.dart';
import '../SettingsScreen/settings_screen.dart';

part 'info_controller.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key, required this.unidad});

  final UnitModel unidad;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Regresar",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              color: themeManager.isDarkMode ? COLOR_2 : Colors.redAccent,
              width: double.maxFinite,
              child: Text(
                "Detalles de la Unidad",
                style: txtTheme.titleSmall!.copyWith(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.unidad.desc!,
              style: txtTheme.titleSmall!.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Visualización de todos los datos especificos de la unidad.",
              style: txtTheme.titleSmall!,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            FittedBox(
              child: DataTable(
                  //dataRowColor: WidgetStatePropertyAll(Color()),
                  dataRowHeight: 90.0,
                  columns: const [
                    DataColumn(
                        label: Expanded(
                            child: Text("")
                        ),
                    ),
                    DataColumn(
                        label: Expanded(
                          child: Text("Parámetro", style: TextStyle(fontSize: 30),),
                        )
                    ),
                    DataColumn(
                        label: Expanded(
                          child: Text("Nombre", style: TextStyle(fontSize: 30)),
                        )
                    ),
                    DataColumn(
                        label: Expanded(
                          child: Text("Valor", style: TextStyle(fontSize: 30)),
                        )
                    )
                  ],
                  rows: [
                    DataRow(
                        cells: [
                          DataCell(Icon(Icons.car_crash, color: Theme.of(context).colorScheme.onPrimary)),
                          DataCell(
                            Text("ID Vehiculo", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                            Text("id_vehiculo", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                            Text(widget.unidad.id!, style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.developer_board, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                          DataCell(
                              Text("ID GPS", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("id_gps", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.id_gps!, style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.map_outlined, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                          DataCell(
                              Text("Ubicación", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("lugar", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.lugar!.isEmpty ? "-" : widget.unidad.lugar!, style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.location_on_outlined, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                          DataCell(
                              Text("Latitud", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("latitud", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.lat!.isEmpty ? "-" : widget.unidad.lat!, style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.location_on_outlined, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                          DataCell(
                              Text("Longitud", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("longitud", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.long!.isEmpty ? "-" : widget.unidad.long!, style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.access_time, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                          DataCell(
                              Text("Ultimo reporte", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("last", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.last!.isEmpty ? "-" : widget.unidad.last!, style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.calendar_month, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                          DataCell(
                              Text("Fecha del ultimo reporte", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("fecha1", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.fecha1!.isEmpty ? "-" : widget.unidad.fecha1!, style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.speed, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                          DataCell(
                              Text("Velocidad", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("velocidad", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.velocidad!.isEmpty ? "-" : widget.unidad.velocidad!, style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(CupertinoIcons.car, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                          DataCell(
                              Text("Tipo vehiculo", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("tipo", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.tipo!.isEmpty ? "-" : widget.unidad.tipo!, style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.battery_unknown_outlined, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                          DataCell(
                              Text("Bateria", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("bateria", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.bateria!.isEmpty ? "-" : "${widget.unidad.bateria!} %", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.local_gas_station, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                          DataCell(
                              Text("Combustible", style: txtTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("combustible", style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.combustible!.isEmpty ? "-" : widget.unidad.combustible!, style: txtTheme.titleSmall!.copyWith(fontSize: tam))
                          )
                        ]
                    )
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
