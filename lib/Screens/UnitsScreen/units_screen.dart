import 'dart:async';
import 'dart:ffi';
import 'package:app_rutas_comsi/Screens/MapScreen/map_screen.dart';
import 'package:app_rutas_comsi/Screens/UnitsScreen/units_manager.dart';
import 'package:provider/provider.dart';
import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:app_rutas_comsi/Service/comsi_api.dart';
import 'package:app_rutas_comsi/Widgets/unit_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationScreen/navigation_manager.dart';

part 'units_controller.dart';

class UnitsScreen extends StatefulWidget {
  const UnitsScreen({super.key});

  @override
  State<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {

  //Future<List<UnitModel>>? _unitsFuture;
  dynamic _unitsFuture;
  final GlobalKey _listKey = GlobalKey();
  var id_usr = 0;

  @override
  void initState() {
    searchController.clear();
    // TODO: implement initState
    _loadUserId();
    super.initState();
  }

  Future<void> _loadUserId() async {
    final loadedId = await loadIduser(); // Esperamos el resultado del Future
    setState(() {
      id_usr = loadedId!; // Asignamos el valor obtenido
    });
    _unitsFuture = postUnits();

  }

  @override
  Widget build(BuildContext context) {
    final unitsManager = context.watch<UnitsManager>();
    //final navManager = context.watch<NavigationManager>();
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                SearchBar(
                  controller: searchController,
                  hintText: "Buscar unidad...",
                  onChanged: (value) {
                    print("SEARCH new value: ${value}");
                    context.read<UnitsManager>().search(value);
                  },
                ),
                Row(
                  children: [
                    Text("Seleccionar todas: "),
                    Checkbox(
                        value: unitsManager.isChecked,
                        onChanged: (bool? newValue) {
                          unitsManager.selectAll(unitsManager.units, newValue!);
                          if (!newValue) {
                            unitsManager.quitarSelectedUnits();
                          }
                        }
                    )
                  ],
                ),
                SizedBox(height: 10,),
                FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapScreen()),
                      );
                    },
                    child: ListTile(
                      title: Text("Ver en el mapa"),
                      leading: Icon(Icons.map_outlined),
                    ),
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white54)),
                ),
                SizedBox(height: 20,),
                Expanded(
                    child: FutureBuilder(
                        future: _unitsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData && snapshot.data is List<UnitModel>){
                            //context.read<UnitsManager>().setOnError(false);
                            //var mydata = ordenarUnidades(snapshot.data!);
                            // if(unitsInfo.unidadesInfo.isNotEmpty) {
                            //   mydata = ordenarUnidades(unitsInfo.unidadesInfo);
                            // }
                            final unidades = unitsManager.units.isEmpty ? snapshot.data! : unitsManager.units!;
                            unitsManager.allUnits = snapshot.data! as List<UnitModel>;

                            //unitsManager.setOnError(false);
                            //unidades = snapshot.data!;
                            //unitsManager.units = snapshot.data!;
                            return buildUnit(unidades as List<UnitModel>, context, _listKey);
                          } else if (snapshot.hasError){
                            //unitsManager.setOnError(true);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("- Error: ${snapshot.error}"),
                                Image.asset(
                                  'assets/images/error.png',
                                  width: 200,
                                  height: 200,
                                ),
                                Container(
                                  width: 200,
                                  child: FilledButton(
                                    //style: ButtonStyle(maximumSize: WidgetStatePropertyAll(200)),
                                      onPressed: () {
                                        setState(() {

                                        });
                                      },
                                      child: ListTile(
                                        title: Text("Recargar", style: TextStyle(color: Colors.white),),
                                        leading: Icon(Icons.refresh, color: Colors.white,),
                                      )
                                  ),
                                ),
                              ],
                            );
                          } else {
                            //unitsManager.setOnError(true);
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Error desconocido: ${snapshot.data}"),
                                  Image.asset(
                                    'assets/images/error.png',
                                    width: 200,
                                    height: 200,
                                  ),
                                  // FilledButton(
                                  //   //style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(10.0))),
                                  //     onPressed: () {
                                  //
                                  //     },
                                  //     child: ListTile(
                                  //       title: Text("Recargar"),
                                  //       leading: Icon(Icons.map_outlined),
                                  //     )
                                  // ),
                                ],
                              ),
                            );
                          }
                        }
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

