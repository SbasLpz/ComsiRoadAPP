import 'dart:async';
import 'package:app_rutas_comsi/Screens/UnitsScreen/units_manager.dart';
import 'package:app_rutas_comsi/Styles/theme_manager.dart';
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

  /// variable que contendra el requestv a la API
  dynamic _unitsFuture;
  /// Key que identidficara a cada unidad como elementos unico
  final GlobalKey _listKey = GlobalKey();
  /// Variable que contiene el ID del usuario del Inicio de Sesión
  var id_usr = 0;

  @override
  void initState() {
    searchController.clear();
    // TODO: implement initState
    //_loadUserId();
    super.initState();
  }

  /// Metodo que obtiene el ID del usuario obtenido del request del Inicio de sesión
  Future<void> _loadUserId() async {
    final loadedId = await loadIduser(); // Esperamos el resultado del Future
    setState(() {
      id_usr = loadedId!; // Asignamos el valor obtenido
    });
    /** Variable que contiene request a la API para que el FutureBuilder
     * no se reconstruya a cada rato. */
    _unitsFuture = postUnits();

  }

  @override
  Widget build(BuildContext context) {
    /** Esta variabel contiene el Manager y detecta cualquier cambio
     * que los listeners deban estar escuchando.
     * */
    final unitsManager = context.watch<UnitsManager>();
    final navManager = context.watch<NavigationManager>();

    return Scaffold(
      body: Consumer<ThemeManager>(
        builder: (context, themeManager, child){
          WidgetsBinding.instance.addPostFrameCallback((_){
            setState(() {
            });
          });
          return Container(
            child: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    SearchBar(
                      controller: searchController,
                      hintText: "Buscar unidad...",
                      /** Metodo para obtener el valor ingresado y ejecutar el comando
                       * de busqueda.
                       * */
                      onChanged: (value) {
                        print("SEARCH new value: $value");
                        context.read<UnitsManager>().search(value);
                      },
                    ),
                    Row(
                      children: [
                        const Text("Seleccionar todas: "),
                        Checkbox(
                            value: unitsManager.isChecked,
                            /** Metodo que asigna true o false a variable que controla la seleccion de todas las unidades.
                             * en True, selecciona todas en False les quita la seleccion.
                             * */
                            onChanged: (bool? newValue) {
                              unitsManager.selectAll(unitsManager.units, newValue!);
                              if (!newValue) {
                                unitsManager.quitarSelectedUnits();
                              }
                            }
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    FilledButton(
                      /** Botón para abrir el Mapa */
                      onPressed: () {
                        navManager.setIndex(1);
                      },
                      style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white54)),
                      child: const ListTile(
                        title: Text("Ver en el mapa"),
                        leading: Icon(Icons.map_outlined),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Expanded(
                        child: FutureBuilder(
                            future: myUnitsPost,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting){
                                /** ---  Codigo cuando la consulta esta cargando --- */
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData && snapshot.data is List<UnitModel>){
                                /** --- Codigo para cuando la Consulta es Exitosa --- */

                                /** Unidades contiene en caso de que la lista del Manager no haya sido filtrada ni nada la lista de unidades recibida del Request
                                 * En caso de que la lista est filtrada (El usuario busco por nombre o ID) la varible contiene esa lista units.
                                 * */
                                final unidades = unitsManager.units.isEmpty ? snapshot.data! : unitsManager.units;
                                unitsManager.allUnits = snapshot.data! as List<UnitModel>;

                                /** Se manda a llamar el Widget de CardView de Widgets/unit_item.dart */
                                return buildUnit(unidades as List<UnitModel>, context, _listKey);
                              } else if (snapshot.hasError){
                                /** --- Codigo para cuando la Consulta ocrriera un error --- */
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
                                    SizedBox(
                                      width: 200,
                                      child: FilledButton(
                                        //style: ButtonStyle(maximumSize: WidgetStatePropertyAll(200)),
                                          onPressed: () {
                                            setState(() {

                                            });
                                          },
                                          child: const ListTile(
                                            title: Text("Recargar", style: TextStyle(),),
                                            leading: Icon(Icons.refresh,),
                                          )
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                /** --- Codigo para cuando ocurre una Excepción u Error inesperado--- */
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
          );
        },
      ),
    );
  }
}

