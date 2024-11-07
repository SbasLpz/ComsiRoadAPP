import 'package:app_rutas_comsi/Screens/AlertasScreen/alertas_manager.dart';
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
    final alertsManager = context.watch<AlertasManager>();
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text("Screeen de Alertas"),
            Expanded(
                child: FutureBuilder(
                    future: getAlerts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        //final lista = snapshot.data;
                        alertsManager;
                        alertas = snapshot.data!;
                        if (alertas.length <= 0){
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Tu bandeja de alertas esta al día."),
                                Image.asset(
                                  'assets/images/no_imbox.png',
                                  width: 200,
                                  height: 200,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return buildAlertItem(alertas, context);
                        }
                      } else {
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
