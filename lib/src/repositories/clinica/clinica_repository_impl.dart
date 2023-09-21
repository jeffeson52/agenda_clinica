// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:agenda_clinica/src/core/fp/nil.dart';
import 'package:dio/dio.dart';

import 'package:agenda_clinica/src/core/exceptions/repository_exception.dart';
import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/core/restClient/rest_client.dart';
import 'package:agenda_clinica/src/model/clinica_model.dart';
import 'package:agenda_clinica/src/model/user_model.dart';

import './clinica_repository.dart';

class ClinicaRepositoryImpl implements ClinicaRepository {
  final RestClient restClient;
  ClinicaRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, ClinicaModel>> getMyClinica(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/clinica',
          queryParameters: {'user_id': '#userAuthRef'},
        );
        return Success(ClinicaModel.fromMap(data));

      case UserModelEmployee():
        final Response(:data) =
            await restClient.auth.get('/clinica/${userModel.clinicaId}');
        return Success(ClinicaModel.fromMap(data));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> save(
      ({
        String email,
        String name,
        List<String> openingDays,
        List<int> openingHours
      }) data) async {
    try {
      await restClient.auth.post('/clinica', data: {
        'user_id': '#userAuthRef',
        'name': data.name,
        'email': data.email,
        'opening_days': data.openingDays,
        'opening_hours': data.openingHours,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar clinica', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao registrar clinica'));
    }
  }
}
