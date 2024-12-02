part of 'command_screen.dart';

/// Variable de inicializacion tardia que contendra el request a la API
late Future<List<CommandModel>> _commandsFuture;

/// Variable que contiene la lista de ocmandos disponibles para cada unidad.
List<CommandModel> comandos = [];