import 'package:app_rutas_comsi/Screens/UnitsScreen/units_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/unit_model.dart';

Widget buildUnit(List<UnitModel> unidades, BuildContext context, Key key) {
  final unitsManager = context.watch<UnitsManager>();
  return ListView.builder(
      key: key,
      itemCount: unidades.length,
      itemBuilder: (context, index) {
        final unidad = unidades[index];
        return InkWell(
          onTap: () {
            unitsManager.selectedUnits(int.parse(unidad.id_gps!));
            print("Elemento seleccionado: ${unidad.placa}");
          },
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(unidad.desc.toString(), style: TextStyle(fontSize: 20),),
                          flex: 3,
                      ),
                      Flexible(
                          flex: 1,
                          child: unitsManager.selectedIds.contains(unidad.id_reporte!) || unitsManager.isChecked == true ?
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 30, 0),
                              child: Icon(Icons.check, color: Colors.green, size: 30,),
                            ),
                          ) : Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 30, 0),
                              child: Icon(Icons.check, color: Colors.grey, size: 30,),
                            ),
                          )
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: ListTile(
                            minTileHeight: double.minPositive,
                            leading: Icon(
                              Icons.car_crash,
                              size: 20,
                            ),
                            title: Text(
                              unidad.placa.toString()
                            ),
                          )
                      ),
                      Flexible(
                          flex: 1,
                          child: ListTile(
                            minTileHeight: double.minPositive,
                            leading: Icon(
                              Icons.circle,
                              size: 20,
                            ),
                            title: Text(
                                unidad.fecha1.toString()
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Container(
                            child: ListTile(
                              minTileHeight: double.minPositive,
                              contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              leading: Icon(
                                Icons.location_on_outlined,
                                size: 20,
                              ),
                              title: Text(
                                unidad.lugar!.isNotEmpty ? "${unidad.lugar}" : unidad.lat.toString()+","+unidad.long.toString(),
                              ),
                            ),
                          )
                      ),
                      Flexible(
                          flex: 1,
                          child: ListTile(
                            minTileHeight: double.minPositive,
                            leading: Icon(Icons.key, size: 20,),
                            title: Text(unidad.id_gps.toString()),
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
  );
}