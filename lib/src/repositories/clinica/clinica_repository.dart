import 'package:agenda_clinica/src/core/exceptions/repository_exception.dart';
import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/model/clinica_model.dart';
import 'package:agenda_clinica/src/model/user_model.dart';

abstract interface class ClinicaRepository {
  Future<Either<RepositoryException, ClinicaModel>> getMyClinica(UserModel userModel);
}