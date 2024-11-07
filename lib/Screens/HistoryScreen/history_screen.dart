import 'package:app_rutas_comsi/Models/unit_model.dart';
import 'package:app_rutas_comsi/Screens/HistoryScreen/history_manager.dart';
import 'package:app_rutas_comsi/Screens/MapHistoryScreen/map_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/src/intl/date_format.dart';

import '../../Utils/global_context.dart';

part 'history_controller.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, required this.unidad});

  final UnitModel unidad;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  TextEditingController dateInputInicio = TextEditingController();
  TextEditingController timeInputInicio = TextEditingController();
  TextEditingController dateInputFin = TextEditingController();
  TextEditingController timeInputFin = TextEditingController();

  @override
  void dispose() {
    validManager.initDate = DateTime(2023);
    validManager.initTime = TimeOfDay(hour: 00, minute: 00);
    validManager.endTime = TimeOfDay(hour: 00, minute: 00);
    validManager.sameDay = false;
    validManager.previousHour = false;
    validManager.validDates = false;
    validManager.textoAdver = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Regresar",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Historial", style: TextStyle(fontSize: 30),),
              SizedBox(height: 12,),
              Text(
                widget.unidad.desc!,
                textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18)
              ),
              SizedBox(height: 12,),
              Text(
                "Establesca los rangos de inicio y fin de la ruta que desea ver.",
                textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16)
              ),
              SizedBox(height: 32,),
              Container(
                color: Colors.redAccent,
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
                    icon: Icon(Icons.calendar_today), labelText: "Fecha inicio", labelStyle: Theme.of(context).textTheme.bodyLarge),
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime.now());
                  //initDate = selectedDate!;
                  validManager.initDate = selectedDate!;

                  if(!timeInputFin.text.isEmpty){
                    fechaFin == validManager.initDate ? validManager.sameDay = true
                        : validManager.sameDay = false;
                  }

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
                    icon: Icon(Icons.access_time), labelText: "Hora de inicio", labelStyle: Theme.of(context).textTheme.bodyLarge),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? selectedTime = await showMyTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now()
                  );
                  horaInicio = selectedTime!;
                  //initTime = selectedTime;
                  validManager.initTime = selectedTime;

                  String formattedTime = "${selectedTime.hour}:${selectedTime.minute}";
                  setState(() {
                    timeInputInicio.text = formattedTime;
                  });

                  print("---- initTime: ${validManager.initTime}, endTime ${validManager.endTime}");
                  if(isBefore(validManager.initTime, validManager.endTime)) {
                    validManager.previousHour = true;
                  } else {
                    validManager.previousHour = false;
                  }
                  print("---- previous HOUR: ${validManager.previousHour}");
                  validManager.validar();
                },
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                color: Colors.redAccent,
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
                    icon: Icon(Icons.calendar_today), labelText: "Fecha fin", labelStyle: Theme.of(context).textTheme.bodyLarge),
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
                    icon: Icon(Icons.access_time), labelText: "Hora de fin", labelStyle: Theme.of(context).textTheme.bodyLarge),
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
              SizedBox(
                height: 38,
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.redAccent)),
                  onPressed: () {
                    final idUnidad = widget.unidad.id;
                    //ingresar(context);
                    if(dateInputInicio.text.isEmpty || timeInputInicio.text.isEmpty
                        || dateInputFin.text.isEmpty || timeInputFin.text.isEmpty) {
                      showInfoDialog("Campos sin selección", "Debe seleccionar todas las fechas y horas.",
                          "Entendido", context);
                    } else {
                      consultar(context, idUnidad!);
                      //print("Inicio: ${fechaInicio}, ${horaInicio}; Fin: ${fechaFin}, ${horaFin} ");
                    }
                  },
                  child: Text("Ver recorrido", style: TextStyle(color: Colors.white, fontSize: 16),)
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
