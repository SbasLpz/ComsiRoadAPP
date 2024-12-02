import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:app_rutas_comsi/Screens/HistoryScreen/history_manager.dart';
import 'package:app_rutas_comsi/Screens/MapHistoryScreen/map_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/src/intl/date_format.dart';

import '../../Styles/theme.dart';
import '../../Utils/global_context.dart';
import '../SettingsScreen/settings_screen.dart';

part 'history_controller.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, required this.unidad});

  final UnitModel unidad;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  /// Controllers para todos los inputs del formulario
  TextEditingController dateInputInicio = TextEditingController();
  TextEditingController timeInputInicio = TextEditingController();
  TextEditingController dateInputFin = TextEditingController();
  TextEditingController timeInputFin = TextEditingController();

  @override
  void dispose() {
    /** Reset de todas las variables utlizadas cuando el usuario se sale de la pantalla */
    validManager.initDate = DateTime(2023);
    validManager.initTime = const TimeOfDay(hour: 00, minute: 00);
    validManager.endTime = const TimeOfDay(hour: 00, minute: 00);
    validManager.sameDay = false;
    validManager.previousHour = false;
    validManager.validDates = false;
    validManager.textoAdver = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeManager.isDarkMode ? COLOR_2 : Colors.white,
      appBar: AppBar(
        title: Text(
          "Regresar",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Historial", style: TextStyle(fontSize: 28),),
              const SizedBox(height: 12,),
              Text(
                widget.unidad.desc!,
                textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18)
              ),
              const SizedBox(height: 12,),
              const Text(
                "Establesca los rangos de inicio y fin de la ruta que desea ver.",
                textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16)
              ),
              const SizedBox(height: 32,),
              Container(
                color: themeManager.isDarkMode ? COLOR_2 : Colors.redAccent,
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Fecha y hora de inicio",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TextField(
                controller: dateInputInicio,
                decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today), labelText: "Fecha inicio", labelStyle: txtTheme.bodyLarge),
                /** Se establce que sea en modo de solo lectura, ya que en el evento onTap
                 * en lugar de permitir la escritura se mostrara un Picker para la fecha y ese valor
                 * se asginara al TextField para mostrarlo.
                 * */
                readOnly: true,
                onTap: () async {
                  /** Se muestra elo Picker */
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime.now());
                  //initDate = selectedDate!;
                  validManager.initDate = selectedDate!;

                  /** Se valida que la fecha elegida sea valida y que no este vacia */
                  if(timeInputFin.text.isNotEmpty){
                    fechaFin == validManager.initDate ? validManager.sameDay = true
                        : validManager.sameDay = false;
                  }

                  /** La fecha elegida por el usuario se formatea y asigna al TextField  */
                  fechaInicio = selectedDate;
                  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                  setState(() {
                    dateInputInicio.text = formattedDate;
                  });
                  validManager.validar();
                },
              ),
              TextField(
                controller: timeInputInicio,
                decoration: InputDecoration(
                    icon: const Icon(Icons.access_time), labelText: "Hora de inicio", labelStyle: Theme.of(context).textTheme.bodyLarge),
                readOnly: true,
                onTap: () async {
                  /** Se abre el TimePicker */
                  TimeOfDay? selectedTime = await showMyTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now()
                  );
                  horaInicio = selectedTime!;
                  //initTime = selectedTime;
                  validManager.initTime = selectedTime;

                  /** Se aplica un formato especifico a la Hora */
                  String formattedTime = "${selectedTime.hour}:${selectedTime.minute}";
                  setState(() {
                    timeInputInicio.text = formattedTime;
                  });

                  print("---- initTime: ${validManager.initTime}, endTime ${validManager.endTime}");

                  /** Se verifica si la hora de fin es previa a la de fin en
                   * cualquier momento.
                   * */
                  if(isBefore(validManager.initTime, validManager.endTime)) {
                    validManager.previousHour = true;
                  } else {
                    validManager.previousHour = false;
                  }
                  print("---- previous HOUR: ${validManager.previousHour}");
                  validManager.validar();
                },
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                color: themeManager.isDarkMode ? COLOR_2 : Colors.redAccent,
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Fecha y hora de final",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TextField(
                controller: dateInputFin,
                decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today), labelText: "Fecha fin", labelStyle: Theme.of(context).textTheme.bodyLarge),
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      //firstDate: DateTime(2023),
                      firstDate: validManager.initDate,
                      lastDate: DateTime.now());
                  fechaFin = selectedDate!;

                  fechaFin == validManager.initDate ? validManager.sameDay = true
                      : validManager.sameDay = false;

                  String formattedDate =
                  DateFormat('yyyy-MM-dd').format(selectedDate);
                  setState(() {
                    dateInputFin.text = formattedDate;
                  });
                  validManager.validar();
                },
              ),
              TextField(
                controller: timeInputFin,
                decoration: InputDecoration(
                    icon: const Icon(Icons.access_time), labelText: "Hora de fin", labelStyle: Theme.of(context).textTheme.bodyLarge),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? selectedTime = await showMyTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  validManager.endTime = selectedTime!;

                  if(isBefore(validManager.initTime, selectedTime)) {
                    validManager.previousHour = true;
                  } else {
                    validManager.previousHour = false;
                  }
                  String formattedTime = "${selectedTime.hour}:${selectedTime.minute}";
                  setState(() {
                    timeInputFin.text = formattedTime;
                  });
                  print("Hora fin onTAP");
                  validManager.validar();
                },
              ),
              Text(
                validManager.textoAdver,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 38,
              ),
              ElevatedButton(
                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.redAccent)),
                  onPressed: () {
                  /** se obtiene el ID de la unidad que viene desde la pantalla del Mapa */
                    final idUnidad = widget.unidad.id;
                    //ingresar(context);

                    /** Se verifica que los campos no esten vacios en caso de que no, se ejecuta el metodo
                     * "consultar" encargado de validar la hora y fecha de inicio y fin y abrir la pantalla del
                     * mapa de historial.
                     * */
                    if(dateInputInicio.text.isEmpty || timeInputInicio.text.isEmpty
                        || dateInputFin.text.isEmpty || timeInputFin.text.isEmpty) {
                      showInfoDialog("Campos sin selección", "Debe seleccionar todas las fechas y horas.",
                          "Entendido", context);
                    } else {
                      consultar(context, idUnidad!);
                      //print("Inicio: ${fechaInicio}, ${horaInicio}; Fin: ${fechaFin}, ${horaFin} ");
                    }
                  },
                  child: const Text("Ver recorrido", style: TextStyle(color: Colors.white, fontSize: 16),)
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
