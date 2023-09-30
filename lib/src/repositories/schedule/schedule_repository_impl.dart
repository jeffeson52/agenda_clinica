// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:agenda_clinica/src/core/exceptions/repository_exception.dart';
import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/core/fp/nil.dart';
import 'package:agenda_clinica/src/core/restClient/rest_client.dart';
import 'package:agenda_clinica/src/model/schedule_model.dart';
import 'package:dio/dio.dart';

import './schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient restClient;

  ScheduleRepositoryImpl({
    required this.restClient,
  });
  @override
  Future<Either<RepositoryException, Nil>> scheduleClient(
      ({
        String clientName,
        int clinicaId,
        DateTime date,
        int time,
        int userId
      }) scheduleData) async {
    try {
      await restClient.auth.post('/schedules', data: {
        'clinica_id': scheduleData.clinicaId,
        'user_id': scheduleData.userId,
        'client_name': scheduleData.clientName,
        'date': scheduleData.date.toIso8601String(),
        'time': scheduleData.time,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar agendamento', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao agendar horário'));
    }
  }

  @override
  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({DateTime date, int userId}) filter) async {
    try {
      final Response(:List data) = await restClient.auth.get('/schedules',
          queryParameters: {
            'user_id': filter.userId,
            'date': filter.date.toIso8601String()
          });
      final schedules = data.map((s) => ScheduleModel.fromMap(s)).toList();
      return Success(schedules);
    } on DioException catch (e, s) {
      log('Erro ao buscar agendamentos de uma data', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro ao buscar angendamentos de uma data'));
    } on ArgumentError catch (e, s) {
      log('Json inválido', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Json inválido'));
    }
  }
}
