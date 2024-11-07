import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              color: Colors.redAccent,
              width: double.maxFinite,
              child: Text(
                "Detalles de la Unidad",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.unidad.desc!,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Visualización de todos los datos especificos de la unidad.",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            FittedBox(
              child: DataTable(
                  //dataRowColor: WidgetStatePropertyAll(Color()),
                  dataRowHeight: 90.0,
                  columns: [
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
                          DataCell(Icon(Icons.car_crash)),
                          DataCell(
                            Text("ID Vehiculo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                            Text("id_vehiculo", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                            Text(widget.unidad.id!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.developer_board,)
                          ),
                          DataCell(
                              Text("ID GPS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("id_gps", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.id_gps!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.map_outlined)
                          ),
                          DataCell(
                              Text("Ubicación", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("lugar", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.lugar!.isEmpty ? "-" : widget.unidad.lugar!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.location_on_outlined)
                          ),
                          DataCell(
                              Text("Latitud", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("latitud", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.lat!.isEmpty ? "-" : widget.unidad.lat!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.location_on_outlined)
                          ),
                          DataCell(
                              Text("Longitud", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("longitud", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.long!.isEmpty ? "-" : widget.unidad.long!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.access_time)
                          ),
                          DataCell(
                              Text("Ultimo reporte", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("last", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.last!.isEmpty ? "-" : widget.unidad.last!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.calendar_month)
                          ),
                          DataCell(
                              Text("Fecha del ultimo reporte", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("fecha1", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.fecha1!.isEmpty ? "-" : widget.unidad.fecha1!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.speed)
                          ),
                          DataCell(
                              Text("Velocidad", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("velocidad", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.velocidad!.isEmpty ? "-" : widget.unidad.velocidad!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(CupertinoIcons.car)
                          ),
                          DataCell(
                              Text("Tipo vehiculo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("tipo", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.tipo!.isEmpty ? "-" : widget.unidad.tipo!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.battery_unknown_outlined)
                          ),
                          DataCell(
                              Text("Bateria", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("bateria", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.bateria!.isEmpty ? "-" : widget.unidad.bateria!+" %", style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.local_gas_station)
                          ),
                          DataCell(
                              Text("Combustible", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("combustible", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.combustible!.isEmpty ? "-" : widget.unidad.combustible!, style: TextStyle(fontSize: tam))
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
