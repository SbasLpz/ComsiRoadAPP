import 'package:app_rutas_comsi/Models/command_model.dart';
import 'package:app_rutas_comsi/Screens/NavigationScreen/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Service/comsi_api.dart';
import 'command_manager.dart';

part 'command_controller.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({super.key, required this.id_vehiculo});

  final String id_vehiculo;

  @override
  State<CommandScreen> createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {

  @override
  void initState() {
    /** Cuando se inicialice la pantalla se ejecuta el request para obtener la lista de
     * comadnos disponibles para la unidad.
     * */
    _commandsFuture = getCommands(widget.id_vehiculo);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final manager = context.watch<CommandManager>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Regresar",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
        child: Card(
          child: Container(
            width: double.maxFinite,
            height: 410,
            decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Enviar Comando",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!,
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Text(
                  "Unidad: ${widget.id_vehiculo}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: FutureBuilder(
                    /** Se asigna la variable _commandsFuture en lugar del metodo de rewquest de la API directamente
                     * para evitar que la pantalla se recargue siempre que el suairo seleccione un comando.
                     * */
                      future: _commandsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          comandos = snapshot.data!;
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Comandos",
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)
                              )
                            ),
                              hint: comandos.isEmpty ? const Text("No disponibles") : const Text("Seleccione un comando"),
                              value: manager.selected,
                              /** Se recorre con map la lista de comandos (variable "comandos") y se van creando objetos
                               * de tipo DropdownMenuItem que sera la Opciones que se veran del DropdownButtonFormField.
                               * */
                              items: comandos.map<DropdownMenuItem<String>>((CommandModel cmd){
                                return DropdownMenuItem<String>(
                                    value: cmd.descripcion,
                                    child: Text(cmd.descripcion ?? '--')
                                );
                              }).toList(),
                              onChanged: (String? newValue){
                                manager.toggleButton(newValue);
                              }
                          );
                        } else {
                          return const Center(
                            child: Text("No se pudo conectar al servidor."),
                          );
                        }
                      }
                  ),
                ),
                const SizedBox(height: 40,),
                Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        /** Boton de CANCELAR:
                         * Al presionar simplemente se regresara al usuario a la pantalla del Mapa de las unidades
                         * */
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> const NavigationScreen())
                            );
                          },
                          child: const Text("Cancelar")
                      ),
                      const SizedBox(width: 10,),
                      /** Se valida que el usuario haya seleccionado un comando para entonces ejecuatr el request a la API
                       * que envia el comando a la unidad, en caso de no haber comando seleccionado se deshabilita el boton con
                       * asignadole un null en su evento onTap.
                       * */
                      manager.selected != null ? OutlinedButton(
                          onPressed: () async {
                            manager.changeEstaCargando(true);
                            /** Se obtiene el comando seleccionado cuya despcion coincide con el nombre del comando
                             * que aparece en las Opricones del DropdownMenu
                             * */
                            var cmd = comandos.firstWhere((cm)=>cm.descripcion == manager.selected);
                            try {
                              /** Se ejecuta el requestv para enviar el comando a la unidad*/
                              var res = await sendCommand(widget.id_vehiculo, cmd.command!);
                              if(res.success == true){
                                manager.alert("Comando enviado con exito!");
                              } else {
                                manager.alert("Algo salio mal: ${res.msg.toString()}");
                              }
                              manager.changeEstaCargando(false);
                            } catch(e){
                              manager.changeEstaCargando(false);
                              print("----- EXCEPCIÓN ----");
                              Text("Excepción: $e");
                            }
                            manager.selected = null;
                            setState(() {
          
                            });
                          },
                          child: const Text("Enviar")
                      ) : const OutlinedButton(
                          onPressed: null,
                          child: Text("Enviar")
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                !manager.estaCargando ? Text(manager.infoCmd) : const CircularProgressIndicator()
              ],
            )
          ),
        ),
      ),
    );
  }
}
