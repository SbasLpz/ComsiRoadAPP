import 'package:app_rutas_comsi/Screens/MapScreen/map_screen.dart';
import 'package:app_rutas_comsi/Screens/NavigationScreen/navigation_manager.dart';
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
    final navManager = context.watch<NavigationManager>();

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            navManager.setIndex(index);
          });
        },
        selectedIndex: navManager.currentPageIndexNavBar0,
        destinations: <Widget>[
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
        //child: Text("Pantalla de Unidades. ID USER: ${widget.id_usr}"),
        child: navbarOpciones[navManager.currentPageIndexNavBar0],
      ),
    );
  }
}
