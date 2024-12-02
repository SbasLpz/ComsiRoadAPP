import 'package:app_rutas_comsi/Screens/AlertasScreen/alertas_screen.dart';
import 'package:app_rutas_comsi/Screens/MapScreen/map_screen.dart';
import 'package:app_rutas_comsi/Screens/NavigationScreen/navigation_manager.dart';
import 'package:app_rutas_comsi/Screens/SettingsScreen/settings_screen.dart';
import 'package:app_rutas_comsi/Screens/UnitsScreen/units_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


part 'navigation_controller.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    /** Esta variabel contiene el Manager y detecta cualquier cambio
     * que los listeners deban estar escuchando.
     * */
    final navManager = context.watch<NavigationManager>();

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        /** Metodo que cambia el indice de la lista de Pantallas
         * cuando el usuario hace Tap en algun destino de NavigationBar.
         * */
        onDestinationSelected: (int index) {
          setState(() {
            navManager.setIndex(index);
          });
        },
        /** Se asgina la variable del Manager */
        selectedIndex: navManager.currentPageIndexNavBar0,
        /** En destinations se crean los iconos y nombre de cada campo u opción
         * del Navigation Bar.
         * */
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.format_list_bulleted_sharp),
              label: "Unidades"
          ),
          NavigationDestination(
              icon: Icon(Icons.map_outlined),
              label: "Mapa"
          ),
          NavigationDestination(
              icon: Icon(Icons.notification_important_outlined),
              label: "Alertas"
          ),
          NavigationDestination(
              icon: Icon(Icons.settings),
              label: "Ajustes"
          )
        ],
      ),
      body: Center(
        /** Acá se declara la variable que controlara el cambio de Pantallas,
         * en este caso la variable creada en el Manager, es indispensable esta declaración.
         * */
        child: navbarOpciones[navManager.currentPageIndexNavBar0],
      ),
    );
  }
}
