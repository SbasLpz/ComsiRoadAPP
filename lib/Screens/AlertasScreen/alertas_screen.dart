import 'package:app_rutas_comsi/Screens/AlertasScreen/alertas_manager.dart';
import 'package:app_rutas_comsi/Screens/HistoryScreen/history_screen.dart';
import 'package:app_rutas_comsi/Service/comsi_api.dart';
import 'package:app_rutas_comsi/Widgets/alert_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/alert_model.dart';
part 'alertas_controller.dart';

class AlertasScreen extends StatefulWidget {
  const AlertasScreen({super.key});

  @override
  State<AlertasScreen> createState() => _AlertasScreenState();
}

class _AlertasScreenState extends State<AlertasScreen> {
  @override
  Widget build(BuildContext context) {
    /** Esta variabel contiene el Manager y detecta cualquier cambio
     * que los listeners deban estar escuchando.
     * */
    final alertsManager = context.watch<AlertasManager>();

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            SizedBox(height: 60,),
            Text("Bandeja de Alertas", style: txtTheme.titleSmall!.copyWith(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 30,),
            Text("En esta sección podra observar las alertas de sus unidad informando de su estado actual.", style: txtTheme.titleSmall!.copyWith(fontSize: 18),),
            Expanded(
                child: FutureBuilder(
                  /** Se ejeucta el request a la API para obtener la lista de Alertas de las unidades */
                    future: getAlerts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        /** ---  Codigo cuando la consulta esta cargando --- */

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        /** --- Codigo para cuando la Consulta es Exitosa --- */

                        alertsManager;
                        alertas = snapshot.data!;

                        /** Se valida que si vengas alertas desde la API para cargar los Card y mostrara las alertas al usuario,
                         * en caso de que no hayan alertas disponibles, muestra un texto informativo al usuario.
                         * */
                        if (alertas.length <= 0){
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Tu bandeja de alertas esta al día.", style: txtTheme.titleSmall!.copyWith(fontSize: 15),),
                                Image.asset(
                                  'assets/images/no_imbox.png',
                                  width: 200,
                                  height: 200,
                                ),
                              ],
                            ),
                          );
                        } else {
                          /** Widget de Widgets/alert_item.dar que sirve para ir creadndo los Card para cada Alerta. */
                          return buildAlertItem(alertas, context);
                        }
                      } else {
                        /** --- Codigo para cuando la Consulta ocrriera un error --- */
                        return Center(
                          child: Text("No hay alertas disponibles"),
                        );
                      }
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}
