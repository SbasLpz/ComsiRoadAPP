import 'package:app_rutas_comsi/Screens/UnitsScreen/units_manager.dart';
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
            /** Cunado el usuario da Tap en un Card de la Unidad la selecciona
             * entonces se llama al metodo que agrega el ID de la unidad seleccionada
             * al Set que las contiene todas en el Manager de las Unidades
             * */
            unitsManager.selectedUnits(int.parse(unidad.id_gps!));
            print("Elemento seleccionado: ${unidad.id_gps}");
          },
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(unidad.desc.toString(), style: const TextStyle(fontSize: 20),),
                      ),
                      Flexible(
                          flex: 1,
                          /** Widget con condicional, para que en caso de ser una unidad seleccionada
                           * se muestre un icono en verde y en caso de que no uno en Gris, con base
                           * a si el ID se encuetra o no en el Set de IDs de unidad seleccionadas.
                           * */
                          child: unitsManager.selectedIds.contains(int.parse(unidad.id_gps!)) || unitsManager.isChecked == true ?
                          const Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 30, 0),
                              child: Icon(Icons.check_circle, color: Colors.green, size: 30,),
                            ),
                          ) : Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 30, 0),
                              child: Icon(Icons.circle_outlined, color: Colors.grey[600], size: 30,),
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
                            leading: const Icon(
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
                            leading: const Icon(
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
                              contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              leading: const Icon(
                                Icons.location_on_outlined,
                                size: 20,
                              ),
                              title: Text(
                                unidad.lugar!.isNotEmpty ? "${unidad.lugar}" : "${unidad.lat},${unidad.long}",
                              ),
                            ),
                          )
                      ),
                      Flexible(
                          flex: 1,
                          child: ListTile(
                            minTileHeight: double.minPositive,
                            leading: const Icon(Icons.key, size: 20,),
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