part of 'history_screen.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
HistoryManager validManager = HistoryManager();
DateTime fechaInicio = DateTime.now();
TimeOfDay horaInicio = TimeOfDay.now();
DateTime fechaFin = DateTime.now();
TimeOfDay horaFin = TimeOfDay.now();

final RestorableDateTime pickedDate = RestorableDateTime(DateTime(2024, 07, 25));

Future<void> showMyPIcker (BuildContext context, int tipo) async {
  DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024)
  );
  if(tipo == 0) {
    fechaInicio = selectedDate!;
  } else {
    fechaFin = selectedDate!;
  }
}

Future<TimeOfDay?> showMyTimePicker({
  /** Lista de parametros que utiliza el TimePickerDialog */
  required BuildContext context,
  required TimeOfDay initialTime,
  TransitionBuilder? builder,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  bool useRootNavigator = true,
  TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
  String? cancelText,
  String? confirmText,
  String? helpText,
  String? errorInvalidText,
  String? hourLabelText,
  String? minuteLabelText,
  RouteSettings? routeSettings,
  EntryModeChangeCallback? onEntryModeChanged,
  Offset? anchorPoint,
  Orientation? orientation,
}) async {
  assert(debugCheckHasMaterialLocalizations(context));

  /** Contruccion del Wideget del TimePickerDialog con la asignacion de las variables
   * con los valores de los pramatros previamente declarados
   * */
  final Widget dialog = TimePickerDialog(
    initialTime: initialTime,
    initialEntryMode: initialEntryMode,
    cancelText: cancelText,
    confirmText: confirmText,
    helpText: helpText,
    errorInvalidText: errorInvalidText,
    hourLabelText: hourLabelText,
    minuteLabelText: minuteLabelText,
    orientation: orientation,
    onEntryModeChanged: onEntryModeChanged,
  );
  return showDialog<TimeOfDay>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
  );
}
/** Metodo envcargado de revistar si la Hora de fin es previa a la de inicio */

isBefore(TimeOfDay ini, TimeOfDay fin) {
//23 < 19 = false || 19 < 23  = true
//15 < 20 = true  || 20 < 15 = false
  if (fin.hour < ini.hour) {
    return true; // es anterior (menor)
  } else if (ini.hour == fin.hour && fin.minute < ini.minute) {
    return true;
  }
  return false;
}

showInfoDialog (String mTitle, String content, String mButton, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(mTitle),
        content: Text(content),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, mButton),
              child: Text(mButton)
          ),
        ],
      )
  );
}

/** Metodo que se encarga de validar que los datos esten correctos antes a abrir la siguiente pantalla
 * que seria la del Mapa del historial para mostrar la ruta de la unidad.
 * */
consultar(BuildContext context, String id) {
  print("PreviosHour: ${validManager.previousHour}, SameDay: ${validManager.sameDay}, VALID: ${validManager.validDates}");
  if(!validManager.validDates) {
    showInfoDialog("Horas inconsistentes", "La hora de fin no puede ser anterior a la hora de inicio.",
        "Entendido", GlobalContext.navKey.currentContext!);
    return;
  }

  /** Se convierte las fechas a un formato especifico que requerido para realizar la consulta a la API
   * del histiral de la unidad.
   * */
  DateTime finalDateTimeInicio = DateTime(fechaInicio.year, fechaInicio.month, fechaInicio.day, horaInicio.hour, horaInicio.minute);
  DateTime finalDateTimeFin = DateTime(fechaFin.year, fechaFin.month, fechaFin.day, horaFin.hour, horaFin.minute);

  String fmtFinalDateTimeInicio = DateFormat("yyyy-MM-dd HH:mm:ss").format(finalDateTimeInicio);
  String fmtFinalDateTimeFin = DateFormat("yyyy-MM-dd HH:mm:ss").format(finalDateTimeFin);

  print("OBJETOS FormatDateTimes: ${fmtFinalDateTimeInicio}, ${fmtFinalDateTimeFin}");

  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapHistoryScreen(id: id, fechaIni: fmtFinalDateTimeInicio, fechaFin: fmtFinalDateTimeFin))
  );
}
