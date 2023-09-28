import 'package:agenda_clinica/src/core/exceptions/repository_exception.dart';
import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/core/fp/nil.dart';

abstract interface class ScheduleRepository {
Future<Either<RepositoryException, Nil>> scheduleClient(
  ({
    int clinicaId,
    int userId,
    String clientName,
    DateTime date,
    int time
  }) scheduleData);
}