import 'package:agenda_clinica/src/core/exceptions/auth_exception.dart';
import 'package:agenda_clinica/src/core/exceptions/repository_exception.dart';
import 'package:agenda_clinica/src/core/fp/either.dart';
import 'package:agenda_clinica/src/core/fp/nil.dart';
import 'package:agenda_clinica/src/model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({String name, String email, String password}) userData,
  );

  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
      int clinicaId);

  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(
      ({
        List<String> workdays,
        List<int> workhours,
      }) userModel);

  Future<Either<RepositoryException, Nil>> registerEmployee(
      ({
        int clinicaId,
        String name,
        String email,
        String password,
        List<String> workdays,
        List<int> workhours,
      }) userModel);
}
