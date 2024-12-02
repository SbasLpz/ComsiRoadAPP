import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:app_rutas_comsi/Screens/CommandScreen/command_screen.dart';
import 'package:app_rutas_comsi/Screens/HistoryScreen/history_screen.dart';
import 'package:app_rutas_comsi/Screens/InfoScreen/info_screen.dart';
import 'package:app_rutas_comsi/Screens/SettingsScreen/settings_screen.dart';
import 'package:app_rutas_comsi/Service/comsi_api.dart';
import 'package:flutter/material.dart';

import '../Screens/MapScreen/map_screen.dart';
import '../Styles/theme.dart';
import '../Utils/global_context.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;

Widget infoItem(UnitModel unidad, BuildContext context) {

  const padd = 8.0;
  const widd = 100.0;

  return Container(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15.0),
      child: Container(
        child: FutureBuilder(
          /** Se ejeucta request para obtener mas datos de la Unidad del Mapa */
          future: postInfo(unidad.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              /** ---  Codigo cuando la consulta esta cargando --- */

              return const SizedBox(
                  height: 200.0,
                  child: Center(child: CircularProgressIndicator())
              );
            } else if (snapshot.hasData) {
              /** --- Codigo para cuando la Consulta es Exitosa --- */

              var currentUnit = snapshot.data!.first;
              return Container(
                //color: themeManager.isDarkMode ? COLOR_2 : Theme.of(context).colorScheme.onPrimary,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: themeManager.isDarkMode ? COLOR_3 : COLOR_1, // Fondo rojo
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(17), // Bordes superiores redondeados
                        ),
                      ),
                      //color: Colors.yellowAccent,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  unidad.desc.toString(),
                                  //style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  style: txtTheme.titleSmall?.copyWith(fontSize: 16, fontWeight: FontWeight.bold)
                              )
                          ),
                          IconButton(
                            //color: Theme.of(context).primaryColor,
                              onPressed: () {
                                /** IconButton para cerrar el Dialog abierto al presionar la Unidad en el Mapa (el marcador) */
                                Navigator.of(GlobalContext.navKey.currentContext!).pop();
                              }, icon: Icon(Icons.close, size: 30, color: Theme.of(context).colorScheme.onPrimary,)
                          ),
                        ],
                      ),
                    ),
                    /** Series de Contianers conteiende los Widgets que muetsran datos genericos
                     * de la unidad en cuestion, como su ID, fecha de ultimo reporte , localización, etc.
                     * */
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, padd, 20.0, padd),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: widd,
                              child: Container(
                                //color: Colors.redAccent,
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Dirección:",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      //style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //SizedBox(width: 30.0,),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Text("Aldea sibada kokokok, gfhghgggg, CR a 100002255 km", style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary ))
                                    Text(
                                      currentUnit.dirPunto!.isEmpty ? "Sin ubicación" : currentUnit.dirPunto!,
                                      //style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )
                                    )
                                  ]
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //color: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, padd, 20.0, padd),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: widd,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Conductor:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    //style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ],
                              ),
                            ),
                            //SizedBox(width: 30.0,),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      unidad.namePiloto!.isEmpty || unidad.namePiloto!.trim() == "" ? "No definido" : unidad.namePiloto!,
                                      //style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )
                                    ),
                                  ]
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //color: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, padd, 20.0, padd),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: widd,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Fecha:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    //style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ],
                              ),
                            ),
                            //SizedBox(width: 10.0,),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      unidad.fecha1!.isEmpty ? "No reportada" : convertDateFormat(unidad.fecha1!),
                                      //style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )
                                    ),
                                  ]
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //color: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, padd, 20.0, padd),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: widd,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ID del GPS:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    //style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(unidad.id_gps!),
                                  ]
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Container(
                      /** Conatiner que contiene todas las accoines que el usuario puede realizar
                       * con base a la unidades seleccionada. */
                      child: Row(
                        children: [
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    /** Abre la pantalla para acceder a mas detalles de la unidad */
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => InfoScreen(unidad: unidad,))
                                    );
                                  },
                                  icon: const Icon(Icons.info_outline)
                              )
                          ),
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    /** Abre la pantalla para poder enviar comandos al GPS de la unidad */
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => CommandScreen(id_vehiculo: unidad.id!,))
                                    );
                                  },
                                  icon: const Icon(Icons.terminal)
                              )
                          ),
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    /** Abre la apntalla para acceder al Historico de la Unidad */
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HistoryScreen(unidad: unidad,))
                                    );
                                  },
                                  icon: const Icon(Icons.history)
                              )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              //print("ERROR AL CARGAR ITEMUNIT !!");
              /** --- Codigo para cuando la Consulta ocrriera un error --- */
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Error desconocido"),
                    Image.asset(
                      'assets/images/error.png',
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    ),
  );
}
