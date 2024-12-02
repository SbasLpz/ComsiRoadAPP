import 'package:app_rutas_comsi/Screens/AlertasScreen/alertas_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/alert_model.dart';

Widget buildAlertItem(List<AlertModel> alerts, BuildContext context) {

  final alertsManaeger = context.watch<AlertasManager>();

  return ListView.builder(
      itemCount: alerts.length,
    itemBuilder: (context, index) {
      final alert = alerts[index];
      return InkWell(
        onTap: () {

        },
        /** Necesario para el evento de cuando el usuario deslice hacia un lado la alerta para eliminarla. */
        child: Dismissible(
          key: ValueKey(alert.id_log),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            alertsManaeger.toDeleteItem(index);
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: ExpansionTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              //backgroundColor: Theme.of(context).colorScheme.primary,
              /** En ete title del ExpansionTile se muestra la infomración que vera el usuario de las alertas
               * cuando NO les de Tap para desplegar el ExpansionTale, es decir lo que se ve cuando este esta contraido.
               * */
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          //color: Colors.redAccent,
                          child: Column(
                            children: [
                              const Text("Placa", style: TextStyle(fontWeight: FontWeight.w600),),
                              Text(alert.placa.toString(), textAlign: TextAlign.center,)
                            ],
                          ),
                        )
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            const Text("Fecha", style: TextStyle(fontWeight: FontWeight.w600)),
                            Center(
                                child: Text(
                                  "${alert.fecha1}",
                                  textAlign: TextAlign.center,
                                )
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ),
              /** Aca se muestra los Widget con la infromacion que se mostrara cuando el usuario de Tap al ExpansionTile
               * y lo despliegue.
               * */
              children: [
                Container(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(alert.descripcion.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}