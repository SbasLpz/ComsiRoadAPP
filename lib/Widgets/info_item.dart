import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:app_rutas_comsi/Service/comsi_api.dart';
import 'package:flutter/material.dart';

import '../Utils/global_context.dart';

Widget infoItem(UnitModel unidad, BuildContext context) {

  const padd = 8.0;
  const widd = 100.0;

  return Container(
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: FutureBuilder(
        future: postInfo(unidad.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: 200.0,
                child: Center(child: CircularProgressIndicator())
            );
          } else if (snapshot.hasData) {
            var currentUnit = snapshot.data!.first;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  //color: Colors.yellowAccent,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                              unidad.desc.toString(),
                              //style: txtTheme.titleLarge?.copyWith(fontSize: 18)
                          )
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(GlobalContext.navKey.currentContext!).pop();
                          }, icon: Icon(Icons.close, size: 30,)
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, padd, 0, padd),
                          child: Row(
                            children: [
                              SizedBox(
                                width: widd,
                                child: Container(
                                  //color: Colors.redAccent,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Dirección:",
                                        //style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 30.0,),
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
                          padding: const EdgeInsets.fromLTRB(0, padd, 0, padd),
                          child: Row(
                            children: [
                              SizedBox(
                                width: widd,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Conductor:",
                                      //style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 30.0,),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          unidad.namePiloto!.isEmpty ? "No definido" : unidad.namePiloto!,
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
                          padding: const EdgeInsets.fromLTRB(0, padd, 0, padd),
                          child: Row(
                            children: [
                              SizedBox(
                                width: widd,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Fecha:",
                                      //style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 30.0,),
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
                    ],
                  ),
                ),
              ],
            );
          } else {

          }
        },
      ),
    ),
  );
}
